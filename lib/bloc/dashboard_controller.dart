import "dart:convert";
import "package:get/get.dart";
import "package:insurance/bloc/login_controller.dart";
import "package:insurance/bloc/session_controller.dart";
import "package:insurance/bloc/sppa_controller.dart";
import "package:insurance/bloc/sppa_recap_controller.dart";
import "package:insurance/bloc/theme_controller.dart";
import "package:insurance/model/info_jastan.dart";
import "package:insurance/model/sppa_header.dart";
import "package:insurance/model/sppa_recap.dart";
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

  RxList<RecapSppaDetail> listRecapDetail = <RecapSppaDetail>[].obs;
  RxList<RecapSppaHeader> listRecapHeader = <RecapSppaHeader>[].obs;
  RxList<RecapSppaStatus> listRecapStatus = <RecapSppaStatus>[].obs;

  LoginController loginController = Get.find();
  SessionController sessionController = Get.find();
  ThemeController themeController = Get.find();

  SppaHeaderController sppaController = Get.put(SppaHeaderController());
//  RecapSppaController recapController = Get.put(RecapSppaController());

  // Sppa Status
  final List<int> custTodo = [1, 3];
  final List<int> custSubmit = [2, 4, 5, 6];
  final List<int> salesTodo = [2];
  final List<int> salesSubmit = [4];

  // RecapSppa Status
  final List<int> salesRecapTodo = [1, 3];
  final List<int> salesRecapSubmit = [2, 4, 6];
  final List<int> marketingRecapTodo = [2, 5];
  final List<int> marketingRecapSubmit = [4, 6, 7];
  final List<int> brokerRecapTodo = [4];
  final List<int> brokerRecapSubmit = [6, 7];

  var client = http.Client();

  void onInit() {
    super.onInit();
    sessionController.registerActivity();
    if (loginController.check.value.roles.contains("ROLE_ADMIN")) {
      getAktifSppaSales();
      getAktifRecapSales();
    } else {
      getAktifSppaCustomer();
    }
  }

  void getAktifSppaSales() async {
    //print('userRole: $userRole & userName: $userName');
    // get for status 2 and 4
    var responseBodySppa;
    http.Response response;

    var param1 =
        '?salesId=${loginController.check.value.userData.name}&statusSppa=2';

    print(baseUrl + '/SppaHeader' + param1);
    var url = Uri.parse(baseUrl + '/SppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      responseBodySppa = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBodySppa.length; i++) {
        listAktifSppa.add(SppaHeader.fromJson(responseBodySppa[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load ${i} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    param1 =
        '?salesId=${loginController.check.value.userData.name}&statusSppa=4';

    print(baseUrl + '/SppaHeader' + param1);
    url = Uri.parse(baseUrl + '/SppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBodySppa = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBodySppa.length; i++) {
        listAktifSppa.add(SppaHeader.fromJson(responseBodySppa[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load ${i} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    // get sppaStatus

    for (var j = 0; j < listAktifSppa.length; j++) {
      param1 = '?sppaId=${listAktifSppa[j].id}';
      url = Uri.parse(baseUrl + '/SppaStatus' + param1);

      response = await client.get(url);
      if (response.statusCode == 200) {
        var responseBodyStatus = jsonDecode(response.body);
        //print(responseBodyStatus);
        for (var k = 0; k < responseBodyStatus.length; k++) {
          listAktifSppaStatus.add(SppaStatus.fromJson(responseBodyStatus[k]));
          print('Load status berhasil ');
        }
      } else {
        print('Load status error ${response.statusCode}');
      }
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
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
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
    // must get 2 times: status 1 and status 3 = maybe more later
    final userRole = loginController.check.value.roles;
    final userName = loginController.check.value.userData.name;

    // print('userRole: $userRole & userName: $userName');
    var param1 = '?customerId=${userName}&statusSppa=1';

    print(baseUrl + '/SppaHeader' + param1);
    var url = Uri.parse(baseUrl + '/SppaHeader' + param1);

    http.Response response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBodySppa = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBodySppa.length; i++) {
        listAktifSppa.add(SppaHeader.fromJson(responseBodySppa[i]));
        print('${i + 1} sppa : ${listAktifSppa[i].id}');
      }
    } else {
      print(response.statusCode.toString());
    }

    // *********************************************************************
    // print('userRole: $userRole & userName: $userName');
    param1 = '?customerId=${userName}&statusSppa=3';

    print(baseUrl + '/SppaHeader' + param1);
    url = Uri.parse(baseUrl + '/SppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBodySppa = jsonDecode(response.body);
      //print('response body :$responseBodySppa');

      for (var i = 0; i < responseBodySppa.length; i++) {
        listAktifSppa.add(SppaHeader.fromJson(responseBodySppa[i]));
        print('${i + 1} sppa : ${listAktifSppa[i].id}');

        print('load ${i} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    // *********************************************************************
    // print('userRole: $userRole & userName: $userName');
    param1 = '?customerId=${userName}&statusSppa=2';

    print(baseUrl + '/SppaHeader' + param1);
    url = Uri.parse(baseUrl + '/SppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBodySppa = jsonDecode(response.body);
      //print('response body :$responseBodySppa');

      for (var i = 0; i < responseBodySppa.length; i++) {
        listAktifSppa.add(SppaHeader.fromJson(responseBodySppa[i]));
        print('${i + 1} sppa : ${listAktifSppa[i].id}');

        print('load ${i} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    // *********************************************************************

    param1 = '?customerId=${userName}&statusSppa=4';

    print(baseUrl + '/SppaHeader' + param1);
    url = Uri.parse(baseUrl + '/SppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBodySppa = jsonDecode(response.body);
      //print('response body :$responseBodySppa');

      for (var i = 0; i < responseBodySppa.length; i++) {
        listAktifSppa.add(SppaHeader.fromJson(responseBodySppa[i]));
        print('${i + 1} sppa : ${listAktifSppa[i].id}');

        print('load ${i} items');
      }
    } else {
      print(response.statusCode.toString());
    }

// ****************************************************************************
    for (var i = 0; i < listAktifSppa.length; i++) {
      // get sppaStatus for all in list
      param1 = '?sppaId=${listAktifSppa[i].id}';
      url = Uri.parse(baseUrl + '/SppaStatus' + param1);

      response = await client.get(url);

      if (response.statusCode == 200) {
        var responseBodyStatus = jsonDecode(response.body);
        //print(responseBodyStatus);
        for (var j = 0; j < responseBodyStatus.length; j++) {
          listAktifSppaStatus.add(SppaStatus.fromJson(responseBodyStatus[j]));
          print('${j + 1} add sppaStatus utk sppa ${listAktifSppa[i].sppaId}');
        }
      } else {
        print('Load status error ${response.statusCode}');
      }
    }
  }

  void getAktifRecapSales() async {
    //print('userRole: $userRole & userName: $userName');
    // get for status 2 and 4
    var responseBody;
    http.Response response;

    var param1 =
        '?salesId=${loginController.check.value.userData.name}&recapSppaStatus=1';

    print(baseUrl + '/RecapSppaHeader' + param1);
    var url = Uri.parse(baseUrl + '/RecapSppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBody.length; i++) {
        listRecapHeader.add(RecapSppaHeader.fromJson(responseBody[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load ${i} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    param1 =
        '?salesId=${loginController.check.value.userData.name}&recapSppaStatus=3';

    print(baseUrl + '/RecapSppaHeader' + param1);
    url = Uri.parse(baseUrl + '/RecapSppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBodySppa = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBodySppa.length; i++) {
        listRecapHeader.add(RecapSppaHeader.fromJson(responseBody[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load ${i + 1} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    // get sppaStatus

    for (var j = 0; j < listRecapHeader.length; j++) {
      param1 = '?recapHeaderId=${listRecapHeader[j].id}';
      url = Uri.parse(baseUrl + '/RecapSppaStatus' + param1);

      response = await client.get(url);

      if (response.statusCode == 200) {
        var responseBodyStatus = jsonDecode(response.body);
        //print(responseBodyStatus);
        for (var k = 0; k < responseBodyStatus.length; k++) {
          listRecapStatus.add(RecapSppaStatus.fromJson(responseBodyStatus[k]));
          print(
              ' ${k + 1} Load status berhasil ${listRecapStatus[k].id} utk ${listRecapStatus[k].recapHeaderId} ');
        }
      } else {
        print('Load status error ${response.statusCode}');
      }
    }
  }

  void getAktifRecap() async {
    var responseBody;
    String param1 = '';
    Uri url;
    http.Response response;

    print(
        'userRole: ${loginController.check.value.roles} & userName: ${loginController.check.value.userData.name}');

    // Getting for status 1
    switch (loginController.check.value.roles) {
      case 'ADMIN':
        // status 1
        param1 =
            '?salesId=${loginController.check.value.userData.name}&recapSppaStatus=1';
        break;
      case 'Marketing':
        param1 =
            '?marketingId=${loginController.check.value.userData.name}&recapSppaStatus=1';
        break;
      case 'Broker':
        param1 =
            '?brokerId=${loginController.check.value.userData.name}&recapSppaStatus=1';
        break;
    }

    print(baseUrl + '/RecapSppaHeader' + param1);
    url = Uri.parse(baseUrl + '/RecapSppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBody.length; i++) {
        listRecapHeader.add(RecapSppaHeader.fromJson(responseBody[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load ${i + 1} recapSppa');
      }
    } else {
      print('load sppaRecap status 1 gagal ${response.statusCode}');
    }

    // status 3
    switch (loginController.check.value.roles) {
      case 'ADMIN':
        param1 =
            '?salesId=${loginController.check.value.userData.name}&recapSppaStatus=3';
        break;
      case 'Marketing':
        param1 =
            '?marketingId=${loginController.check.value.userData.name}&recapSppaStatus=3';
        break;
      case 'Broker':
        param1 =
            '?brokerId=${loginController.check.value.userData.name}&recapSppaStatus=3';
        break;
    }

    print(baseUrl + '/RecapSppaHeader' + param1);
    url = Uri.parse(baseUrl + '/RecapSppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBodySppa = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBodySppa.length; i++) {
        listRecapHeader.add(RecapSppaHeader.fromJson(responseBody[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load ${i} sppaRecap');
      }
    } else {
      print('load sppaRecap status 3 gagal ${response.statusCode}');
    }

    // get sppaRecapStatus for all

    for (var j = 0; j < listRecapHeader.length; j++) {
      param1 = '?recapHeaderId=${listRecapHeader[j].id}';
      url = Uri.parse(baseUrl + '/RecapSppaStatus' + param1);

      response = await client.get(url);

      if (response.statusCode == 200) {
        var responseBodyStatus = jsonDecode(response.body);
        //print(responseBodyStatus);
        print('Load status berhasil ');
        for (var k = 0; k < responseBodyStatus.length; k++) {
          listRecapStatus.add(RecapSppaStatus.fromJson(responseBodyStatus[k]));
        }
      } else {
        print('Load status error ${response.statusCode}');
      }
    }
  }
}
