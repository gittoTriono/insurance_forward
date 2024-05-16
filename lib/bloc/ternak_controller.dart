import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/model/sppa_perluasan.dart';
import 'package:insurance/model/ternak_sapi.dart';
import 'package:http/http.dart' as http;
import 'package:insurance/util/constants.dart';
import 'package:intl/intl.dart';

class TernakController extends GetxController {
  final GlobalKey<FormState> ternakFormKey = GlobalKey<FormState>();

  var newTernak = TernakSapi();
  late TextEditingController //jmlTernakController,
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
    //jmlTernakController = TextEditingController();
    earTagController = TextEditingController();
    dobController = TextEditingController();
    jenisController = TextEditingController();
    kelaminController = TextEditingController();
    perolehanController = TextEditingController();
    pertanggunganController = TextEditingController();
    //jmlTernakController.text = '0';
  }

  @override
  void onClose() {
    //jmlTernakController.dispose();
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
    listTernak.clear();

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
    newTernak.nilaiPertanggungan = double.parse(pertanggunganController.text);
    newTernak.hargaPerolehan = newTernak.nilaiPertanggungan;
    newTernak.sppaId = sppaController.sppaHeader.value.id;
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
      // print('sppa header id :${responseBody["id"]}');
      // newTernak.id = responseBody["id"];
      var thisTernak = TernakSapi.fromJson(responseBody);
      listTernak.add(thisTernak);

      // update header on values
      url = Uri.parse(
          '$baseUrl/SppaHeader/${sppaController.sppaHeader.value.id}');

      sppaController.sppaHeader.value.nilaiPertanggungan =
          thisTernak.nilaiPertanggungan! +
              sppaController.sppaHeader.value.nilaiPertanggungan!;
      sppaController.totPertanggungan.value =
          sppaController.sppaHeader.value.nilaiPertanggungan!;
      sppaController.sppaHeader.value.premiAmount =
          sppaController.sppaHeader.value.nilaiPertanggungan! *
              sppaController.sppaHeader.value.premiRate!;

      body = json.encode(sppaController.sppaHeader);
      // print('mau update sppa Header, body: $body');
      response = await client
          .put(url, body: body, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        print('put update header, saveternak, berhasil');

        // update perluasanRisikoSppa kalau ada
        url = Uri.parse(
            '$baseUrl/SppaPerluasanRisiko?sppaId=${sppaController.sppaHeader.value.id}&namaPerluasanRisiko=Anakan');
        print(
            '$baseUrl/SppaPerluasanRisiko?sppaId=${sppaController.sppaHeader.value.id}&namaPerluasanRisiko=Anakan');

        response = await client.get(url, headers: {
          'Content-Type': 'application/json'
        }); // no authentication needed

        if (response.statusCode == 200) {
          print(
              'ada anakan, update sppaPerluasanRisiko juga ${response.statusCode}');
          // print('${response.body} ');

          responseBody = json.decode(response.body);

          if (responseBody.length > 0) {
            var thisPerluasan =
                SppaPerluasanRisiko.fromJson(responseBody[0]); // pasti cuma 1

            thisPerluasan.nilaiPerlindungan = thisPerluasan.nilaiPerlindungan! +
                thisTernak.nilaiPertanggungan! * 0.15; // TODO needs parameter
            thisPerluasan.jumlahTertanggung =
                thisPerluasan.jumlahTertanggung! + 1;
            thisPerluasan.tambahanPremi =
                thisPerluasan.nilaiPerlindungan! * thisPerluasan.rate!;
            sppaController.nilaiAnakan.value = thisPerluasan.nilaiPerlindungan!;
            sppaController.premiAnakan = thisPerluasan.tambahanPremi!;
            print('nilai anakan ${sppaController.nilaiAnakan.value}');
            print('premi anakan ${sppaController.premiAnakan}');

            body = json.encode(thisPerluasan);
            url = Uri.parse('$baseUrl/SppaPerluasanRisiko/${thisPerluasan.id}');
            print('$baseUrl/SppaPerluasanRisiko/${thisPerluasan.id}');
            print('to put $body');

            response = await client.put(url, body: body, headers: {
              'Content-Type': 'application/json'
            }); // no authentication needed

            // print('body: ${response.body}');
            if (response.statusCode == 200) {
              print('put perluasanRisiko anakan berhasil');
            } else {
              print(
                  'put perluasanRisiko anakan , gagal ${response.statusCode}');
            }
          } else {
            print('no anakan ');
          }
        }
      } else {
        print(
            'tidak ada anakan, tidak usah update sppaPerluasanRisiko ${response.statusCode}');
      }
    } else {
      print(response.statusCode.toString());
    }
    //Get.until((route) => Get.currentRoute == '/sppa/main');
    Get.back();
  }

  void deleteATernak(TernakSapi aTernak) async {
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

      // update header
      url = Uri.parse(
          '$baseUrl/SppaHeader/${sppaController.sppaHeader.value.id}');
      // print(
      //     'pertanggungan awal ${sppaController.sppaHeader.value.nilaiPertanggungan}');
      sppaController.sppaHeader.value.nilaiPertanggungan =
          sppaController.sppaHeader.value.nilaiPertanggungan! -
              aTernak.nilaiPertanggungan!;
      sppaController.totPertanggungan.value =
          sppaController.sppaHeader.value.nilaiPertanggungan!;
      sppaController.sppaHeader.value.premiAmount =
          sppaController.sppaHeader.value.nilaiPertanggungan! *
              sppaController.sppaHeader.value.premiRate!;
      // print(
      //     'pertanggungan akhir ${sppaController.sppaHeader.nilaiPertanggungan}');

      body = json.encode(sppaController.sppaHeader);
      // print('mau update sppa Header, body: $body');

      http.Response response = await client
          .put(url, body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        print('put update header berhasil');

        // cek if sppaPerluasanRisiko needs to be updated too
        url = Uri.parse(
            '$baseUrl/SppaPerluasanRisiko?sppaId=${sppaController.sppaHeader.value.id}&namaPerluasanRisiko=Anakan');
        print(
            '$baseUrl/SppaPerluasanRisiko?sppaId=${sppaController.sppaHeader.value.id}&namaPerluasanRisiko=Anakan');

        response = await client.get(url, headers: {
          'Content-Type': 'application/json'
        }); // no authentication needed

        if (response.statusCode == 200) {
          print(
              'ada anakan, update sppaPerluasanRisiko juga ${response.statusCode}');

          var responseBody = json.decode(response.body);

          if (responseBody.length > 0) {
            var thisPerluasan = SppaPerluasanRisiko.fromJson(responseBody[0]);

            thisPerluasan.nilaiPerlindungan = thisPerluasan.nilaiPerlindungan! -
                aTernak.nilaiPertanggungan! *
                    0.15; // TODO needs product parameter for this
            thisPerluasan.jumlahTertanggung =
                thisPerluasan.jumlahTertanggung! - 1;
            thisPerluasan.tambahanPremi =
                thisPerluasan.nilaiPerlindungan! * thisPerluasan.rate!;
            sppaController.nilaiAnakan.value = thisPerluasan.nilaiPerlindungan!;
            sppaController.premiAnakan = thisPerluasan.tambahanPremi!;
            print('nilai anakan ${sppaController.nilaiAnakan.value}');
            print('premi anakan ${sppaController.premiAnakan}');

            body = json.encode(thisPerluasan);
            url = Uri.parse('$baseUrl/SppaPerluasanRisiko/${thisPerluasan.id}');
            print('$baseUrl/SppaPerluasanRisiko/${thisPerluasan.id}');

            response = await client.put(url, body: body, headers: {
              'Content-Type': 'application/json'
            }); // no authentication needed

            // print('body: ${response.body}');
            if (response.statusCode == 200) {
              print('put perluasanRisiko anakan berhasil');
            } else {
              print(
                  'put perluasanRisiko anakan , gagal ${response.statusCode}');
            }
          }
        }
      } else {
        print('put update header gagal ${response.statusCode}');
      }
    } else {
      print(response.statusCode.toString());
    }
  }

  void getTernakWithPolisId(String polisId) async {
    // //load ternak
    var param1 = '?polisId=${polisId}';
    var url = Uri.parse(baseUrl + '/TernakSapi' + param1);
    listTernak.clear();

    print(baseUrl + '/TernakSapi' + param1);

    http.Response response = await client.get(url);

    if (response.statusCode == 200) {
      var responseBodyStatus = jsonDecode(response.body);
      //print(responseBodyStatus);
      for (var i = 0; i < responseBodyStatus.length; i++) {
        listTernak.add(TernakSapi.fromJson(responseBodyStatus[i]));
      }
    } else {
      print(
          'Load ternak error for polis $polisId gagal ${response.statusCode}');
    }
  }
}
