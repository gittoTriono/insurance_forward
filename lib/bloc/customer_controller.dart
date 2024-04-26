import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:insurance/bloc/login_controller.dart';
// import 'package:insurance/model/customer.dart';
import 'package:insurance/model/kandang_sapi.dart';
import 'package:insurance/model/user_data2.dart';
import 'package:insurance/util/constants.dart';

class CustomerController extends GetxController {
  final loginController = Get.find<LoginController>();

  final GlobalKey<FormState> CustomerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> kandangFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> alamatFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> identitasFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> perbankanFormKey = GlobalKey<FormState>();

  FocusNode fn1 = FocusNode();
  FocusNode fn2 = FocusNode();

  Rx<Customer2> theCustomer = Customer2().obs;
  RxList<Customer2> customerList = <Customer2>[].obs;
  RxBool custIsLoaded = false.obs;
  RxBool custListIsLoaded = false.obs;

  RxString pekerjaan = ''.obs;
  List<String> listPerkerjaan = [
    'Peternak',
    'Karyawan',
    'Wiraswasta',
    'Mahasiswa',
    'Pensiunan',
    'TNI/Polri'
  ];
  String initPekerjaan = '';

  RxList<KandangSapi> listKandang = <KandangSapi>[].obs;
  KandangSapi theKandang = KandangSapi();
  RxBool kandangIsLoaded = false.obs;

  RxBool kandangLoaded = false.obs;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController noHpCtrl = TextEditingController();
  TextEditingController namaCtrl = TextEditingController();
  TextEditingController pekerjaanCtrl = TextEditingController();
  TextEditingController jalanCtrl = TextEditingController();
  TextEditingController rtCtrl = TextEditingController();
  TextEditingController rwCtrl = TextEditingController();
  TextEditingController kelurahanCtrl = TextEditingController();
  TextEditingController kecamatanCtrl = TextEditingController();
  TextEditingController kabupatenCtrl = TextEditingController();
  TextEditingController kotaCtrl = TextEditingController();
  TextEditingController kodePosCtrl = TextEditingController();
  TextEditingController ktpCtrl = TextEditingController();
  TextEditingController pobCtrl = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();
  TextEditingController bankCtrl = TextEditingController();
  TextEditingController accntNoCtrl = TextEditingController();
  TextEditingController namaAccntCtrl = TextEditingController();
  TextEditingController kelompokCtrl = TextEditingController();
  TextEditingController noAnggotaCtrl = TextEditingController();

  TextEditingController kdgNamaCtrl = TextEditingController();
  TextEditingController kdgJenisCtrl = TextEditingController();
  TextEditingController kdgLuasCtrl = TextEditingController();
  TextEditingController kdgKpstCtrl = TextEditingController();
  TextEditingController kdgKtrgnCtrl = TextEditingController();
  TextEditingController kdgFoto1Ctrl = TextEditingController();
  TextEditingController kdgFoto2Ctrl = TextEditingController();
  TextEditingController kdgJalanCtrl = TextEditingController();
  TextEditingController kdgRtCtrl = TextEditingController();
  TextEditingController kdgRwCtrl = TextEditingController();
  TextEditingController kdgKelurahanCtrl = TextEditingController();
  TextEditingController kdgKecamatanCtrl = TextEditingController();
  TextEditingController kdgKabupatenCtrl = TextEditingController();
  TextEditingController kdgKotaCtrl = TextEditingController();
  TextEditingController kdgKodePosCtrl = TextEditingController();
  var client = http.Client();

  @override
  void onClose() {
    emailCtrl.dispose();
    noHpCtrl.dispose();
    namaCtrl.dispose();
    pekerjaanCtrl.dispose();
    jalanCtrl.dispose();
    rtCtrl.dispose();
    rwCtrl.dispose();
    kelurahanCtrl.dispose();
    kecamatanCtrl.dispose();
    kabupatenCtrl.dispose();
    kotaCtrl.dispose();
    kodePosCtrl.dispose();
    ktpCtrl.dispose();
    pobCtrl.dispose();
    dobCtrl.dispose();
    bankCtrl.dispose();
    accntNoCtrl.dispose();
    namaAccntCtrl.dispose();
  }

  void initPageData() {
    // convert from user_data to user_data2
    getSppaCustomer(loginController.check.value.userData.name);
  }

  void getSppaCustomer(String custId) async {
    var param1 = '/$custId';
    custIsLoaded.value = false;

    print(baseUrl + '/Customer2' + param1);
    var url = Uri.parse(baseUrl + '/Customer2' + param1);

    http.Response response = await client.get(url); // no authentication needed
    if (response.statusCode == 200) {
      var responseBodySppa = jsonDecode(response.body);
      // print(responseBodySppa);
      theCustomer.value = Customer2.fromJson(responseBodySppa);
      print('get customer berhasil ${theCustomer.value.name}');
      custIsLoaded.value = true;
      pekerjaan.value = theCustomer.value.pekerjaan!;
    } else {
      print('error get Customer $custId : ${response.statusCode}');
    }
  }

  void saveCustProfile() async {}

  void updateCustProfile() async {}

  void getKandangSapi() async {
    var param1 = '?customerId=${theCustomer.value.id}';
    kandangIsLoaded.value = false;

    print(baseUrl + '/KandangSapi' + param1);
    var url = Uri.parse(baseUrl + '/KandangSapi' + param1);

    http.Response response = await client.get(url); // no authentication needed
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      // print(responseBodySppa);
      for (var i = 0; i < responseBody.length; i++) {
        listKandang.add(KandangSapi.fromJson(responseBody[i]));

        print(' ${i + 1} get kandang berhasil ${theCustomer.value.name}');
        kandangIsLoaded.value = true;
      }
    } else {
      print(
          'error get kandangnya ${theCustomer.value.id} : ${response.statusCode}');
    }
  }

  void saveKandangSapi() async {
    kandangIsLoaded.value = false;
    String body;
    theKandang.customerId = theCustomer.value.id;
    theKandang.namaKandang = kdgNamaCtrl.text;
    theKandang.jenis = kdgJenisCtrl.text;
    theKandang.luas = double.parse(kdgLuasCtrl.text);
    theKandang.kapasitas = int.parse(kdgKpstCtrl.text);
    theKandang.fasilitas = kdgKtrgnCtrl.text;
    theKandang.jalan = kdgJalanCtrl.text;
    theKandang.rt = kdgRtCtrl.text;
    theKandang.rw = kdgRwCtrl.text;
    theKandang.kelurahan = kdgKelurahanCtrl.text;
    theKandang.kecamatan = kdgKecamatanCtrl.text;
    theKandang.kabupaten = kdgKabupatenCtrl.text;
    theKandang.kota = kdgKotaCtrl.text;
    theKandang.kodePos = kdgKodePosCtrl.text;

    print(baseUrl + '/KandangSapi');
    var url = Uri.parse(baseUrl + '/KandangSapi');

    body = jsonEncode(theKandang);

    http.Response response = await client.post(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed

    // print('body: ${response.body}');
    if (response.statusCode == 201) {
      var responseBody = jsonDecode(response.body);
      theKandang.id = responseBody['id'];
      listKandang.add(theKandang);
      // print(responseBodySppa);

      print('post kandang berhasil ${theKandang.namaKandang}');
      kandangIsLoaded.value = true;
    } else {
      print(
          'epost kandangnya gagal ${theKandang.namaKandang} : ${response.statusCode}');
    }
  }

  void updateKandangSapi() async {
    String body;

    kandangIsLoaded.value = false;
    theKandang.customerId = theCustomer.value.id;
    theKandang.namaKandang = kdgNamaCtrl.text;
    theKandang.jenis = kdgJenisCtrl.text;
    theKandang.luas = double.parse(kdgLuasCtrl.text);
    theKandang.kapasitas = int.parse(kdgKpstCtrl.text);
    theKandang.fasilitas = kdgKtrgnCtrl.text;
    theKandang.jalan = kdgJalanCtrl.text;
    theKandang.rt = kdgRtCtrl.text;
    theKandang.rw = kdgRwCtrl.text;
    theKandang.kelurahan = kdgKelurahanCtrl.text;
    theKandang.kecamatan = kdgKecamatanCtrl.text;
    theKandang.kabupaten = kdgKabupatenCtrl.text;
    theKandang.kota = kdgKotaCtrl.text;
    theKandang.kodePos = kdgKodePosCtrl.text;

    print(baseUrl + '/KandangSapi/${theKandang.id}');
    var url = Uri.parse(baseUrl + '/KandangSapi/${theKandang.id}');

    body = jsonEncode(theKandang);

    http.Response response = await client.put(url, body: body, headers: {
      'Content-Type': 'application/json'
    }); // no authentication needed

    // print('body: ${response.body}');
    if (response.statusCode == 200) {
      listKandang.removeWhere((element) => element.id == theKandang.id);

      listKandang.add(theKandang);

      print('put kandang berhasil ${theKandang.namaKandang}');
      kandangIsLoaded.value = true;
    } else {
      print(
          'put kandangnya gagal ${theKandang.namaKandang} : ${response.statusCode}');
    }
  }
}
