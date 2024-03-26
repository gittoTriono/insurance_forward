import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/model/info_jastan.dart';
import '/util/constants.dart' as constant;

class SppaAddInfoController extends GetxController {
  final GlobalKey<FormState> addInfoFormKey = GlobalKey<FormState>();

  late TextEditingController kandangController,
      mgmtKandangController,
      sisPemeliharaanController,
      sisPakanController,
      mgmtPakanController,
      mgmtKesehatanController;

  final sppaController = Get.find<SppaHeaderController>();
  Rx<InfoAtsJasTan> infoAts = InfoAtsJasTan().obs;
  String initKriteriaPemeliharaan = '';
  String initSistemPakan = '';

  String baseUrl = constant.baseUrl;
  var client = http.Client();
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

  @override
  void onInit() {
    super.onInit();
    kandangController = TextEditingController();
    mgmtKandangController = TextEditingController();
    sisPemeliharaanController = TextEditingController();
    sisPakanController = TextEditingController();
    mgmtPakanController = TextEditingController();
    mgmtKesehatanController = TextEditingController();
  }

  void loadInfoData(String sppaId) async {
    // load additional infoAtsJasTan
    final param1 = '?sppaId=${sppaId}';
    final url = Uri.parse(baseUrl + '/InfoAtsJasTan' + param1);
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
    infoAts.value.lokasiKandang = kandangController.text;
    infoAts.value.infoMgmtKandang = mgmtKandangController.text;
    infoAts.value.kriteriaPemeliharaan = sisPemeliharaanController.text;
    infoAts.value.sistemPakanTernak = sisPakanController.text;
    infoAts.value.infoMgmtPakan = mgmtPakanController.text;
    infoAts.value.infoMgmtKesehatan = mgmtKesehatanController.text;
    infoAts.value.sppaId = sppaController.sppaHeader.id;

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

  void updateInfoData() async {
    infoAts.value.lokasiKandang = kandangController.text;
    infoAts.value.infoMgmtKandang = mgmtKandangController.text;
    infoAts.value.kriteriaPemeliharaan = sisPemeliharaanController.text;
    infoAts.value.sistemPakanTernak = sisPakanController.text;
    infoAts.value.infoMgmtPakan = mgmtPakanController.text;
    infoAts.value.infoMgmtKesehatan = mgmtKesehatanController.text;
    infoAts.value.sppaId = sppaController.sppaHeader.id;

    var url = Uri.parse('$baseUrl/InfoAtsJasTan/${infoAts.value.id}');
    var body = json.encode(infoAts.value);
    print('Put sppainfo body : $body');
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
}
