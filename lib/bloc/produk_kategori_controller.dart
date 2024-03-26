import "dart:convert";
import "/util/constants.dart" as constant;
import "package:get/get.dart";
import "/model/products.dart";
import 'package:http/http.dart' as http;
//import "../http_access/get_classes.dart";

class ProdukKategoriController extends GetxController {
  ProdukKategoriController();
  //
  final RxInt selected = 1000.obs;
  RxString kategoriSelected = ''.obs;
  RxString subKategoriSelected = ''.obs;
  final RxList<KategoriProduk> listProdukKategori = <KategoriProduk>[].obs;

  String baseUrl = constant.baseUrl;
  var client = http.Client();
  //
  //
  @override
  void onInit() {
    getAllProdukKategori();
    super.onInit();
  }

  void getAllProdukKategori() async {
    var url = Uri.parse(baseUrl + '/KategoriProduk');

    http.Response response = await client.get(url); // no authentication needed
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      for (var i = 0; i < responseBody.length; i++) {
        listProdukKategori.add(KategoriProduk.fromJson(responseBody[i]));
      }
      kategoriSelected.value = listProdukKategori[0].kategoriCode;
      subKategoriSelected.value = listProdukKategori[0].subKategoriCode;
      // print('kat selected : ${kategoriSelected.value}');
      // print('subkat selected : ${subKategoriSelected.value}');
    } else {
      print(response.statusCode.toString());
    }
  }
}
