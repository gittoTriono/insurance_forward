import 'dart:convert';

import 'package:get/get.dart';
import 'package:insurance/bloc/dashboard_controller.dart';
import 'package:insurance/bloc/login_controller.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/model/sppa_header.dart';
import 'package:insurance/model/sppa_recap.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '/util/constants.dart' as constant;

class RecapSppaController extends GetxController {
  Rx<RecapSppaHeader> recapHeader = RecapSppaHeader().obs;
  Rx<RecapSppaStatus> recapStatus = RecapSppaStatus().obs;
  Rx<RecapSppaDetail> recapDetail = RecapSppaDetail().obs;

  RxList<RecapSppaDetail> listRecapDetail = <RecapSppaDetail>[].obs;
  RxList<RecapSppaHeader> listRecapHelper = <RecapSppaHeader>[].obs;
  // RxList<RecapSppaHeader> listRecapHeader = <RecapSppaHeader>[].obs;
  // RxList<RecapSppaStatus> listRecapStatus = <RecapSppaStatus>[].obs;

  var selected = RecapSppaHeader().obs;

  RxBool recapLoaded = false.obs;

  final dashboardController =
      Get.find<DashboardController>(); // potential recursive!
  final sppaController = Get.find<SppaHeaderController>();
  final loginController = Get.find<LoginController>();

  String baseUrl = constant.baseUrl;
  var client = http.Client();

  String recapStatusDesc(int status) {
    switch (status) {
      case 1:
        return 'Baru';
      case 2:
        return 'Submit 1';
      case 3:
        return 'Tolak 1';
      case 4:
        return 'Submit 2';
      case 5:
        return 'Tolak 2';
      case 6:
        return 'Submit 3';
      case 7:
        return 'Downloaded';
      case 8:
        return 'Terima Asuransi';
      case 9:
        return 'Tolak Asuransi';
      default:
        return 'Un Def.';
    }
  }

  void createRecapSppa() async {
    // select unit products from aktifSppa
    var set = Set<String>();

    List<SppaHeader> uniqueProd = dashboardController.listAktifSppa
        .where((one) => one.statusSppa == 4)
        .where((e) => set.add(e.produkCode!))
        .toList();
    print('unit produk ${uniqueProd.length}');

    if (uniqueProd.isNotEmpty) {
      for (var i = 0; i < uniqueProd.length; i++) {
        print('$i. create recap utk ${uniqueProd[i].produkName}');

        // calculate first

        recapHeader.value.recapSppaStatus = 1;
        recapHeader.value.salesId = uniqueProd[i].salesId;
        recapHeader.value.marketingId = uniqueProd[i].marketingId;
        recapHeader.value.brokerId = uniqueProd[i].brokerId;
        recapHeader.value.produkAsuransiCode = uniqueProd[i].produkCode;
        recapHeader.value.produkAsuransiNama = uniqueProd[i].produkName;
        recapHeader.value.codeAsuransi = uniqueProd[i].asuransiName;
        recapHeader.value.jumlahTernak = 0;
        recapHeader.value.jumlahSppa = dashboardController.listAktifSppa
            .where((p0) =>
                p0.produkCode == uniqueProd[i].produkCode && p0.statusSppa == 4)
            .fold(0, (previousValue, element) => previousValue! + 1);

        recapHeader.value.totalNilaiPertanggungan = dashboardController
            .listAktifSppa
            .where((p0) =>
                p0.produkCode == uniqueProd[i].produkCode && p0.statusSppa == 4)
            .fold<double>(
                0,
                (previousValue, element) =>
                    previousValue + element.nilaiPertanggungan!);

        print(
            'total pertanggungan ${recapHeader.value.totalNilaiPertanggungan}');

        recapHeader.value.totalNilaiPremi = dashboardController.listAktifSppa
            .where((p0) =>
                p0.produkCode == uniqueProd[i].produkCode && p0.statusSppa == 4)
            .fold<double>(
                0,
                (previousValue, element) =>
                    previousValue + element.premiAmount!);
        print('total pertanggungan ${recapHeader.value.totalNilaiPremi}');

        var url = Uri.parse('$baseUrl/RecapSppaHeader');
        var body = json.encode(recapHeader.value);

        print('$baseUrl/RecapSppaHeader');

        http.Response response = await client.post(url, body: body, headers: {
          'Content-Type': 'application/json'
        }); // no authentication needed

        if (response.statusCode == 201) {
          print('post recapHeader berhasil');

          var responseBody = jsonDecode(response.body);
          recapHeader.value.id = responseBody["id"];

          // load recapSppaHeader to ListRecapHeader
          dashboardController.listRecapHeader.add(recapHeader.value);
          // RecapStatus

          final saatIni = DateTime.now();

          recapStatus.value.recapHeaderId = recapHeader.value.id;
          recapStatus.value.recapSppaStatus = 1;
          recapStatus.value.tglCreated =
              DateFormat("dd-MMM-yyyy").format(saatIni);
          recapStatus.value.tglCreatedMillis = saatIni.millisecondsSinceEpoch;
          // TODO recapStatus.value.createdBy =

          url = Uri.parse('$baseUrl/RecapSppaStatus');
          body = json.encode(recapStatus.value);

          response = await client.post(url, body: body, headers: {
            'Content-Type': 'application/json'
          }); // no authentication needed
          // print('body: ${response.body}');

          if (response.statusCode == 201) {
            print('post recapStatus berhasil');
            responseBody = jsonDecode(response.body);
            recapStatus.value.id = responseBody["id"];

            // upload to listRecapStatus
            dashboardController.listRecapStatus.add(recapStatus.value);
            // create recap detail
            print(
                'target sppa : ${dashboardController.listAktifSppa.where((p0) => p0.produkCode == uniqueProd[i].produkCode && p0.statusSppa == 4).length}');

            int ctr = 1;

            for (var m = 0; m < dashboardController.listAktifSppa.length; m++) {
              sppaController.sppaHeader.value =
                  dashboardController.listAktifSppa[m];
              if (sppaController.sppaHeader.value.produkCode ==
                      uniqueProd[i].produkCode &&
                  sppaController.sppaHeader.value.statusSppa == 4) {
                print(
                    '$ctr. post detail recapDetail ${sppaController.sppaHeader.value.id}');
                ctr++;
                recapDetail.value.customerId =
                    sppaController.sppaHeader.value.customerId;
                recapDetail.value.recapHeaderId = recapHeader.value.id;
                recapDetail.value.sppaId = sppaController.sppaHeader.value.id;
                recapDetail.value.produkAsuransiCode =
                    sppaController.sppaHeader.value.produkCode;
                recapDetail.value.produkAsuransiNama =
                    sppaController.sppaHeader.value.produkName;
                // recapDetail. jumlahTernak;
                recapDetail.value.nilaiPertanggungan =
                    sppaController.sppaHeader.value.nilaiPertanggungan;
                recapDetail.value.nilaiPremi =
                    sppaController.sppaHeader.value.premiAmount;

                recapHeader.value.jumlahTernak =
                    recapHeader.value.jumlahTernak! +
                        await sppaController.getSppaJumlahTernak(
                            sppaController.sppaHeader.value.id!);

                url = Uri.parse('$baseUrl/RecapSppaDetail');
                body = json.encode(recapDetail.value);

                // print('body : $body');
                response = await client.post(url, body: body, headers: {
                  'Content-Type': 'application/json'
                }); // no authentication needed
                // print('body: ${response.body}');

                if (response.statusCode == 201) {
                  print('post recapDetail berhasil');
                  // listRecapDetail is not populated, as multiple recap is created at once

                  // SppaHeader update too, yaitu dashboardController.listAktifSppa[j]

                  sppaController.sppaHeader.value.statusSppa = 5;

                  url = Uri.parse(
                      '$baseUrl/SppaHeader/${sppaController.sppaHeader.value.id}');
                  print(
                      'put sppaHeader $baseUrl/SppaHeader/${sppaController.sppaHeader.value.id}');

                  body = json.encode(sppaController.sppaHeader);

                  response = await client.put(url, body: body, headers: {
                    'Content-Type': 'application/json'
                  }); // no authentication needed

                  if (response.statusCode == 200) {
                    print('put sppaheader berhasil ');
                  } else {
                    print('put sppaHeader gagal ${response.statusCode}');
                  }

                  // sppaStatus updated too, find first
                  sppaController.getSppaStatusWithSppaId(
                      sppaController.sppaHeader.value.id!);

                  print(
                      'trying put sppaStatus id ${sppaController.sppaStatus.value.id} sppaId ${sppaController.sppaStatus.value.sppaId}');
                  sppaController.sppaStatus.value.statusSppa = 5;
                  sppaController.sppaStatus.value.recapSppaId =
                      recapHeader.value.id!;
                  sppaController.sppaStatus.value.tglRecapMillis =
                      recapStatus.value.tglCreatedMillis!;
                  sppaController.sppaStatus.value.tglRecap =
                      recapStatus.value.tglCreated!;

                  url = Uri.parse(
                      '$baseUrl/SppaStatus/${sppaController.sppaStatus.value.id}');
                  print(
                      'put sppaStatus $baseUrl/SppaStatus/${sppaController.sppaStatus.value.id}');
                  body = json.encode(sppaController.sppaStatus);

                  response = await client.put(url, body: body, headers: {
                    'Content-Type': 'application/json'
                  }); // no authentication needed

                  if (response.statusCode == 200) {
                    print('put sppaStatus berhasil ');
                  } else {
                    print('put sppaStatus gagal ${response.statusCode}');
                  }
                } else {
                  print('post recapDetail gagal ${response.statusCode}');
                }
              }
            }
          } else {
            print('post recapStatus gagal ${response.statusCode}');
          }

          // update jumlah ternak already set in the recapHeader
          url = Uri.parse('$baseUrl/SppaRecapHeader/${recapHeader.value.id}');
          body = json.encode(recapHeader.value);

          response = await client.put(url, body: body, headers: {
            'Content-Type': 'application/json'
          }); // no authentication needed

          if (response.statusCode == 200) {
            print('put recap header jumlah ternak berhasil ');
          } else {
            print(
                'put recap header jumlah ternak gagal ${response.statusCode}');
          }
        } else {
          print('post recapHeader gagal ${response.statusCode}');
        }
      }
    }
  }

  void createListRecapHeaderHelper(String mode) {
    switch (mode) {
      case 'ToDo':
        if (loginController.check.value.roles == 'ROLE_ADMIN') {
          print(loginController.check.value.roles);
          listRecapHelper.addAll(dashboardController.listRecapHeader
              .where((p0) => dashboardController.salesRecapTodo
                  .contains(p0.recapSppaStatus))
              .toList());
          print('helper length ${listRecapHelper.length}');
        } else if (loginController.check.value.roles == 'ROLE_Marketing') {
          print(loginController.check.value.roles);
          listRecapHelper.addAll(dashboardController.listRecapHeader
              .where((p0) => dashboardController.marketingRecapTodo
                  .contains(p0.recapSppaStatus))
              .toList());
          print('helper length ${listRecapHelper.length}');
        } else if (loginController.check.value.roles == 'ROLE_Broker') {
          print(loginController.check.value.roles);
          listRecapHelper.addAll(dashboardController.listRecapHeader
              .where((p0) => dashboardController.brokerRecapTodo
                  .contains(p0.recapSppaStatus))
              .toList());
          print('helper length ${listRecapHelper.length}');
        }

      case 'Submit':
        if (loginController.check.value.roles == 'ROLE_ADMIN') {
          print(loginController.check.value.roles);
          listRecapHelper.addAll(dashboardController.listRecapHeader
              .where((p0) => dashboardController.salesRecapSubmit
                  .contains(p0.recapSppaStatus))
              .toList());
          print('helper length ${listRecapHelper.length}');
        } else if (loginController.check.value.roles == 'ROLE_Marketing') {
          print(loginController.check.value.roles);
          listRecapHelper.addAll(dashboardController.listRecapHeader
              .where((p0) => dashboardController.marketingRecapSubmit
                  .contains(p0.recapSppaStatus))
              .toList());
          print('helper length ${listRecapHelper.length}');
        } else if (loginController.check.value.roles == 'ROLE_Broker') {
          print(loginController.check.value.roles);
          listRecapHelper.addAll(dashboardController.listRecapHeader
              .where((p0) => dashboardController.brokerRecapTodo
                  .contains(p0.recapSppaStatus))
              .toList());
          print('helper length ${listRecapHelper.length}');
        }
    }
  }

  void getRecapDetail(String recapHeaderId) async {
    String param1;

    var responseBody;

    http.Response response;

    param1 = '$baseUrl/RecapSppaDetail?recapHeaderId=$recapHeaderId';
    print(param1);
    Uri url = Uri.parse(param1);

    response = await client.get(url);

    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBody.length; i++) {
        listRecapDetail.add(RecapSppaDetail.fromJson(responseBody[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load ${i + 1} items');
      }
    } else {
      print('load recapSppaDetail gagal ${response.statusCode}');
    }
  }

  void dialogRiwayat() async {}
}
