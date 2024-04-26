import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
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

  RxList<SppaHeader> listHelperSppa = <SppaHeader>[].obs;

  ProdukAsuransi selected = ProdukAsuransi();

  Rx<SppaHeader> sppaHeader = SppaHeader().obs;
  Rx<SppaStatus> sppaStatus = SppaStatus().obs;
  RxInt sppaStatusDisp = 0.obs;
  RxBool sppaLoaded = false.obs;

  RxList<SppaPerluasanRisiko> listPerluasanRisikoSppa =
      <SppaPerluasanRisiko>[].obs;
  RxBool listPerluasanRisikoSppaLoaded = false.obs;

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
  RxBool infoAtsLoaded = false.obs;

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

    //print('done init sppa controller');
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
    print(
        'in check button ${loginController.check.value.roles} ${sppaHeader.value.statusSppa}');
    if (loginController.check.value.roles == 'ROLE_CUSTOMER') {
      switch (sppaHeader.value.statusSppa) {
        case 1:
          batalBtnVis.value = true;
          editBtnVis.value = true;
          submitBtnVis.value = true;
        case 2:
          batalBtnVis.value = false;
          editBtnVis.value = false;
          submitBtnVis.value = false;
          break;
        case 3:
          batalBtnVis.value = true;
          editBtnVis.value = true;
          submitBtnVis.value = true;
          break;
        default:
          batalBtnVis.value = false;
          editBtnVis.value = false;
          submitBtnVis.value = false;
          break;
      }
    }

    if (loginController.check.value.roles == 'ROLE_SALES') {
      batalBtnVis.value = false;
      editBtnVis.value = false;

      switch (sppaHeader.value.statusSppa) {
        case 1:
          submitBtnVis.value = false;
          tolakBtnVis.value = false;
          break;
        case 2:
          submitBtnVis.value = true;
          tolakBtnVis.value = true;
          break;
        case 3:
          submitBtnVis.value = false;
          tolakBtnVis.value = false;
          break;
        case 5:
          submitBtnVis.value = false;
          tolakBtnVis.value = true;
          break;

        default:
          submitBtnVis.value = false;
          tolakBtnVis.value = false;
          break;
      }
    }

    if (loginController.check.value.roles == 'ROLE_MARKETING') {
      batalBtnVis.value = false;
      editBtnVis.value = false;
      switch (sppaHeader.value.statusSppa) {
        case 1:
        case 2:
        case 3:
          submitBtnVis.value = false;
          tolakBtnVis.value = false;
          break;
        case 4:
          submitBtnVis.value = true;
          tolakBtnVis.value = true;
          break;
        case 5:
          submitBtnVis.value = false;
          tolakBtnVis.value = false;
          break;
        case 7:
          submitBtnVis.value = false;
          tolakBtnVis.value = true;
          break;

        default:
          submitBtnVis.value = false;
          tolakBtnVis.value = false;
          break;
      }
    }

    if (loginController.check.value.roles == 'ROLE_BROKER') {
      batalBtnVis.value = false;
      editBtnVis.value = false;
      switch (sppaHeader.value.statusSppa) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
          submitBtnVis.value = false;
          tolakBtnVis.value = false;
          break;
        case 6:
          submitBtnVis.value = true;
          tolakBtnVis.value = true;
          break;
        case 7:
          submitBtnVis.value = false;
          tolakBtnVis.value = false;
          break;
        case 9:
          submitBtnVis.value = false;
          tolakBtnVis.value = true;
          break;

        default:
          submitBtnVis.value = false;
          tolakBtnVis.value = false;
          break;
      }
    }

    print('btn batal jadi ${batalBtnVis.value}');
    print('btn edit jadi ${editBtnVis.value}');
    print('btn submit jadi ${submitBtnVis.value}');
    print('btn tolak jadi ${tolakBtnVis.value}');
  }

  String sppaStatusDesc(int status) {
    switch (status) {
      case 1:
        return 'Baru';
      case 2:
        return 'Proses Sales';
      case 3:
        return 'Kembali Dari Sales';
      case 4:
        return 'Proses Marketing';
      case 5:
        return 'Kembali dari Marketing';
      case 6:
        return 'Proses Broker';
      case 7:
        return 'Kembali Dari Broker';
      case 8:
        return 'Proses Asuransi';
      case 9:
        return 'Tolak Dari Asuransi';
      case 10:
        return 'Terima Oleh Asuransi';
      case 20:
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
          sppaHeader.value.customerId = customerController.value.text;
          sppaHeader.value.salesId = theCustomer.value.salesId;
          sppaHeader.value.marketingId = theCustomer.value.marketingId;
          sppaHeader.value.brokerId = theCustomer.value.brokerId;
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
        (!isNewSppa.value &&
            aProd.productCode != sppaHeader.value.produkCode)) {
      selected = aProd; // selected of SppaController

      appProdukController.selected.value =
          aProd; // selected of ProductController
      // print('in selectProduk selected in sppa is: ${selected.productName}');
      // print('in selectProduk selected in produk is: ${selected.productName}');
      // get customer detail to display later
      sppaHeader.value.produkCode = aProd.productCode;
      sppaHeader.value.produkName = aProd.productName;
      sppaHeader.value.asuransiName = aProd.codeAsuransi;
      sppaHeader.value.kategori = aProd.productKategori;
      sppaHeader.value.subKategori = aProd.productSubKategori;
      sppaHeader.value.premiRate = aProd.ratePremi;
      sppaHeader.value.tenor = aProd.tenor;
      sppaHeader.value.statusSppa = 1;
      prodOk.value = true;
      // prepare perluasanRisiko nya
      getPerluasanRisikoSppa();
    }
  }

  void validateNextButton() {
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
      sppaHeader.value.id = responseBody["id"];

      // SppaStatus second

      // SppaStatus
      final saatIni = DateTime.now();
      sppaStatus.value.sppaId = sppaHeader.value.id!;
      sppaStatus.value.statusSppa = 1;
      sppaStatus.value.tglCreated = DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.value.tglCreatedMillis = saatIni.millisecondsSinceEpoch;

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
        sppaStatus.value.id = responseBody["id"];

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

    if (sppaHeader.value.produkName == produkController.text &&
        sppaHeader.value.customerId == customerController.value.text) {
      print('header no change');
    } else {
      print('header changed');
      updateHeader = true;
    }

    if (updateHeader) {
      // recalculate premi amount just incase perluasan changed, ternak tidak.
      sppaHeader.value.premiAmount =
          sppaHeader.value.nilaiPertanggungan! * sppaHeader.value.premiRate!;

      url = Uri.parse('$baseUrl/SppaHeader/${sppaHeader.value.id}');
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
        sppaStatus.value.tglLastUpdate =
            DateFormat("dd-MMM-yyyy").format(saatIni);
        sppaStatus.value.tglLastUpdateMillis = saatIni.millisecondsSinceEpoch;
        print('$baseUrl/SppaStatus/${sppaStatus.value.id}');
        url = Uri.parse('$baseUrl/SppaStatus/${sppaStatus.value.id}');
        body = json.encode(sppaStatus.value);
        print('body : $body');
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
      sppaStatus.value.statusSppa = newStatus;
      sppaStatus.value.recapSppaId = recapId;
      sppaStatus.value.tglRecap = DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.value.tglRecapMillis = saatIni.millisecondsSinceEpoch;
      sppaStatus.value.tglLastUpdate = sppaStatus.value.tglRecap;
      sppaStatus.value.tglLastUpdateMillis = sppaStatus.value.tglRecapMillis;

      url = Uri.parse('$baseUrl/SppaStatus/${sppaStatus.value.id}');
      body = json.encode(sppaStatus);
      // print('body : $body');
      response = await client.put(url, body: body, headers: {
        'Content-Type': 'application/json'
      }); // no authentication needed

      if (response.statusCode == 200) {
        print('put status recap berhasil');

        // update header
        sppaHeader.value.statusSppa = newStatus;
        url = Uri.parse('$baseUrl/SppaHeader/${sppaHeader.value.id}');
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

      param1 = '?sppaId=${sppaHeader.value.id}';

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
        newPerluasan.sppaId = sppaHeader.value.id;
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
    sppaHeader.value.premiRate = totalRate.value;

    print('total rate: ${totalRate.value}');
  }

  void loadInfoData(String sppaId) async {
    // load additional infoAtsJasTan
    final param1 = '?sppaId=${sppaId}';
    final url = Uri.parse(baseUrl + '/InfoAtsJasTan' + param1);
    infoAtsLoaded.value = false;

    print(baseUrl + '/InfoAtsJasTan' + param1);

    http.Response response = await client.get(url);
    if (response.statusCode == 200) {
      var responseBodyStatus = jsonDecode(response.body);
      //print(responseBodyStatus);
      for (var i = 0; i < responseBodyStatus.length; i++) {
        // TODO  ini harusnya cuma 1
        infoAts.value = InfoAtsJasTan.fromJson(responseBodyStatus[i]);
      }
      infoAtsLoaded.value = true;
    } else {
      print('Load add info jastan error ${response.statusCode}');
    }
  }

  void saveInfoData() async {
    infoAts.value.sppaId = sppaHeader.value.id;

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
    // infoAts.value.sppaId = sppaController.sppaHeader.value.id;

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

    sppaStatus.value.tglLastUpdate = sppaStatus.value.initSubmitDt;
    sppaStatus.value.tglLastUpdateMillis = sppaStatus.value.initSubmitDtMillis;

    if (status == 1 || status == 3) {
      sppaHeader.value.statusSppa = 2;
      sppaStatusDisp.value = 2;

      sppaStatus.value.statusSppa = 2;
      sppaStatus.value.initSubmitDt = DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.value.initSubmitDtMillis = saatIni.millisecondsSinceEpoch;
      // clear all notes
      sppaStatus.value.salesNote = '';
      sppaStatus.value.marketingNote = '';
      sppaStatus.value.brokerNote = '';
      sppaStatus.value.tglSubmitSalesMillis = 0;
      sppaStatus.value.tglSubmitSales = '';
      sppaStatus.value.tglSubmitMarketingMillis = 0;
      sppaStatus.value.tglSubmitMarketing = '';
      sppaStatus.value.tglSubmitBrokerMillis = 0;
      sppaStatus.value.tglSubmitBroker = '';
    } else if (status == 2) {
      sppaHeader.value.statusSppa = 4;
      sppaStatusDisp.value = 4;

      sppaStatus.value.statusSppa = 4;
      sppaStatus.value.tglSubmitSales =
          DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.value.tglSubmitSalesMillis = saatIni.millisecondsSinceEpoch;
    } else if (status == 4) {
      sppaHeader.value.statusSppa = 6;
      sppaStatusDisp.value = 6;

      sppaStatus.value.statusSppa = 6;
      sppaStatus.value.tglSubmitMarketing =
          DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.value.tglSubmitMarketingMillis =
          saatIni.millisecondsSinceEpoch;
    } else if (status == 6) {
      sppaHeader.value.statusSppa = 8;
      sppaStatusDisp.value = 8;

      sppaStatus.value.statusSppa = 8;
      sppaStatus.value.tglSubmitBroker =
          DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.value.tglSubmitBrokerMillis = saatIni.millisecondsSinceEpoch;
    }

    url = Uri.parse('$baseUrl/SppaHeader/${sppaHeader.value.id}');
    body = json.encode(sppaHeader);

    http.Response response = await client.put(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed
    // print('status: ${response.statusCode}');
    // print('body: ${response.body}');

    if (response.statusCode == 200) {
      print('submit header berhasil');

      // updates status
      url = Uri.parse('$baseUrl/SppaStatus/${sppaStatus.value.id}');
      body = json.encode(sppaStatus);
      // print('body : $body');

      response = await client.put(url, body: body, headers: {
        'Content-Type': 'application/json'
      }); // no authentication needed
      // print('status: ${response.statusCode}');
      // print('body: ${response.body}');

      if (response.statusCode == 200) {
        print('submit status berhasil');

        // update status sppa in listAktifSppa
        // print('update sppa from aktif list');
        final dashboardController = Get.find<DashboardController>();
        var idx = dashboardController.listAktifSppa
            .indexWhere((el) => el.id == sppaHeader.value.id);

        switch (status) {
          case 1:
          case 3:
            dashboardController.listAktifSppa[idx].statusSppa = 2;
            break;
          case 2:
            dashboardController.listAktifSppa[idx].statusSppa = 4;
            break;
          case 4:
            dashboardController.listAktifSppa[idx].statusSppa = 6;
            break;
          case 6:
            dashboardController.listAktifSppa[idx].statusSppa = 8;
            break;
          default:
            break;
        }

        idx = listHelperSppa.indexWhere((el) => el.id == sppaHeader.value.id);
        switch (status) {
          case 1:
            listHelperSppa[idx].statusSppa = 2;
            break;
          case 2:
            listHelperSppa[idx].statusSppa = 4;
            break;
          case 4:
            listHelperSppa[idx].statusSppa = 6;
            break;
          case 6:
            listHelperSppa[idx].statusSppa = 8;
            break;
          default:
            break;
        }

        dashboardController.listAktifSppa.refresh();
        listHelperSppa.refresh();
      } else {
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
        content: Container(
          // width: formWidth(Get.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextTitleMedium('Sppa akan di submit'),
              SizedBox(height: 10),
              TextBodyMedium(sppaHeader.value.produkName!),
              SizedBox(height: 10),
              TextBodyMedium(
                  'Pertanggungan : Rp ${NumberFormat("#,###,###,###", "en_US").format(sppaHeader.value.nilaiPertanggungan!)}'),
              TextBodyMedium(
                  'Total Rate : ${(sppaHeader.value.premiRate! * 100).toStringAsFixed(3)} %'),
              TextBodyMedium(
                  'Premi : Rp ${NumberFormat("#,###,###,###", "en_US").format(sppaHeader.value.premiAmount!)}'),
              SizedBox(height: 30),
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
      sppaHeader.value.statusSppa = 20;

      sppaStatus.value.statusSppa = 20;
      sppaStatus.value.tglLastUpdate =
          DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.value.tglLastUpdateMillis = saatIni.millisecondsSinceEpoch;
    } else if (status == 9) // batal oleh tolakan asuransi
    {
      sppaHeader.value.statusSppa = 20;

      sppaStatus.value.statusSppa = 20;
      sppaStatus.value.tglLastUpdate =
          DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.value.tglLastUpdateMillis = saatIni.millisecondsSinceEpoch;
    }
    url = Uri.parse('$baseUrl/SppaHeader/${sppaHeader.value.id}');
    body = json.encode(sppaHeader);

    http.Response response = await client.put(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed
    // print('status: ${response.statusCode}');
    // print('body: ${response.body}');
    if (response.statusCode == 200) {
      print('batal header berhasil');
      // updates status
      url = Uri.parse('$baseUrl/SppaStatus/${sppaStatus.value.id}');
      body = json.encode(sppaStatus);
      // print('body : $body');
      response = await client.put(url, body: body, headers: {
        'Content-Type': 'application/json'
      }); // no authentication needed
      // print('body: ${response.body}');
      if (response.statusCode == 200) {
        print('batal status berhasil');

        // update status sppa in listAktifSppa
        // print('update sppa from aktif list');
        final dashboardController = Get.find<DashboardController>();

        var idx = dashboardController.listAktifSppa
            .indexWhere((el) => el.id == sppaHeader.value.id);
        dashboardController.listAktifSppa[idx].statusSppa = 20;

        idx = listHelperSppa.indexWhere((el) => el.id == sppaHeader.value.id);
        listHelperSppa[idx].statusSppa = 20;

        dashboardController.listAktifSppa.refresh();
        listHelperSppa.refresh();

        sppaStatusDisp.value = 20;
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
            TextBodyMedium(sppaHeader.value.produkName!),
            SizedBox(height: 10),
            TextBodyMedium(
                'Pertanggungan : Rp ${NumberFormat("#,###,###,###", "en_US").format(sppaHeader.value.nilaiPertanggungan!)}'),
            TextBodyMedium(
                'Total Rate : ${(sppaHeader.value.premiRate! * 100).toStringAsFixed(3)} %'),
            TextBodyMedium(
                'Premi : Rp ${NumberFormat("#,###,###,###", "en_US").format(sppaHeader.value.premiAmount!)}'),
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
          child: Container(
            width: formWidth(Get.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextTitleMedium('Sppa akan di tolak'),
                SizedBox(height: 10),
                TextBodyMedium(sppaHeader.value.produkName!),
                SizedBox(height: 10),
                TextBodyMedium(
                    'Pertanggungan : Rp ${NumberFormat("#,###,###,###", "en_US").format(sppaHeader.value.nilaiPertanggungan!)}'),
                TextBodyMedium(
                    'Total Rate : ${(sppaHeader.value.premiRate! * 100).toStringAsFixed(3)} %'),
                TextBodyMedium(
                    'Premi : Rp ${NumberFormat("#,###,###,###", "en_US").format(sppaHeader.value.premiAmount!)}'),
                SizedBox(height: 25),
                TextFormField(
                  controller: tolakNoteController,
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
                  tolakSppa(status, tolakNoteController.text);
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
    // oleh sales
    if (status == 2 || status == 5) {
      sppaHeader.value.statusSppa = 3;
      sppaStatusDisp.value = 3;

      sppaStatus.value.statusSppa = 3;
      sppaStatus.value.salesNote = tolakNoteController.text;
      sppaStatus.value.tglReviewSales =
          DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.value.tglReviewSalesMillis = saatIni.millisecondsSinceEpoch;
    }
    // oleh marketing
    if (status == 4 || status == 7) {
      sppaHeader.value.statusSppa = 5;
      sppaStatusDisp.value = 5;

      sppaStatus.value.statusSppa = 5;
      sppaStatus.value.tglReviewMarketing = DateFormat("dd-MMM-yyyy")
          .format(saatIni); // for note from asuransi in SppaRecap
      sppaStatus.value.tglReviewMarketingMillis =
          saatIni.millisecondsSinceEpoch;
      sppaStatus.value.marketingNote = message;
    }

    // oleh broker
    if (status == 6 || status == 9) {
      sppaHeader.value.statusSppa = 7;
      sppaStatusDisp.value = 7;

      sppaStatus.value.statusSppa = 7;
      sppaStatus.value.tglReviewBroker = DateFormat("dd-MMM-yyyy")
          .format(saatIni); // for note from asuransi in SppaRecap
      sppaStatus.value.tglReviewBrokerMillis = saatIni.millisecondsSinceEpoch;
      sppaStatus.value.brokerNote = message;
    }

    // oleh asuransi
    if (status == 8) {
      sppaHeader.value.statusSppa = 9;
      sppaStatusDisp.value = 9;

      sppaStatus.value.statusSppa = 9;
      sppaStatus.value.tglResponseAsuransi = DateFormat("dd-MMM-yyyy")
          .format(saatIni); // for note from asuransi in SppaRecap
      sppaStatus.value.tglResponseAsuransiMillis =
          saatIni.millisecondsSinceEpoch;
      sppaStatus.value.asuransiNote = message;
    }

    sppaStatus.value.tglLastUpdate = DateFormat("dd-MMM-yyyy").format(saatIni);
    sppaStatus.value.tglLastUpdateMillis = saatIni.millisecondsSinceEpoch;

    url = Uri.parse('$baseUrl/SppaHeader/${sppaHeader.value.id}');
    body = json.encode(sppaHeader);

    http.Response response = await client.put(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed
    // print('status: ${response.statusCode}');
    // print('body: ${response.body}');
    if (response.statusCode == 200) {
      print('tolak header berhasil');
      // updates status
      url = Uri.parse('$baseUrl/SppaStatus/${sppaStatus.value.id}');
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
          print('update sppa from aktif list and helper');
          // update status sppa in listAktifSppa
          // print('update sppa from aktif list');
          final dashboardController = Get.find<DashboardController>();
          var idx = dashboardController.listAktifSppa
              .indexWhere((el) => el.id == sppaHeader.value.id);

          switch (status) {
            case 2:
              dashboardController.listAktifSppa[idx].statusSppa = 3;
              break;
            case 4:
              dashboardController.listAktifSppa[idx].statusSppa = 5;
              break;
            case 6:
              dashboardController.listAktifSppa[idx].statusSppa = 7;
              break;
            case 8:
              dashboardController.listAktifSppa[idx].statusSppa = 9;
              break;
            default:
              break;
          }

          idx = listHelperSppa.indexWhere((el) => el.id == sppaHeader.value.id);
          switch (status) {
            case 1:
              break;
            case 2:
              listHelperSppa[idx].statusSppa = 3;
              break;
            case 4:
              listHelperSppa[idx].statusSppa = 5;
              break;
            case 6:
              listHelperSppa[idx].statusSppa = 7;
              break;
            case 8:
              listHelperSppa[idx].statusSppa = 9;
              break;
            default:
              break;
          }

          dashboardController.listAktifSppa.refresh();
          listHelperSppa.refresh();
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
        scrollable: true,
        buttonPadding: EdgeInsets.all(5),
        content: Container(
          width: formWidth(Get.width),
          height: 400,
          child: Wrap(
              spacing: 20,
              runSpacing: 10,
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
                        child: TextTitleMedium(sppaStatus.value.tglCreated)),
                  ],
                ),
                sppaStatus.value.tglLastUpdate != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child:
                                  TextTitleMedium('Tanggal diubah terakhir ')),
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  sppaStatus.value.tglLastUpdate)),
                        ],
                      )
                    : Container(),
                sppaStatus.value.statusSppa == 20
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium('Sppa telah dibatalkan ')),
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  sppaStatus.value.tglLastUpdate)),
                        ],
                      )
                    : Container(),
                sppaStatus.value.initSubmitDt != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  'Tanggal disubmit ke ${sppaHeader.value.salesId} ')),
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  sppaStatus.value.initSubmitDt)),
                        ],
                      )
                    : Container(),
                // Riawayat Sales
                sppaStatus.value.tglReviewSales != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  'Tanggal direview oleh ${sppaHeader.value.salesId} ')),
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  sppaStatus.value.tglReviewSales)),
                        ],
                      )
                    : Container(),
                sppaStatus.value.salesNote != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1, child: TextTitleMedium('Review note ')),
                          Expanded(
                              flex: 1,
                              child:
                                  TextTitleMedium(sppaStatus.value.salesNote)),
                        ],
                      )
                    : Container(),
                sppaStatus.value.tglSubmitSales != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Expanded(
                                flex: 1,
                                child: TextTitleMedium(
                                    'Tanggal disubmit oleh ${sppaHeader.value.salesId}  ')),
                            Expanded(
                                flex: 1,
                                child: TextTitleMedium(
                                    sppaStatus.value.tglSubmitSales)),
                          ])
                    : Container(),
                // Riwayat Marketing
                sppaStatus.value.tglReviewMarketing != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  'Tanggal direview oleh ${sppaHeader.value.marketingId} ')),
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  sppaStatus.value.tglReviewMarketing)),
                        ],
                      )
                    : Container(),
                sppaStatus.value.marketingNote != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1, child: TextTitleMedium('Review note ')),
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  sppaStatus.value.marketingNote)),
                        ],
                      )
                    : Container(),
                sppaStatus.value.tglSubmitBroker != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Expanded(
                                flex: 1,
                                child: TextTitleMedium(
                                    'Tanggal disubmit oleh ${sppaHeader.value.marketingId}  ')),
                            Expanded(
                                flex: 1,
                                child: TextTitleMedium(
                                    sppaStatus.value.tglSubmitMarketing)),
                          ])
                    : Container(),
                // Riwayat Broker
                sppaStatus.value.tglReviewBroker != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  'Tanggal direview oleh ${sppaHeader.value.brokerId} ')),
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  sppaStatus.value.tglReviewBroker)),
                        ],
                      )
                    : Container(),
                sppaStatus.value.salesNote != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1, child: TextTitleMedium('Review note ')),
                          Expanded(
                              flex: 1,
                              child:
                                  TextTitleMedium(sppaStatus.value.brokerNote)),
                        ],
                      )
                    : Container(),
                sppaStatus.value.tglSubmitBroker != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Expanded(
                                flex: 1,
                                child: TextTitleMedium(
                                    'Tanggal disubmit oleh ${sppaHeader.value.brokerId}  ')),
                            Expanded(
                                flex: 1,
                                child: TextTitleMedium(
                                    sppaStatus.value.tglSubmitBroker)),
                          ])
                    : Container(),
                // Riwayat Asuransi
                sppaStatus.value.tglResponseAsuransi != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  'Tanggal diresponse oleh ${sppaHeader.value.asuransiName} ')),
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  sppaStatus.value.tglResponseAsuransi)),
                        ],
                      )
                    : Container(),
                sppaStatus.value.asuransiNote != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium('Response note ')),
                          Expanded(
                              flex: 1,
                              child: TextTitleMedium(
                                  sppaStatus.value.asuransiNote)),
                        ],
                      )
                    : Container(),
                SizedBox(height: 30),
                Divider(thickness: 2)
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

  void getSppaStatusWithSppaId(String sppaId) async {
    String param1;
    http.Response response;

    param1 = '?sppaId=$sppaId';

    var url = Uri.parse(baseUrl + '/SppaStatus' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print(responseBody);
      for (var i = 0; i < responseBody.length; i++) {
        sppaStatus.value = SppaStatus.fromJson(responseBody[i]);
        print('get sppaStatus from sppaId $sppaId berhasil ');
        sppaLoaded.value = true;
      }
    } else {
      print(
          'get sppaStatus from sppaId $sppaId gagal : ${response.statusCode}');
    }
  }

  void getSppaHeaderWithSppaId(String sppaId) async {
    http.Response response;

    var url = Uri.parse(baseUrl + '/SppaHeader/$sppaId');
    print(baseUrl + '/SppaHeader/$sppaId');

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      // print('responseBody ${responseBody}');
//      print('responseBody length : ${responseBody.length}');
//      for (var i = 0; i < responseBody.length; i++) {
      sppaHeader.value = SppaHeader.fromJson(responseBody);
      sppaStatusDisp.value = sppaHeader.value.statusSppa!;

      print('get sppaHeader from sppaId $sppaId berhasil  ');
//      }
    } else {
      print(
          'get sppaHeader from sppaId $sppaId gagal : ${response.statusCode}');
    }
  }

  Future<int> getSppaJumlahTernak(String sppaId) async {
    String param1;
    int ternakCounter = 0;
    http.Response response;

    param1 = '?sppaId=$sppaId';

    var url = Uri.parse(baseUrl + '/TernakSapi' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print(responseBody);
      for (var i = 0; i < responseBody.length; i++) {
        ternakCounter++;
      }
    } else {
      print('get ternak from sppaId $sppaId gagal : ${response.statusCode}');
    }

    return ternakCounter;
  }
}
