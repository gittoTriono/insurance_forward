import "dart:convert";
import "package:intl/date_symbol_data_local.dart";

import "/util/constants.dart" as constant;
import "package:get/get.dart";
import "/model/products.dart";
import 'package:http/http.dart' as http;

import "produk_kategori_controller.dart";

class ProdukController extends GetxController {
  Rx<ProdukAsuransi> selected = ProdukAsuransi().obs;
  final RxList<ProdukAsuransi> listSelectedProdukAsuransi =
      <ProdukAsuransi>[].obs;
  RxList<ProdukAsuransi> listAllProdukAsuransi = <ProdukAsuransi>[].obs;

  String baseUrl = constant.baseUrl;
  var client = http.Client();
  //
  //
  @override
  void onReady() {
    super.onReady();
    // final ProdukKategoriController theProdKatCtrl = Get.find();
    // print('in prod ctrl subkat : ${theProdKatCtrl.subKategoriSelected.value}');
    // if (theProdKatCtrl.kategoriSelected.value != '') {
    //   getProdukAsuransiSelectedKategori();
    // }
  }

  @override
  void onClose() {
    super.onClose();
  }

// http://localhost:3000/produkAsuransi?productPertanggunganSubCtgry=SP
  void getProdukAsuransiSelectedKategori() async {
    final ProdukKategoriController katCtrl = Get.find();
    final String param1 = '?productKategori=${katCtrl.kategoriSelected.value}';
    final String param2 =
        '&productSubKategori=${katCtrl.subKategoriSelected.value}';

    // print(baseUrl + '/ProdukAsuransi' + param1 + param2);
    var url = Uri.parse(baseUrl + '/ProdukAsuransi' + param1 + param2);

    http.Response response = await client.get(url); // no authentication needed
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      for (var i = 0; i < responseBody.length; i++) {
        listSelectedProdukAsuransi
            .add(ProdukAsuransi.fromJson(responseBody[i]));
        print('add 1 produk');
      }
      if (listSelectedProdukAsuransi.isNotEmpty) {
        selected.value = listSelectedProdukAsuransi[0];
      }
    } else {
      print(response.statusCode.toString());
    }
  }

  void getProdukAsuransiAll() async {
    //print(baseUrl + '/produkAsuransi' + param1 + param2);
    var url = Uri.parse(baseUrl + '/ProdukAsuransi');
    if (listAllProdukAsuransi.isEmpty) {
      http.Response response =
          await client.get(url); // no authentication needed
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        // print('produk responseBody: ${responseBody}');
        for (var i = 0; i < responseBody.length; i++) {
          listAllProdukAsuransi.add(ProdukAsuransi.fromJson(responseBody[i]));
          // print('add 1 produk');
        }
//        print('jumlah produk ${listAllProdukAsuransi.length}');
      } else {
        print(response.statusCode.toString());
      }
    } else {
      // print(
      //     'listallprodukasuransi sudah terisi ${listAllProdukAsuransi.length}');
    }
  }
}
