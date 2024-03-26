import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
//import 'package:insurance_inputer/controller/counters.dart';
//import 'package:insurance_inputer/controller/counters_controller.dart';
import '/bloc/produk_controller.dart';
import '/model/info_jastan.dart';
import '/model/customer.dart';
import '/model/products.dart';
import '/model/sppa_header.dart';
//import '/model/ternak_sapi.dart';
import 'package:intl/intl.dart';
import '/util/constants.dart' as constant;
//import 'produk_controller.dart';
//  1 month = 2629745046 milliseconds

class SppaHeaderController extends GetxController {
  final GlobalKey<FormState> sppaFormKey = GlobalKey<FormState>();
  //  final produkController = TextEditingController().obs;

  FocusNode fn1 = FocusNode();
  FocusNode fn2 = FocusNode();

  var appProdukController = Get.find<ProdukController>();

  Rx<TextEditingController> customerController = TextEditingController().obs;
  late TextEditingController produkController;

  ProdukAsuransi selected = ProdukAsuransi();

  var sppaHeader = SppaHeader();
  var sppaStatus = SppaStatus();
  Rx<InfoAtsJasTan> newInfoAts = InfoAtsJasTan().obs;

  var currentStep = 0.obs;
  RxString customerName = ''.obs; // just use theCustomer
  String baseUrl = constant.baseUrl;
  var client = http.Client();
  var custOk = false.obs;
  var prodOk = false.obs;
  var nextButOk = true.obs;
  var theCustomer = Customer().obs;
  var isNewSppa = true.obs;
  ProdukAsuransi? initProduct;

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
    print('done init sppa controller');
  }

  @override
  void onClose() {
    customerController.value.dispose();
    produkController.dispose();
  }

  String sppaStatusDesc(int status) {
    switch (status) {
      case 1:
        return 'Baru';
      case 2:
        return 'Submit 1';
      case 3:
        return 'Tidak Lengkap 1';
      case 4:
        return 'Submit 2';
      case 5:
        return 'Tidak Lengkap 2';
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
    selected = aProd;
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
      print('post berhasil');
      var responseBody = jsonDecode(response.body);
      // print('Return Response body: ${responseBody}');
      // print('sppa header id :${responseBody["id"]}');
      sppaHeader.id = responseBody["id"];

      // SppaStatus second

      // SppaStatus
      final saatIni = DateTime.now();
      sppaStatus.sppaId = sppaHeader.id;
      sppaStatus.statusSppa = 1;
      sppaStatus.tglCreated = DateFormat("dd-MMM-yyyy").format(saatIni);
      sppaStatus.tglCreatedMillis = saatIni.millisecondsSinceEpoch;
      sppaStatus.tglLastUpdate = sppaStatus.tglCreated;
      sppaStatus.tglLastUpdateMillis = sppaStatus.tglCreatedMillis;

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

  void updateHeader() async {
    // Sppa Header first
    var url = Uri.parse('$baseUrl/SppaHeader/${sppaHeader.id}');
    var body = json.encode(sppaHeader);
//    print('body : $body');
    http.Response response = await client.put(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed
    // print('status: ${response.statusCode}');
    // print('body: ${response.body}');
    if (response.statusCode == 200) {
      print('put header berhasil');
      var responseBody = jsonDecode(response.body);
      // print('Return Response body: ${responseBody}');
      // print('sppa header id :${responseBody["id"]}');
      // sppaHeader.id = responseBody["id"];

      // SppaStatus second

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
