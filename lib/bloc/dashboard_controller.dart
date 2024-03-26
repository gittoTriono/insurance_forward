import "dart:convert";
import "package:get/get.dart";
import "package:insurance/bloc/login_controller.dart";
import "package:insurance/bloc/session_controller.dart";
import "package:insurance/bloc/theme_controller.dart";
import "package:insurance/model/info_jastan.dart";
import "package:insurance/model/sppa_header.dart";
import "package:insurance/model/ternak_sapi.dart";
import "package:insurance/util/constants.dart";
import 'package:http/http.dart' as http;
//import "/model/products.dart";
import "/util/constants.dart" as constant;

class DashboardController extends GetxController {
  RxList<SppaHeader> listAktifSppa = <SppaHeader>[].obs;
  RxList<SppaStatus> listAktifSppaStatus = <SppaStatus>[].obs;
  RxList<TernakSapi> listAktifSppaTernak = <TernakSapi>[].obs;
  RxList<InfoAtsJasTan> listAktifSppaInfo = <InfoAtsJasTan>[].obs;

  LoginController loginController = Get.find();
  SessionController sessionController = Get.find();
  ThemeController themeController = Get.find();
  var client = http.Client();

  void onInit() {
    super.onInit();
    sessionController.registerActivity();
    if (loginController.check.value.roles.contains("ROLE_SUPER") ||
        loginController.check.value.roles.contains("ROLE_ADMIN")) {
      getAktifSppaBroker();
    } else {
      getAktifSppaCustomer();
    }
  }

  void getAktifSppaBroker() async {
    //print('userRole: $userRole & userName: $userName');
    var param1 = '?brokerId=1&statusSppa=1';

    print(baseUrl + '/SppaHeader' + param1);
    var url = Uri.parse(baseUrl + '/SppaHeader' + param1);

    http.Response response = await client.get(url); // no authentication needed
    if (response.statusCode == 200) {
      var responseBodySppa = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBodySppa.length; i++) {
        listAktifSppa.add(SppaHeader.fromJson(responseBodySppa[i]));
        print('add 1 sppa and details: ${listAktifSppa[i].id}');
        // status
        param1 = '?sppaId=${listAktifSppa[i].id}';
        url = Uri.parse(baseUrl + '/SppaStatus' + param1);
        response = await client.get(url);
        if (response.statusCode == 200) {
          var responseBodyStatus = jsonDecode(response.body);
          //print(responseBodyStatus);
          for (var j = 0; j < responseBodyStatus.length; j++) {
            listAktifSppaStatus.add(SppaStatus.fromJson(responseBodyStatus[j]));
          }
        } else {
          print('Load status error ${response.statusCode}');
        }
        print('load ${i} items');
      }
    } else {
      print(response.statusCode.toString());
    }
  }

  void getAktifSppaCustomer() async {
    final userRole = loginController.check.value.roles;
    final userName = loginController.check.value.userData.name;

    //print('userRole: $userRole & userName: $userName');
    var param1 = '?customerId=${userName}&statusSppa=1';

    print(baseUrl + '/SppaHeader' + param1);
    var url = Uri.parse(baseUrl + '/SppaHeader' + param1);

    http.Response response = await client.get(url); // no authentication needed
    if (response.statusCode == 200) {
      var responseBodySppa = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBodySppa.length; i++) {
        listAktifSppa.add(SppaHeader.fromJson(responseBodySppa[i]));
        print('add 1 sppa and details: ${listAktifSppa[i].id}');
        // status
        param1 = '?sppaId=${listAktifSppa[i].id}';
        url = Uri.parse(baseUrl + '/SppaStatus' + param1);
        response = await client.get(url);
        if (response.statusCode == 200) {
          var responseBodyStatus = jsonDecode(response.body);
          //print(responseBodyStatus);
          for (var j = 0; j < responseBodyStatus.length; j++) {
            listAktifSppaStatus.add(SppaStatus.fromJson(responseBodyStatus[j]));
          }
        } else {
          print('Load status error ${response.statusCode}');
        }
        // //load ternak ternak
        //param1 = '?sppaId=${listAktifSppa[i].id}';
        // url = Uri.parse(baseUrl + '/TernakSapi' + param1);
        // response = await client.get(url);
        // if (response.statusCode == 200) {
        //   var responseBodyStatus = jsonDecode(response.body);
        //   //print(responseBodyStatus);
        //   for (var i = 0; i < responseBodyStatus.length; i++) {
        //     listAktifSppaTernak.add(TernakSapi.fromJson(responseBodyStatus[i]));
        //   }
        // } else {
        //   print('Load ternak error ${response.statusCode}');
        // }
        // // load additional infoAtsJasTan
        //param1 = '?sppaId=${listAktifSppa[i].id}';
        // url = Uri.parse(baseUrl + '/InfoAtsJasTan' + param1);
        // response = await client.get(url);
        // if (response.statusCode == 200) {
        //   var responseBodyStatus = jsonDecode(response.body);
        //   //print(responseBodyStatus);
        //   for (var i = 0; i < responseBodyStatus.length; i++) {
        //     listAktifSppaInfo
        //         .add(InfoAtsJasTan.fromJson(responseBodyStatus[i]));
        //   }
        // } else {
        //   print('Load add info jastan error ${response.statusCode}');
        // }
        print('load ${i} items');
      }
    } else {
      print(response.statusCode.toString());
    }
  }
}
