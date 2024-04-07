import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/model/ternak_sapi.dart';
import 'package:http/http.dart' as http;
import 'package:insurance/util/constants.dart';
import 'package:intl/intl.dart';

class TernakController extends GetxController {
  final GlobalKey<FormState> ternakFormKey = GlobalKey<FormState>();

  var newTernak = TernakSapi();
  late TextEditingController jmlTernakController,
      earTagController,
      dobController,
      jenisController,
      kelaminController,
      perolehanController,
      pertanggunganController;
  RxInt ternakSeqNo = 0.obs;
  var pickedDate = DateTime.now().obs;
  final client = http.Client();
  RxList<TernakSapi> listTernak = <TernakSapi>[].obs;
  var nextButOk = false.obs;

  final sppaController = Get.find<SppaHeaderController>();

  final List<String> jenisSapi = ['SO', 'PO', 'BX', 'Bali', 'Lainnya'];
  final List<String> jenisKelamin = ['Jantan', 'Betina'];

  @override
  void onInit() {
    super.onInit();
    jmlTernakController = TextEditingController();
    earTagController = TextEditingController();
    dobController = TextEditingController();
    jenisController = TextEditingController();
    kelaminController = TextEditingController();
    perolehanController = TextEditingController();
    pertanggunganController = TextEditingController();
    jmlTernakController.text = '0';
  }

  @override
  void onClose() {
    jmlTernakController.dispose();
    earTagController.dispose();
    dobController.dispose();
    jenisController.dispose();
    kelaminController.dispose();
    perolehanController.dispose();
    pertanggunganController.dispose();
  }

  void loadTernak(String sppaId) async {
    // //load ternak
    var param1 = '?sppaId=${sppaId}';
    var url = Uri.parse(baseUrl + '/TernakSapi' + param1);
    print(baseUrl + '/TernakSapi' + param1);
    http.Response response = await client.get(url);
    if (response.statusCode == 200) {
      var responseBodyStatus = jsonDecode(response.body);
      //print(responseBodyStatus);
      for (var i = 0; i < responseBodyStatus.length; i++) {
        listTernak.add(TernakSapi.fromJson(responseBodyStatus[i]));
      }
    } else {
      print('Load ternak error ${response.statusCode}');
    }
  }

  chooseDate() async {
    var getDate = await showDatePicker(
      context: Get.context!,
      initialDate: pickedDate.value, //get today's date
      firstDate: DateTime(
          2020), //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime.now(),
    );
    if (getDate != null && getDate != pickedDate.value) {
      pickedDate.value = getDate;
    }
  }

  void saveATernak() async {
    var url = Uri.parse('$baseUrl/TernakSapi');

    newTernak.earTag = earTagController.text;
    newTernak.tglLahir =
        DateFormat("dd-MMM-yyyy").format(pickedDate.value).toString();
    newTernak.tglLahirMillis = pickedDate.value.millisecondsSinceEpoch;
    newTernak.jenis = jenisController.text;
    newTernak.kelamin = kelaminController.value.text;
    newTernak.hargaPerolehan = double.parse(perolehanController.text);
    newTernak.nilaiPertanggungan = double.parse(pertanggunganController.text);
    newTernak.sppaId = sppaController.sppaHeader.id;
    newTernak.nama = '${newTernak.jenis} - ${newTernak.earTag}';
    newTernak.seqNo =
        ternakSeqNo.value + 1; // new value, but counter is not changed,

    // print('mau save $ternakSeqNo -  ${newTernak.nama} ');

    var body = json.encode(newTernak);
    // print('post ternak body : $body');
    http.Response response = await client.post(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed
    //print('status: ${response.statusCode}');
    //print('body: ${response.body}');
    if (response.statusCode == 201) {
      print('post berhasil, update header');
      // populate listTernak
      var responseBody = jsonDecode(response.body);
      // print('Return Response body: ${responseBody}');
      // print('sppa header id :${responseBody["id"]}');
      // newTernak.id = responseBody["id"];
      listTernak.add(TernakSapi.fromJson(responseBody));

      // next ternak or done
      ternakSeqNo.value++;
      // print('after save ternakSeqNo: ${ternakSeqNo.value}');
      if (ternakSeqNo.value == int.parse(jmlTernakController.text)) {
        nextButOk.value = true;
      }
      // update header on values
      url = Uri.parse('$baseUrl/SppaHeader/${sppaController.sppaHeader.id}');

      sppaController.sppaHeader.nilaiPertanggungan =
          double.parse(pertanggunganController.text) +
              sppaController.sppaHeader.nilaiPertanggungan!;
      sppaController.sppaHeader.premiAmount =
          sppaController.sppaHeader.nilaiPertanggungan! *
              sppaController.sppaHeader.premiRate!;

      body = json.encode(sppaController.sppaHeader);
      // print('mau update sppa Header, body: $body');
      response = await client
          .put(url, body: body, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        print('put update header, saveternak, berhasil');

        // update status
        final saatIni = DateTime.now();
        sppaController.sppaStatus.tglLastUpdate =
            DateFormat("dd-MMM-yyyy").format(saatIni);
        sppaController.sppaStatus.tglLastUpdateMillis =
            saatIni.millisecondsSinceEpoch;

        url = Uri.parse('$baseUrl/SppaStatus/${sppaController.sppaStatus.id}');
        body = json.encode(sppaController.sppaStatus);
        print('$baseUrl/SppaStatus/${sppaController.sppaStatus.id}');
        response = await client.put(url, body: body, headers: {
          'Content-Type': 'application/json'
        }); // no authentication needed
        // print('status: ${response.statusCode}');
        // print('body: ${response.body}');
        if (response.statusCode == 200) {
          print('put status  saveternak, berhasil');
        } else {
          print(
              'put status , saveternak, gagal : ${response.statusCode.toString()}');
        }
      } else {
        print('put update header, saveternak, gagal ${response.statusCode}');
      }
    } else {
      print(response.statusCode.toString());
    }
  }

  void removeFromList(TernakSapi aTernak) async {
    // TODO
    final ternakId = aTernak.id;
    var url = Uri.parse('$baseUrl/TernakSapi/${aTernak.id}');

    // print('mau remove ${aTernak.earTag} id: ${aTernak.id}');

    var body = json.encode(aTernak);
    //print('body : $body');
    http.Response response = await client.delete(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed
    //print('status: ${response.statusCode}');
    //print('body: ${response.body}');
    if (response.statusCode == 200) {
      print('delete ternak berhasil');

      var itemExist =
          listTernak.removeWhere((element) => element.id == aTernak.id);
      print('removed ternak from list.');

      // next ternak or done
      ternakSeqNo.value--;

      // update header
      url = Uri.parse('$baseUrl/SppaHeader/${sppaController.sppaHeader.id}');
      // print(
      //     'pertanggungan awal ${sppaController.sppaHeader.nilaiPertanggungan}');
      sppaController.sppaHeader.nilaiPertanggungan =
          sppaController.sppaHeader.nilaiPertanggungan! -
              aTernak.nilaiPertanggungan!;
      sppaController.sppaHeader.premiAmount =
          sppaController.sppaHeader.nilaiPertanggungan! *
              sppaController.sppaHeader.premiRate!;
      // print(
      //     'pertanggungan akhir ${sppaController.sppaHeader.nilaiPertanggungan}');

      body = json.encode(sppaController.sppaHeader);
      // print('mau update sppa Header, body: $body');
      http.Response response = await client
          .put(url, body: body, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        print('put update header berhasil');
        // update status
        final saatIni = DateTime.now();
        sppaController.sppaStatus.tglLastUpdate =
            DateFormat("dd-MMM-yyyy").format(saatIni);
        sppaController.sppaStatus.tglLastUpdateMillis =
            saatIni.millisecondsSinceEpoch;

        url = Uri.parse('$baseUrl/SppaStatus/${sppaController.sppaStatus.id}');
        body = json.encode(sppaController.sppaStatus);
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
        } else {
          print(response.statusCode.toString());
        }
      } else {
        print('put update header gagal ${response.statusCode}');
      }
    } else {
      print(response.statusCode.toString());
    }
  }
}
