import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:insurance/bloc/dashboard_controller.dart';
import 'package:insurance/bloc/login_controller.dart';
import 'package:insurance/model/sppa_perluasan.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';
import '/bloc/produk_controller.dart';
import '/model/info_jastan.dart';
import '/model/customer.dart';
import '/model/products.dart';
import '/model/sppa_header.dart';
import 'package:intl/intl.dart';
import '/util/constants.dart' as constant;
//  1 month = 2629745046 milliseconds

class SppaHeaderController extends GetxController {
  final GlobalKey<FormState> sppaFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> tolakFormKey = GlobalKey<FormState>();

  FocusNode fn1 = FocusNode();
  FocusNode fn2 = FocusNode();

  final appProdukController = Get.find<ProdukController>();
  final loginController = Get.find<LoginController>();

  Rx<TextEditingController> customerController = TextEditingController().obs;
  late TextEditingController produkController;
  late TextEditingController tolakNoteController;

  ProdukAsuransi selected = ProdukAsuransi();

  var sppaHeader = SppaHeader();
  RxInt sppaHeaderStatusObs = 0.obs; // manage display

  var sppaStatus = SppaStatus();

  RxList<SppaPerluasanRisiko> listPerluasanRisikoSppa =
      <SppaPerluasanRisiko>[].obs;
  RxBool listPerluasanRisikoSppaLoaded = false.obs;

  RxString customerName = ''.obs; // just use theCustomer
  String baseUrl = constant.baseUrl;
  var client = http.Client();
  var custOk = false.obs;
  var prodOk = false.obs;
  var nextButOk = true.obs;
  var theCustomer = Customer().obs;
  var isNewSppa = true.obs;
  ProdukAsuransi? initProduct;
  RxDouble totalRate = 0.0.obs;

  // btn visibility flag
  RxBool batalBtnVis = true.obs;
  RxBool editBtnVis = true.obs;
  RxBool submitBtnVis = true.obs;
  RxBool tolakBtnVis = false.obs;

  // action flag
  RxBool jadiBatal = false.obs;
  RxBool jadiTolak = false.obs;

  // ******************* from addInfo *********************************
  final GlobalKey<FormState> addInfoFormKey = GlobalKey<FormState>();

  late TextEditingController kandangController,
      mgmtKandangController,
      sisPemeliharaanController,
      sisPakanController,
      mgmtPakanController,
      mgmtKesehatanController;

  // final sppaController = Get.find<SppaHeaderController>();
  Rx<InfoAtsJasTan> infoAts = InfoAtsJasTan().obs;
  String initKriteriaPemeliharaan = '';
  String initSistemPakan = '';

  final List<String> listKriteriaPemeliharaan = <String>[
    'Ekstensif',
    'Semi Intensif',
    'Intensif'
  ];
  final List<String> listSistemPakan = <String>[
    'Pasture Fattening',
    'Dry Lot',
    'Kombinasi'
  ];

// *********************************************************************

  @override
  void onInit() {
    super.onInit();
    fn1.addListener(() {
      if (fn1.hasFocus) {
        customerController.value.text = '';
      }
      if (!fn1.hasFocus) {
        validateCustomer();
      }
    });

    // fn2.addListener(() {
    //   if (!fn2.hasFocus) {
    //     validateProduct();
    //   }
    // });

    produkController = TextEditingController();
    appProdukController.getProdukAsuransiAll();

    kandangController = TextEditingController();
    mgmtKandangController = TextEditingController();
    sisPemeliharaanController = TextEditingController();
    sisPakanController = TextEditingController();
    mgmtPakanController = TextEditingController();
    mgmtKesehatanController = TextEditingController();

    tolakNoteController = TextEditingController();

    print('done init sppa controller');
  }

  @override
  void onClose() {
    customerController.value.dispose();
    produkController.dispose();

    kandangController.dispose();
    mgmtKandangController.dispose();
    sisPemeliharaanController.dispose();
    sisPakanController.dispose();
    mgmtPakanController.dispose();
    mgmtKesehatanController.dispose();
  }

  cekBtnVisible() {
    if (loginController.check.value.roles == 'ROLE_CUSTOMER') {
      if (sppaHeader.statusSppa == 1 || sppaHeader.statusSppa == 3) {
        batalBtnVis.value = true;
      } else {
        batalBtnVis.value = false;
      }
    } else {
      batalBtnVis.value = false;
    }

    if (loginController.check.value.roles == 'ROLE_CUSTOMER') {
      if (sppaHeader.statusSppa == 1 || sppaHeader.statusSppa == 3) {
        editBtnVis.value = true;
      } else {
        editBtnVis.value = false;
      }
    } else {
      editBtnVis.value = false;
    }

    if (loginController.check.value.roles == 'ROLE_CUSTOMER') {
      if (sppaHeader.statusSppa == 1 || sppaHeader.statusSppa == 3) {
        submitBtnVis.value = true;
      } else {
        submitBtnVis.value = false;
      }
    } else {
      if (loginController.check.value.roles == 'ROLE_ADMIN') {
        if (sppaHeader.statusSppa == 2) {
          submitBtnVis.value = true;
        } else {
          submitBtnVis.value = false;
        }
      } else {
        submitBtnVis.value = false;
      }

      if (loginController.check.value.roles == 'ROLE_ADMIN') {
        if (sppaHeader.statusSppa == 2) {
          tolakBtnVis.value = true;
        } else {
          tolakBtnVis.value = false;
        }
      }

      print('btn batal jadi ${batalBtnVis.value}');
      print('btn edit jadi ${editBtnVis.value}');
      print('btn submit jadi ${submitBtnVis.value}');
      print('btn tolak jadi ${tolakBtnVis.value}');
    }
  }

  String sppaStatusDesc(int status) {
    switch (status) {
      case 1:
        return 'Baru';
      case 2:
        return 'Submit 1';
      case 3:
        return 'Tidak Lengkap';
      case 4:
        return 'Submit 2';
      case 5:
        return 'Tidak Lengkap';
      case 6:
        return 'Submit 3';
      case 7:
        return 'Proses Asuransi';
      case 8:
        return 'Polis';
      case 9:
        return 'Tolak';
      case 10:
        return 'Batal';
      default:
        return 'Tidak Dikenal';
    }
  }

  validateCustomer() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print('di customer validate ${customerController.value.text}');

    final String param1 = '?customerId=${customerController.value.text}';

    print('$baseUrl/Customer$param1');
    var url = Uri.parse('$baseUrl/Customer$param1');
    http.Response response = await client.get(url,
        headers: requestHeaders); // no authentication needed
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
//      print('Response body: ${responseBody}');
//      print('response item ${responseBody.length}');
      if (responseBody.length == 1) {
//        print('response item 1 ${responseBody[0]}');
        theCustomer.value = Customer.fromJson(responseBody[0]);
        if (theCustomer.value.customerId == customerController.value.text) {
          custOk.value = true;
          sppaHeader.customerId = customerController.value.text;
          sppaHeader.salesId = theCustomer.value.salesId;
          sppaHeader.marketingId = theCustomer.value.marketingId;
          sppaHeader.brokerId = theCustomer.value.brokerId;
          customerController.value.text =
              '${customerController.value.text} - ${theCustomer.value.fullName!}';
//          print(
//              'Customer OK ${newSppaHeader.customerId} broker:${newSppaHeader.brokerId}');
        } else {
          print('error: conflicting data ${theCustomer.value.customerId}');
        }
      } else {
        customerController.value.text =
            '${customerController.value.text} - tidak terdaftar';
      }
    } else {
      print(response.statusCode.toString());
    }
  }

  void selectProduct(ProdukAsuransi aProd) {
    // TODO reconcile selected only from productController
    if (isNewSppa.value ||
        (!isNewSppa.value && aProd.productCode != sppaHeader.produkCode)) {
      selected = aProd; // selected of SppaController

      appProdukController.selected.value =
          aProd; // selected of ProductController
      // print('in selectProduk selected in sppa is: ${selected.productName}');
      // print('in selectProduk selected in produk is: ${selected.productName}');
      // get customer detail to display later
      sppaHeader.produkCode = aProd.productCode;
      sppaHeader.produkName = aProd.productName;
      sppaHeader.asuransiName = aProd.codeAsuransi;
      sppaHeader.kategori = aProd.productKategori;
      sppaHeader.subKategori = aProd.productSubKategori;
      sppaHeader.premiRate = aProd.ratePremi;
      sppaHeader.tenor = aProd.tenor;
      sppaHeader.statusSppa = 1;
      prodOk.value = true;
      sppaHeaderStatusObs.value = 1;
      // prepare perluasanRisiko nya
      getPerluasanRisikoSppa();
    }
  }

  validateNextButton() {
    if (custOk.value && prodOk.value) {
      nextButOk.value = true;
    }
  }

  void saveHeader() async {
    // Sppa Header first
    var url = Uri.parse('$baseUrl/SppaHeader');
    var body = json.encode(sppaHeader);
//    print('body : $body');
    http.Response response = await client.post(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed
    // print('status: ${response.statusCode}');
    // print('body: ${response.body}');
    if (response.statusCode == 201) {
      print('post header berhasil');
      var responseBody = jsonDecode(response.body);
      sppaHeader.id = responseBody["id"];

      // SppaStatus second

      // SppaStatus
      final saatIni = DateTime.now();
      sppaStatus.sppaId = sppaHeader.id;
      sppaStatus.statusSppa = 1;
      sppaStatus.tglCreated = DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.tglCreatedMillis = saatIni.millisecondsSinceEpoch;

      url = Uri.parse('$baseUrl/SppaStatus');
      body = json.encode(sppaStatus);

      // print('body : $body');
      response = await client.post(url, body: body, headers: {
        'Content-Type': 'application/json'
      }); // no authentication needed
      // print('status: ${response.statusCode}');
      // print('body: ${response.body}');

      if (response.statusCode == 201) {
        print('post status berhasil');
        responseBody = jsonDecode(response.body);
        sppaStatus.id = responseBody["id"];

        // enable button to next step
        validateNextButton();

        savePerluasanRisikoSppa();

        saveInfoData();
      } else {
        print(response.statusCode.toString());
      }
    } else {
      print(response.statusCode.toString());
    }
  }

  void updateHeader() async {
    // also update SppaStatus
    // first update addInfo
    // second update perluasanRisiko
    // adjust totalRate
    // then update header & status
    Uri url;
    String body;
    bool updateHeader = false;

    if (infoDataChanged()) {
      print('add info changed');
      updateInfoData();
      updateHeader = true;
    }

    if (perluasanRisikoSppaChanged()) {
      print('perluasan risiko changed');
      deletePerluasanRisikoSppa();
      savePerluasanRisikoSppa();
      updateHeader = true;
    }

    if (sppaHeader.produkName == produkController.text &&
        sppaHeader.customerId == customerController.value.text) {
      print('header no change');
    } else {
      print('header changed');
      updateHeader = true;
    }

    if (updateHeader) {
      // recalculate premi amount just incase perluasan changed, ternak tidak.
      sppaHeader.premiAmount =
          sppaHeader.nilaiPertanggungan! * sppaHeader.premiRate!;

      url = Uri.parse('$baseUrl/SppaHeader/${sppaHeader.id}');
      body = json.encode(sppaHeader);

//    print('body : $body');
      http.Response response = await client.put(url, body: body, headers: {
        'Content-Type': 'application/json'
      }); // no authentication needed
      // print('status: ${response.statusCode}');
      // print('body: ${response.body}');

      if (response.statusCode == 200) {
        print('put header berhasil');

        // SppaStatus
        final saatIni = DateTime.now();
        sppaStatus.tglLastUpdate = DateFormat("dd-MMM-yyyy").format(saatIni);
        sppaStatus.tglLastUpdateMillis = saatIni.millisecondsSinceEpoch;

        url = Uri.parse('$baseUrl/SppaStatus/${sppaStatus.id}');
        body = json.encode(sppaStatus);
        // print('body : $body');
        response = await client.put(url, body: body, headers: {
          'Content-Type': 'application/json'
        }); // no authentication needed
        // print('status: ${response.statusCode}');
        // print('body: ${response.body}');
        if (response.statusCode == 200) {
          print('put status berhasil');
          // var responseBody = jsonDecode(response.body);
          // print('Return Response body: ${responseBody}');
          // print('sppa header id :${responseBody["id"]}');

          // enable button to next step
          validateNextButton();
        } else {
          print(response.statusCode.toString());
        }
      } else {
        print(response.statusCode.toString());
      }
    }
  }

  void updateStatus(int newStatus, String recapId) async {
    // update sppaStatus and also sppaStatus in SppaHeader
    //  showing progress on processing sppa only
    Uri url;
    String body;
    http.Response response;
    // bool updateHeader = false;

    // SppaStatus
    final saatIni = DateTime.now();
    if (newStatus == 5) {
      sppaStatus.statusSppa = newStatus;
      sppaStatus.recapSppaId = recapId;
      sppaStatus.tglRecap = DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.tglRecapMillis = saatIni.millisecondsSinceEpoch;
      sppaStatus.tglLastUpdate = sppaStatus.tglRecap;
      sppaStatus.tglLastUpdateMillis = sppaStatus.tglRecapMillis;

      url = Uri.parse('$baseUrl/SppaStatus/${sppaStatus.id}');
      body = json.encode(sppaStatus);
      // print('body : $body');
      response = await client.put(url, body: body, headers: {
        'Content-Type': 'application/json'
      }); // no authentication needed

      if (response.statusCode == 200) {
        print('put status recap berhasil');

        // update header
        sppaHeader.statusSppa = newStatus;
        url = Uri.parse('$baseUrl/SppaHeader/${sppaHeader.id}');
        body = json.encode(sppaHeader);

        // print('body : $body');
        response = await client.put(url, body: body, headers: {
          'Content-Type': 'application/json'
        }); // no authentication needed

        if (response.statusCode == 200) {
          print('put header recap berhasil');
        } else {
          print('put header recap gagal ${response.statusCode.toString()}');
        }
      } else {
        print('put status recap gagal ${response.statusCode.toString()}');
      }
    }
  }

  void getPerluasanRisikoSppa() async {
    // this is for existing sppa, so set up the prodController.listPerluasanRisiko too !
    String param1, param2, param3;
    http.Response response;

    if (!isNewSppa.value) {
      // clear list to ensure no duplicate
      listPerluasanRisikoSppa.clear();

      param1 = '?sppaId=${sppaHeader.id}';

      //print(baseUrl + '/SppaPerluasanRisiko' + param1);
      var url = Uri.parse(baseUrl + '/SppaPerluasanRisiko' + param1);
      listPerluasanRisikoSppaLoaded.value = false;
      response = await client.get(url); // no authentication needed
      if (response.statusCode == 200) {
        var responseBodySppa = jsonDecode(response.body);
        //print(responseBodySppa);
        for (var i = 0; i < responseBodySppa.length; i++) {
          listPerluasanRisikoSppa
              .add(SppaPerluasanRisiko.fromJson(responseBodySppa[i]));
          // print(
          //     'add ${i + 1}  perluasan : ${listPerluasanRisikoSppa[i].namaPerluasanRisiko}');
        }
        listPerluasanRisikoSppaLoaded.value = true;
      }
    }
    // print(
    //     'rebuild listperluasan risiko utk: ${appProdukController.selected.value.productName}');
    appProdukController.listPerluasanRisiko.clear();
    appProdukController.listPerluasanJaminanLoaded.value = false;
    param1 = '?kategori=${appProdukController.selected.value.productKategori}';
    param2 =
        '&subKategori=${appProdukController.selected.value.productSubKategori}';
    param3 = '&codeAsuransi=${appProdukController.selected.value.codeAsuransi}';

    //print(baseUrl + '/PerluasanRisiko' + param1 + param2 + param3);
    var url =
        Uri.parse(baseUrl + '/PerluasanRisiko' + param1 + param2 + param3);

    response = await client.get(url); // no authentication needed
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      for (var i = 0; i < responseBody.length; i++) {
        appProdukController.listPerluasanRisiko
            .add(PerluasanRisiko.fromJson(responseBody[i]));
      }
      // print(
      //     'add ${appProdukController.listPerluasanRisiko.length} perluasan risiko');
      appProdukController.listPerluasanJaminanLoaded.value = true;

      if (!isNewSppa.value) {
        print('matching sppa perluasan ada ${listPerluasanRisikoSppa.length}');

        for (var i = 0;
            i < appProdukController.listPerluasanRisiko.length;
            i++) {
          // set selected is true if exist
          var idx = listPerluasanRisikoSppa.indexWhere((el) =>
              el.namaPerluasanRisiko ==
              appProdukController.listPerluasanRisiko[i].namaPerluasanRisiko);
          if (idx != -1) {
            // print(
            //     'perluasan selected: ${appProdukController.listPerluasanRisiko[i].namaPerluasanRisiko}');
            appProdukController.listPerluasanRisiko[i].selected = true;
          }
        }
      }
    } else {
      print(response.statusCode.toString());
    }
  }
  // set up the prodController.listPerluasanRisiko too

  void savePerluasanRisikoSppa() async {
    // save all items in appProdukController.listPerluasanRisiko with selected=true
    SppaPerluasanRisiko newPerluasan = SppaPerluasanRisiko();

    var url = Uri.parse('$baseUrl/SppaPerluasanRisiko');

    for (var i = 0; i < appProdukController.listPerluasanRisiko.length; i++) {
      if (appProdukController.listPerluasanRisiko[i].selected!) {
        newPerluasan.sppaId = sppaHeader.id;
        newPerluasan.namaPerluasanRisiko =
            appProdukController.listPerluasanRisiko[i].namaPerluasanRisiko;
        newPerluasan.rate = appProdukController.listPerluasanRisiko[i].rate;

        var body = json.encode(newPerluasan);
        http.Response response = await client.post(url, body: body, headers: {
          'Content-Type': 'application/json'
        }); // no authentication needed
        if (response.statusCode == 201) {
          print('post perluasan berhasil');
          var responseBody = jsonDecode(response.body);
          // print('Return Response body: ${responseBody}');
          newPerluasan.id = responseBody["id"];
          listPerluasanRisikoSppa.add(newPerluasan);
        }
      }
    }
  }

  bool perluasanRisikoSppaChanged() {
    bool hasChanged = false;
    // print(
    //     'perluasan produk length ${appProdukController.listPerluasanRisiko.length}');
    // print(
    //     'perluasan produk dipilih length ${appProdukController.listPerluasanRisiko.where((e) => e.selected!).length}');
    // print('perluasan sppa length ${listPerluasanRisikoSppa.length}');

    for (var i = 0; i < appProdukController.listPerluasanRisiko.length; i++) {
      //print('cek yang ke $i');
      if (appProdukController.listPerluasanRisiko[i].selected!) {
        // print(
        //     '${appProdukController.listPerluasanRisiko[i].namaPerluasanRisiko} dipilih');
        if (listPerluasanRisikoSppa.indexWhere((element) =>
                element.namaPerluasanRisiko ==
                appProdukController
                    .listPerluasanRisiko[i].namaPerluasanRisiko) ==
            -1) {
          hasChanged = true;
          // print(
          //     '${appProdukController.listPerluasanRisiko[i].namaPerluasanRisiko} nggak ada di sppa, change!');
        }
      } else {
        // print(
        //     '${appProdukController.listPerluasanRisiko[i].namaPerluasanRisiko} nggak dipilih');
        if (listPerluasanRisikoSppa.indexWhere((element) =>
                element.namaPerluasanRisiko ==
                appProdukController
                    .listPerluasanRisiko[i].namaPerluasanRisiko) !=
            -1) {
          // print(
          //     '${appProdukController.listPerluasanRisiko[i].namaPerluasanRisiko} ada di sppa, change!!');

          hasChanged = true;
        }
      }
    }

    //print('perluasan has changed? $hasChanged');
    return hasChanged;
  }

  void deletePerluasanRisikoSppa() async {
    // delete all items in listPerluasanRisikoSppa
    Uri url;
    String body;
    http.Response response;

    for (var i = 0; i < listPerluasanRisikoSppa.length; i++) {
      // delete each
      print('delete perluasan : ${listPerluasanRisikoSppa[i].id}');
      url = Uri.parse(
          '$baseUrl/SppaPerluasanRisiko/${listPerluasanRisikoSppa[i].id}');
      body = json.encode(listPerluasanRisikoSppa[i]);
      response = await client.delete(url, body: body, headers: {
        'Content-Type': 'application/json'
      }); // no authentication needed
      if (response.statusCode == 200) {
        print(
            'delete ${listPerluasanRisikoSppa[i].namaPerluasanRisiko} berhasil');
      } else {
        print(
            'delete ${listPerluasanRisikoSppa[i].namaPerluasanRisiko} tidak berhasil ${response.statusCode}');
      }

      // totalRate has been updated from ui
    }
  }

  void calculateTotalRate() {
    totalRate.value = appProdukController.selected.value.ratePremi!;

    for (var i = 0; i < appProdukController.listPerluasanRisiko.length; i++) {
      if (appProdukController.listPerluasanRisiko[i].selected!) {
        print(
            'tambah rate ${appProdukController.listPerluasanRisiko[i].namaPerluasanRisiko} ${appProdukController.listPerluasanRisiko[i].rate}');
        totalRate.value += appProdukController.listPerluasanRisiko[i].rate!;
      }
    }
    // update in header
    sppaHeader.premiRate = totalRate.value;

    print('total rate: ${totalRate.value}');
  }

  void loadInfoData(String sppaId) async {
    // load additional infoAtsJasTan
    final param1 = '?sppaId=${sppaId}';
    final url = Uri.parse(baseUrl + '/InfoAtsJasTan' + param1);
    print(baseUrl + '/InfoAtsJasTan' + param1);
    http.Response response = await client.get(url);
    if (response.statusCode == 200) {
      var responseBodyStatus = jsonDecode(response.body);
      //print(responseBodyStatus);
      for (var i = 0; i < responseBodyStatus.length; i++) {
        // TODO  ini harusnya cuma 1
        infoAts.value = InfoAtsJasTan.fromJson(responseBodyStatus[i]);
      }
    } else {
      print('Load add info jastan error ${response.statusCode}');
    }
  }

  void saveInfoData() async {
    infoAts.value.sppaId = sppaHeader.id;

    infoAts.value.lokasiKandang = kandangController.text;
    infoAts.value.infoMgmtKandang = mgmtKandangController.text;
    infoAts.value.kriteriaPemeliharaan = sisPemeliharaanController.text;
    infoAts.value.sistemPakanTernak = sisPakanController.text;
    infoAts.value.infoMgmtPakan = mgmtPakanController.text;
    infoAts.value.infoMgmtKesehatan = mgmtKesehatanController.text;

    var url = Uri.parse('$baseUrl/InfoAtsJasTan');
    var body = json.encode(infoAts.value);
//    print('body : $body');
    http.Response response = await client.post(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed
    // print('status: ${response.statusCode}');
    // print('body: ${response.body}');
    if (response.statusCode == 201) {
      print('post infoAtsJastan berhasil');
      var responseBody = jsonDecode(response.body);
      // print('Return Response body: ${responseBody}');
      // print('sppa header id :${responseBody["id"]}');
      infoAts.value.id = responseBody["id"];
    } else {
      print('Save InfoAts error: ${response.statusCode}');
    }
  }

  bool infoDataChanged() {
    if (infoAts.value.lokasiKandang == kandangController.text &&
        // infoAts.value.infoMgmtKandang = mgmtKandangController.text;
        infoAts.value.kriteriaPemeliharaan == sisPemeliharaanController.text &&
        infoAts.value.sistemPakanTernak == sisPakanController.text) {
      return false;
    } else {
      return true;
    }
  }

  void updateInfoData() async {
    infoAts.value.lokasiKandang = kandangController.text;
    // infoAts.value.infoMgmtKandang = mgmtKandangController.text;
    infoAts.value.kriteriaPemeliharaan = sisPemeliharaanController.text;
    infoAts.value.sistemPakanTernak = sisPakanController.text;
    // infoAts.value.infoMgmtPakan = mgmtPakanController.text;
    // infoAts.value.infoMgmtKesehatan = mgmtKesehatanController.text;
    // infoAts.value.sppaId = sppaController.sppaHeader.id;

    var url = Uri.parse('$baseUrl/InfoAtsJasTan/${infoAts.value.id}');
    var body = json.encode(infoAts.value);
    // print('Put sppainfo body : $body');
    http.Response response = await client.put(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed
    // print('status: ${response.statusCode}');
    // print('body: ${response.body}');
    if (response.statusCode == 200) {
      print('put infoAtsJastan berhasil');
      // print('Return Response body: ${responseBody}');
      // print('sppa header id :${responseBody["id"]}');
    } else {
      print('Save InfoAts error: ${response.statusCode}');
    }
  }

  void submitSppa(int status) async {
    // submit customer to sales
    // update header & status,
    // based on sppaHeader and sppaStatus
    Uri url;
    String body;

    final saatIni = DateTime.now();
    if (status == 1) {
      sppaHeader.statusSppa = 2;
      sppaHeaderStatusObs.value = 2;

      sppaStatus.statusSppa = 2;
      sppaStatus.initSubmitDt = DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.initSubmitDtMillis = saatIni.millisecondsSinceEpoch;
      sppaStatus.tglLastUpdate = sppaStatus.initSubmitDt;
      sppaStatus.tglLastUpdateMillis = sppaStatus.initSubmitDtMillis;
    } else {
      sppaHeader.statusSppa = 4;
      sppaHeaderStatusObs.value = 4;

      sppaStatus.statusSppa = 4;
      sppaStatus.tglSubmitSales = DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.tglSubmitSalesMillis = saatIni.millisecondsSinceEpoch;
      sppaStatus.tglLastUpdate = sppaStatus.tglSubmitSales;
      sppaStatus.tglLastUpdateMillis = sppaStatus.tglSubmitSalesMillis;
    }
    url = Uri.parse('$baseUrl/SppaHeader/${sppaHeader.id}');
    body = json.encode(sppaHeader);

    http.Response response = await client.put(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed
    // print('status: ${response.statusCode}');
    // print('body: ${response.body}');

    if (response.statusCode == 200) {
      print('submit header berhasil');

      // updates status
      url = Uri.parse('$baseUrl/SppaStatus/${sppaStatus.id}');
      body = json.encode(sppaStatus);
      // print('body : $body');

      response = await client.put(url, body: body, headers: {
        'Content-Type': 'application/json'
      }); // no authentication needed
      // print('status: ${response.statusCode}');
      // print('body: ${response.body}');

      if (response.statusCode == 200) {
        print('submit status berhasil');

        // remove from aktif list
        //   if (!isNewSppa.value) {
        //     print('remove sppa from aktif list');
        //     final dashboardController = Get.find<DashboardController>();
        //     dashboardController.listAktifSppa
        //         .removeWhere((el) => el.id == sppaHeader.id);
        //   }
        // } else {
        print('submit status gagal ${response.statusCode}');
      }
    } else {
      print('submit header gagal ${response.statusCode}');
    }
  }

  void confirmSubmitDialog(int status) {
    Get.dialog(
      AlertDialog(
        title: const Text('Konfirmasi'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextTitleMedium('Sppa akan di submit'),
            SizedBox(height: 10),
            TextBodyMedium(sppaHeader.produkName!),
            SizedBox(height: 10),
            TextBodyMedium(
                'Pertanggungan : Rp ${NumberFormat("#,###,###,###", "en_US").format(sppaHeader.nilaiPertanggungan!)}'),
            TextBodyMedium(
                'Total Rate : ${(sppaHeader.premiRate! * 100).toStringAsFixed(3)} %'),
            TextBodyMedium(
                'Premi : Rp ${NumberFormat("#,###,###,###", "en_US").format(sppaHeader.premiAmount!)}'),
            SizedBox(height: 30),
          ],
        ),
        actions: [
          OutlinedButton(
            child: Container(
                padding: const EdgeInsets.all(12),
                child: Text('Batal'.tr,
                    style: Get.theme.textTheme.bodyMedium!.copyWith(
                      color: Get.theme.colorScheme.primary,
                    ))),
            onPressed: () => Get.back(),
          ),
          ElevatedButton(
              child: Text('Konfirm'.tr,
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  )),
              onPressed: () {
                submitSppa(status);
                cekBtnVisible();
                Get.back();
                //Get.until((route) => Get.currentRoute == '/sppa');
              })
        ],
      ),
    );
  }

  void batalSppa(int status) async {
    // batal oleh customer to sales
    // update header & status,
    // based on sppaHeader and sppaStatus
    Uri url;
    String body;

    final saatIni = DateTime.now();
    if (status == 1 || status == 3) {
      // dari baru belum apa apa sudah batal -> delete
      // dari tolakan sales dulu,
      sppaHeader.statusSppa = 10;
      sppaHeaderStatusObs.value = 10;

      sppaStatus.statusSppa = 10;
      sppaStatus.tglLastUpdate = DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.tglLastUpdateMillis = saatIni.millisecondsSinceEpoch;
    } else // (status==5 dan lain lain )
    {
      // TODO dari tolakan asuransi ?
      sppaHeader.statusSppa = 9;
      sppaHeaderStatusObs.value = 9;

      sppaStatus.statusSppa = 9;
      sppaStatus.tglLastUpdate = DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.tglLastUpdateMillis = saatIni.millisecondsSinceEpoch;
    }
    url = Uri.parse('$baseUrl/SppaHeader/${sppaHeader.id}');
    body = json.encode(sppaHeader);

    http.Response response = await client.put(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed
    // print('status: ${response.statusCode}');
    // print('body: ${response.body}');
    if (response.statusCode == 200) {
      print('batal header berhasil');
      // updates status
      url = Uri.parse('$baseUrl/SppaStatus/${sppaStatus.id}');
      body = json.encode(sppaStatus);
      // print('body : $body');
      response = await client.put(url, body: body, headers: {
        'Content-Type': 'application/json'
      }); // no authentication needed
      // print('status: ${response.statusCode}');
      // print('body: ${response.body}');
      if (response.statusCode == 200) {
        print('batal status berhasil');

        // remove from aktifSppaList
        if (!isNewSppa.value) {
          print('remove sppa from aktif list');
          final dashboardController = Get.find<DashboardController>();
          dashboardController.listAktifSppa
              .removeWhere((el) => el.id == sppaHeader.id);
        }
      } else {
        print('batal status gagal ${response.statusCode}');
      }
    } else {
      print('batal header gagal ${response.statusCode}');
    }
  }

  void confirmBatalDialog(int status) async {
    print('open batal dialog');
    jadiBatal.value = await Get.dialog(
      AlertDialog(
        title: const Text('Konfirmasi'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextTitleMedium('Sppa akan di batalkan'),
            SizedBox(height: 10),
            TextBodyMedium(sppaHeader.produkName!),
            SizedBox(height: 10),
            TextBodyMedium(
                'Pertanggungan : Rp ${NumberFormat("#,###,###,###", "en_US").format(sppaHeader.nilaiPertanggungan!)}'),
            TextBodyMedium(
                'Total Rate : ${(sppaHeader.premiRate! * 100).toStringAsFixed(3)} %'),
            TextBodyMedium(
                'Premi : Rp ${NumberFormat("#,###,###,###", "en_US").format(sppaHeader.premiAmount!)}'),
            SizedBox(height: 30),
          ],
        ),
        actions: [
          OutlinedButton(
            child: Container(
                padding: const EdgeInsets.all(12),
                child: Text('Batal'.tr,
                    style: Get.theme.textTheme.bodyMedium!.copyWith(
                      color: Get.theme.colorScheme.primary,
                    ))),
            onPressed: () => Get.back(result: false),
          ),
          ElevatedButton(
              child: Text('Konfirm'.tr,
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  )),
              onPressed: () {
                batalSppa(status);
                cekBtnVisible();
                Get.back(result: true);
              })
        ],
      ),
    );
  }

  void confirmTolakDialog(int status) async {
    //print('open tolak dialog');
    jadiTolak.value = await Get.dialog(
      AlertDialog(
        title: const Text('Konfirmasi'),
        content: Form(
          key: tolakFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextTitleMedium('Sppa akan di tolak'),
              SizedBox(height: 10),
              TextBodyMedium(sppaHeader.produkName!),
              SizedBox(height: 10),
              TextBodyMedium(
                  'Pertanggungan : Rp ${NumberFormat("#,###,###,###", "en_US").format(sppaHeader.nilaiPertanggungan!)}'),
              TextBodyMedium(
                  'Total Rate : ${(sppaHeader.premiRate! * 100).toStringAsFixed(3)} %'),
              TextBodyMedium(
                  'Premi : Rp ${NumberFormat("#,###,###,###", "en_US").format(sppaHeader.premiAmount!)}'),
              SizedBox(height: 25),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Catatan Penolakan',
                  hintText: 'Jelaskan alasan penolakan.',
                  counterStyle: TextStyle(fontSize: 9),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "*Wajib diisi.";
                  } else {
                    tolakNoteController.text = value;
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          OutlinedButton(
            child: Container(
                padding: const EdgeInsets.all(12),
                child: Text('Batal'.tr,
                    style: Get.theme.textTheme.bodyMedium!.copyWith(
                      color: Get.theme.colorScheme.primary,
                    ))),
            onPressed: () => Get.back(result: false),
          ),
          ElevatedButton(
              child: Text('Konfirm'.tr,
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  )),
              onPressed: () {
                if (tolakFormKey.currentState!.validate()) {
                  tolakSppa(status, '');
                  cekBtnVisible();
                  Get.back(result: true);
                }
              })
        ],
      ),
    );
  }

  void tolakSppa(int status, String message) async {
    // penolakan dari sales : status 2
    // penolakan dari asuransi : status 8?

    // header
    Uri url;
    String body;

    final saatIni = DateTime.now();

    if (status == 2) {
      sppaHeader.statusSppa = 3;
      sppaHeaderStatusObs.value = 3;

      sppaStatus.statusSppa = 3;
      sppaStatus.salesNote = tolakNoteController.text;
      sppaStatus.tglReviewSales = DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.tglReviewSalesMillis = saatIni.millisecondsSinceEpoch;
      sppaStatus.tglLastUpdate = DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.tglLastUpdateMillis = saatIni.millisecondsSinceEpoch;
    }
    if (status == 5) {
      sppaHeader.statusSppa = 9;
      sppaHeaderStatusObs.value = 2;

      sppaStatus.statusSppa = 9;
      sppaStatus.tglResponseAsuransi = DateFormat("dd-MMM-yyyy")
          .format(saatIni); // for note from asuransi in SppaRecap
      sppaStatus.tglResponseAsuransiMillis = saatIni.millisecondsSinceEpoch;
      sppaStatus.statusResponseAsuransi = 0; // penolakan
      sppaStatus.asuransiNote = message;
      sppaStatus.tglLastUpdate = DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.tglLastUpdateMillis = saatIni.millisecondsSinceEpoch;
    }

    url = Uri.parse('$baseUrl/SppaHeader/${sppaHeader.id}');
    body = json.encode(sppaHeader);

    http.Response response = await client.put(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed
    // print('status: ${response.statusCode}');
    // print('body: ${response.body}');
    if (response.statusCode == 200) {
      print('tolak header berhasil');
      // updates status
      url = Uri.parse('$baseUrl/SppaStatus/${sppaStatus.id}');
      body = json.encode(sppaStatus);
      // print('body : $body');
      response = await client.put(url, body: body, headers: {
        'Content-Type': 'application/json'
      }); // no authentication needed
      // print('status: ${response.statusCode}');
      // print('body: ${response.body}');
      if (response.statusCode == 200) {
        print('tolak status berhasil');
        // remove from aktif list
        if (!isNewSppa.value) {
          print('remove sppa from aktif list');
          final dashboardController = Get.find<DashboardController>();
          dashboardController.listAktifSppa
              .removeWhere((el) => el.id == sppaHeader.id);
        }
      } else {
        print('tolak status gagal ${response.statusCode}');
      }
    } else {
      print('tolak header gagal ${response.statusCode}');
    }
  }

  void dialogRiwayat() async {
    await Get.dialog(
      AlertDialog(
        title: const Text('Riwayat Sppa'),
        content: Container(
          width: formWidth(Get.width),
          child: Wrap(
              spacing: 20,
              runSpacing: 20,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1, child: TextTitleMedium('Tanggal dibuat ')),
                    Expanded(
                        flex: 1,
                        child: TextTitleMedium(sppaStatus.tglCreated!)),
                  ],
                ),
                sppaStatus.tglLastUpdate != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child:
                                  TextTitleMedium('Tanggal diubah terakhir ')),
                          Expanded(
                              flex: 1,
                              child:
                                  TextTitleMedium(sppaStatus.tglLastUpdate!)),
                        ],
                      )
                    : Container(),
                sppaStatus.initSubmitDt != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  'Tanggal disubmit ke ${sppaHeader.salesId} ')),
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(sppaStatus.initSubmitDt!)),
                        ],
                      )
                    : Container(),
                sppaStatus.tglReviewSales != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  'Tanggal direview oleh ${sppaHeader.salesId} ')),
                          Expanded(
                              flex: 1,
                              child:
                                  TextTitleMedium(sppaStatus.tglReviewSales!)),
                        ],
                      )
                    : Container(),
                sppaStatus.salesNote != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1, child: TextTitleMedium('Review note ')),
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(sppaStatus.salesNote!)),
                        ],
                      )
                    : Container(),
                sppaStatus.tglSubmitSales != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Expanded(
                                flex: 1,
                                child: TextTitleMedium(
                                    'Tanggal disubmit oleh ${sppaHeader.salesId}  ')),
                            Expanded(
                                flex: 1,
                                child: TextTitleMedium(
                                    sppaStatus.tglSubmitSales!)),
                          ])
                    : Container(),
              ]),
        ),
        actions: [
          ElevatedButton(
            child: Container(
                padding: const EdgeInsets.all(12),
                child: Text('Kembali'.tr,
                    style: Get.theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ))),
            onPressed: () => Get.back(),
          )
        ],
      ),
    );
  }
}
