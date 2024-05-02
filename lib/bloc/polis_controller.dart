import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/customer_controller.dart';
import 'package:insurance/bloc/dashboard_controller.dart';
import 'package:insurance/bloc/login_controller.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/bloc/ternak_controller.dart';
import 'package:insurance/model/polis.dart';
import 'package:insurance/model/sppa_header.dart';
import 'package:insurance/model/ternak_sapi.dart';
import 'package:insurance/util/constants.dart' as constant;
import 'package:insurance/util/constants.dart';
import 'package:intl/intl.dart';

class PolisController extends GetxController {
  //
  LoginController loginController = Get.find();
  SppaHeaderController sppaController = Get.find();
  CustomerController custController = Get.find();
  TernakController ternakController = Get.put(TernakController());
  //
  RxList<Polis> listAktifPolis = <Polis>[].obs;
  RxList<Polis> listHelperPolis = <Polis>[].obs;

  RxBool listAktifPolisLoaded = false.obs;

  Rx<Polis> thePolis = Polis().obs;
  RxBool thePolisLoaded = false.obs;

  RxInt thePolisStatus = 0.obs;

  final GlobalKey<FormState> polisFormKey = GlobalKey<FormState>();
  final TextEditingController noPolisController = TextEditingController();
  final TextEditingController tglPolisController = TextEditingController();
  final TextEditingController namaPolisNoController = TextEditingController();
  final TextEditingController alamatCustController = TextEditingController();
  final TextEditingController objectPolisController = TextEditingController();
  final TextEditingController alamatObjectController = TextEditingController();
  final TextEditingController hargaPertanggunganController =
      TextEditingController();
  final TextEditingController tglAwalController = TextEditingController();
  final TextEditingController tglAkhirController = TextEditingController();
  final TextEditingController nilaiPremiController = TextEditingController();
  final TextEditingController biayaAdminController = TextEditingController();
  final TextEditingController beaMeteraiController = TextEditingController();
  final TextEditingController kantorCabangController = TextEditingController();
  final TextEditingController totalBiayaController = TextEditingController();

  RxBool makeEdit = false.obs;
  var pickedDate = DateTime.now().obs;
  RxBool pickedDateIsDone = false.obs;
  RxDouble totalBiaya = 0.0.obs;
  var client = http.Client();

  RxBool tagihBtnVis = true.obs;
  RxBool bayarBtnVis = true.obs;
  RxBool probBtnVis = true.obs;
  RxBool aktifBtnVis = true.obs;
  RxBool saveBtnVis = true.obs;
  RxBool editBtnVis = true.obs;

  void onInit() {
    super.onInit();
    nilaiPremiController.text = '0';
    biayaAdminController.text = '0';
    beaMeteraiController.text = '0';
  }

  String polisStatusDesc(int status) {
    switch (status) {
      case 1:
        return 'Baru';
      case 2:
        return 'Ditagih';
      case 3:
        return 'Dibayar';
      case 4:
        return 'Kurang/Lebih Bayar';
      case 5:
        return 'Aktif';
      default:
        return 'undef';
    }
  }

  void copyFromSppa() {
    print('copy from sppa dulu');
    tglPolisController.text =
        DateFormat("dd-MMM-yyyy").format(pickedDate.value);
    thePolis.value.tglPolis = tglPolisController.text;
    thePolis.value.tglPolisMillis = pickedDate.value.millisecondsSinceEpoch;
    namaPolisNoController.text =
        '${custController.theCustomer.value.chain} qq ${custController.theCustomer.value.name}';
    alamatCustController.text =
        '${custController.theCustomer.value.jalan}, RT ${custController.theCustomer.value.rt} / RW ${custController.theCustomer.value.rw}, ${custController.theCustomer.value.kelurahan}, ${custController.theCustomer.value.kecamatan},${custController.theCustomer.value.kabupaten}';
    hargaPertanggunganController.text =
        sppaController.sppaHeader.value.nilaiPertanggungan.toString();
    tglAwalController.text = tglPolisController.text;
    thePolis.value.tglAwalPolis = tglPolisController.text;
    thePolis.value.tglAwalPolisMillis = thePolis.value.tglPolisMillis;
    tglAkhirController.text = DateFormat("dd-MMM-yyyy")
        .format(pickedDate.value.add(Duration(days: 365)));
    thePolis.value.tglAkhirPolis = tglAkhirController.text;
    thePolis.value.tglAkhirPolisMillis =
        pickedDate.value.add(Duration(days: 365)).millisecondsSinceEpoch;
    nilaiPremiController.text =
        sppaController.sppaHeader.value.premiAmount.toString();
    biayaAdminController.text = '50000';
    beaMeteraiController.text = '12000';
    kantorCabangController.text = 'Kantor Pusat';
    totalBiaya.value = sppaController.sppaHeader.value.premiAmount! + 62000;
  }

  void cekPolisBtnVisible() {
    // print(
    //    'in check button ${loginController.check.value.roles} ${sppaHeader.value.statusSppa}');
    if (loginController.check.value.roles == 'ROLE_CUSTOMER') {
      switch (thePolisStatus.value) {
        default:
          saveBtnVis.value = false;
          editBtnVis.value = false;
          tagihBtnVis.value = false;
          bayarBtnVis.value = false;
          aktifBtnVis.value = false;
          probBtnVis.value = false;
          break;
      }
    }

    if (loginController.check.value.roles == 'ROLE_SALES') {
      tagihBtnVis.value = false;
      aktifBtnVis.value = false;
      probBtnVis.value = false;
      saveBtnVis.value = false;
      editBtnVis.value = false;

      switch (thePolisStatus.value) {
        case 2:
          bayarBtnVis.value = true;
          break;
        case 3:
          bayarBtnVis.value = false;
          break;
        case 4:
          bayarBtnVis.value = true;
        case 5:
          bayarBtnVis.value = false;
          break;
        default:
          bayarBtnVis.value = false;
          break;
      }
    }

    if (loginController.check.value.roles == 'ROLE_MARKETING') {
      switch (thePolisStatus.value) {
        default:
          saveBtnVis.value = false;
          editBtnVis.value = false;
          tagihBtnVis.value = false;
          bayarBtnVis.value = false;
          aktifBtnVis.value = false;
          probBtnVis.value = false;
          break;
      }
    }

    if (loginController.check.value.roles == 'ROLE_BROKER') {
      bayarBtnVis.value = false;

      switch (thePolisStatus.value) {
        case 0:
          saveBtnVis.value = true;
          break;
        case 1:
          saveBtnVis.value = true;
          editBtnVis.value = true;
          tagihBtnVis.value = true;
          bayarBtnVis.value = false;
          aktifBtnVis.value = false;
          probBtnVis.value = false;
          break;
        case 2:
          saveBtnVis.value = false;
          editBtnVis.value = false;
          tagihBtnVis.value = false;
          bayarBtnVis.value = false;
          aktifBtnVis.value = false;
          probBtnVis.value = false;
          break;
        case 3:
          saveBtnVis.value = false;
          editBtnVis.value = false;
          tagihBtnVis.value = false;
          bayarBtnVis.value = false;
          aktifBtnVis.value = true;
          probBtnVis.value = true;
          break;
        case 4:
          saveBtnVis.value = false;
          editBtnVis.value = false;
          tagihBtnVis.value = false;
          bayarBtnVis.value = false;
          aktifBtnVis.value = false;
          probBtnVis.value = false;
          break;
        case 5:
          saveBtnVis.value = false;
          editBtnVis.value = false;
          tagihBtnVis.value = false;
          bayarBtnVis.value = false;
          aktifBtnVis.value = false;
          probBtnVis.value = false;
          break;
        default:
          saveBtnVis.value = false;
          editBtnVis.value = false;
          tagihBtnVis.value = false;
          bayarBtnVis.value = false;
          aktifBtnVis.value = false;
          probBtnVis.value = false;
          break;
      }
    }
  }

  Future<DateTime?> chooseDate() async {
    pickedDateIsDone.value = false;
    var getDate = await showDatePicker(
      context: Get.context!,
      initialDate: pickedDate.value, //get today's date
      firstDate: DateTime(
          2020), //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime.now().add(Duration(days: 720)),
    );
    if (getDate != null && getDate != pickedDate.value) {
      pickedDate.value = getDate;
      pickedDateIsDone.value = true;
    }

    return getDate;
  }

  void updateTotalBiaya() {
    if (nilaiPremiController.text.isNum &&
        biayaAdminController.text.isNum &&
        beaMeteraiController.text.isNum) {
      totalBiaya.value = double.parse(nilaiPremiController.text) +
          double.parse(biayaAdminController.text) +
          double.parse(beaMeteraiController.text);
    }
  }

  void createPolis() {}

  void getPolisWithPolisId(String polisId) async {
    // must include
    http.Response response;

    var url = Uri.parse(baseUrl + '/Polis/$polisId');
    print(baseUrl + '/Polis/$polisId');

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      // print('responseBody ${responseBody}');
      thePolis.value = Polis.fromJson(responseBody);
      thePolisLoaded.value = true;
      thePolisStatus.value = thePolis.value.statusPolis;
      totalBiaya.value = thePolis.value.premiAmount +
          thePolis.value.biayaAdministrasi +
          thePolis.value.beaMaterei;
      print('get polis from id $polisId berhasil  ');
    } else {
      print('get polis from id $polisId gagal : ${response.statusCode}');
    }
  }

  void savePolis() async {
    var url;
    String body;
    String param1;
    var client = http.Client();
    var responseBody;
    http.Response response;
    TernakSapi theTernak = TernakSapi();
    int errorCount = 0;

    print(
        'save polis ${thePolis.value.namaTertanggung} dari Sppa ${thePolis.value.sppaId}');

    // 1. insert Polis
    url = Uri.parse('$baseUrl/Polis');
    body = json.encode(thePolis.value);

    response = await client.post(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed
    // print('status: ${response.statusCode}');
    // print('body: ${response.body}');
    if (response.statusCode == 201) {
      print('Post Polis ${thePolis.value.polisDocId} berhasil');

      responseBody = jsonDecode(response.body);
      thePolis.value.id = responseBody['id'];
    } else {
      errorCount++;
      print(
          'Post Polis ${thePolis.value.polisDocId} gagal ${response.statusCode}');
    }

    // 2. update SppaHeader

    sppaController.sppaHeader.value.polisId = thePolis.value.id;
    sppaController.sppaHeader.value.statusSppa = 10;

    param1 = '/${sppaController.sppaHeader.value.id}';
    print('$baseUrl/SppaHeader$param1');
    url = Uri.parse('$baseUrl/SppaHeader$param1');
    body = json.encode(sppaController.sppaHeader.value);

    response = await client.put(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed

    if (response.statusCode == 200) {
      print('put SppaHeader ${sppaController.sppaHeader.value.id} berhasil');
    } else {
      errorCount++;
      print(
          'put SppaHeader ${sppaController.sppaHeader.value.id} gagal ${response.statusCode} ');
    }

    // 3. update Status
    // get sppaStatus first
    param1 = '?sppaId=${sppaController.sppaHeader.value.id}';
    url = Uri.parse(baseUrl + '/SppaStatus' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      //print(responseBody);
      // asumsi cuma ada 1 sppaStatus
      sppaController.sppaStatus.value = SppaStatus.fromJson(responseBody[0]);
      print(
          'get sppaStatus from sppaId ${sppaController.sppaHeader.value.id} berhasil ${sppaController.sppaStatus.value.id}');

      // update sppaStatus
      param1 = '/${sppaController.sppaStatus.value.id}';
      print('$baseUrl/SppaStatus$param1');
      url = Uri.parse('$baseUrl/SppaStatus$param1');
      final saatIni = DateTime.now();

      sppaController.sppaStatus.value.statusSppa = 10;
      sppaController.sppaStatus.value.tglResponseAsuransi =
          thePolis.value.tglPolis;
      sppaController.sppaStatus.value.tglResponseAsuransiMillis =
          thePolis.value.tglPolisMillis;
      sppaController.sppaStatus.value.statusResponseAsuransi = 1; // accepted
      sppaController.sppaStatus.value.tglLastUpdate =
          DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaController.sppaStatus.value.tglLastUpdateMillis =
          saatIni.millisecondsSinceEpoch;

      body = json.encode(sppaController.sppaStatus.value);

      response = await client.put(url, body: body, headers: {
        'Content-Type': 'application/json'
      }); // no authentication needed

      if (response.statusCode == 200) {
        print(
            'Put sppaStatus for ${sppaController.sppaStatus.value.id} berhasil ');
      } else {
        errorCount++;
        print(
            'put SppaStatus ${sppaController.sppaStatus.value.id} gagal ${response.statusCode} ');
      }
    } else {
      errorCount++;
      print('cant get sppaStatus for ${sppaController.sppaStatus.value.id}');
    }

    // 4. update ternak
    // get ternak dulu

    param1 = '?sppaId=${sppaController.sppaHeader.value.id}';
    url = Uri.parse(baseUrl + '/TernakSapi' + param1);
    print(baseUrl + '/TernakSapi' + param1);

    response = await client.get(url);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print(responseBodyStatus);
      for (var i = 0; i < responseBody.length; i++) {
        theTernak = TernakSapi.fromJson(responseBody[i]);
        theTernak.polisId = thePolis.value.id;
        theTernak.status = 1;

        param1 = '/${theTernak.id}';
        print('$baseUrl/TernakSapi$param1');
        url = Uri.parse('$baseUrl/TernakSapi$param1');

        body = json.encode(theTernak);

        response = await client.put(url, body: body, headers: {
          'Content-Type': 'application/json'
        }); // no authentication needed

        if (response.statusCode == 200) {
          print(
              'put ${i + 1}. ternak sapi ${ternakController.listTernak[i].id} berhasil');
        } else {
          errorCount++;

          print(
              'put ${i + 1}. ternak sapi ${ternakController.listTernak[i].id} gagal ${response.statusCode}');
        }
      }
    } else {
      print('cant get ternakSapi for ${sppaController.sppaHeader.value.id}');
    }
    if (errorCount > 0) {
      print('ada $errorCount error dalam saving polis');
    } else {
      print('saving polis berhasil tanpa error');
      final dashboardController = Get.find<DashboardController>();
      var idx = dashboardController.listAktifSppa
          .indexWhere((el) => el.id == sppaController.sppaHeader.value.id);
      print('di listaktifsppa posisi ke $idx');
      dashboardController.listAktifSppa[idx].statusSppa = 10;
      dashboardController.listAktifSppa.refresh();

      idx = sppaController.listHelperSppa
          .indexWhere((el) => el.id == sppaController.sppaHeader.value.id);
      print('di listHelpersppa posisi ke $idx');
      sppaController.listHelperSppa[idx].statusSppa = 10;

      sppaController.listHelperSppa.refresh();
      sppaController.sppaStatusDisp.value = 10;
    }
    Get.back();
  }
}
