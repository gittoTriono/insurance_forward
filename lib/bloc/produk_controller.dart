import "dart:convert";
//import "package:intl/date_symbol_data_local.dart";

import "/util/constants.dart" as constant;
import "package:get/get.dart";
import "/model/products.dart";
import 'package:http/http.dart' as http;

import "produk_kategori_controller.dart";

class ProdukController extends GetxController {
  Rx<ProdukAsuransi> selected = ProdukAsuransi().obs;
  RxList<PerluasanRisiko> listPerluasanRisiko = <PerluasanRisiko>[].obs;
  RxBool listPerluasanJaminanLoaded = false.obs;
  // RxList<CheckBoxModal> checkBoxPerluasanJaminan = <CheckBoxModal>[].obs;
  // RxList<RxBool> listPilihan = <RxBool>[].obs;

  final RxList<ProdukAsuransi> listSelectedProdukAsuransi =
      <ProdukAsuransi>[].obs;
  RxList<ProdukAsuransi> listAllProdukAsuransi = <ProdukAsuransi>[].obs;
  RxBool listAllProdloaded = false.obs;
  RxBool selectedIsLoaded = false.obs;

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
    listAllProdloaded.value = false;
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
        listAllProdloaded.value = true;
      } else {
        print(response.statusCode.toString());
      }
    } else {
      // print(
      //     'listallprodukasuransi sudah terisi ${listAllProdukAsuransi.length}');
    }
  }

  void getProdukAsuransi(String codeProduct) async {
    String param1 = '?productCode=$codeProduct';
    selectedIsLoaded.value = false;
    print(baseUrl + '/produkAsuransi' + param1);
    var url = Uri.parse(baseUrl + '/ProdukAsuransi' + param1);
    http.Response response = await client.get(url); // no authentication needed
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      // print('produk responseBody: ${responseBody}');
      for (var i = 0; i < responseBody.length; i++) {
        selected.value = ProdukAsuransi.fromJson(responseBody[i]);
        print('get produk $codeProduct');
      }
      selectedIsLoaded.value = true;
    } else {
      print(response.statusCode.toString());
    }
  }

  void getPerluasanJaminan() async {
    listPerluasanRisiko.clear();
    // checkBoxPerluasanJaminan.clear();
    // listPilihan.clear();

    listPerluasanJaminanLoaded.value = false;
    print('di getPerluasanJaminan selected: ${selected.value.productName}');
    final String param1 = '?kategori=${selected.value.productKategori}';
    final String param2 = '&subKategori=${selected.value.productSubKategori}';
    final String param3 = '&codeAsuransi=${selected.value.codeAsuransi}';

    print(baseUrl + '/PerluasanRisiko' + param1 + param2 + param3);
    var url =
        Uri.parse(baseUrl + '/PerluasanRisiko' + param1 + param2 + param3);

    http.Response response = await client.get(url); // no authentication needed
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      for (var i = 0; i < responseBody.length; i++) {
        listPerluasanRisiko.add(PerluasanRisiko.fromJson(responseBody[i]));
      }
      print('add ${listPerluasanRisiko.length} perluasan risiko');
      listPerluasanJaminanLoaded.value = true;
    } else {
      print(response.statusCode.toString());
    }
  }
}
