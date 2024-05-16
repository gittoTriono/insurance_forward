import "dart:convert";
import "package:get/get.dart";
import "package:insurance/bloc/customer_controller.dart";
import "package:insurance/bloc/login_controller.dart";
import "package:insurance/bloc/polis_controller.dart";
import "package:insurance/bloc/session_controller.dart";
import "package:insurance/bloc/sppa_controller.dart";
//import "package:insurance/bloc/sppa_recap_controller.dart";
import "package:insurance/bloc/theme_controller.dart";
import "package:insurance/model/info_jastan.dart";
import "package:insurance/model/polis.dart";
import "package:insurance/model/sppa_header.dart";
import "package:insurance/model/sppa_recap.dart";
import "package:insurance/model/ternak_sapi.dart";
import "package:insurance/util/constants.dart";
import 'package:http/http.dart' as http;
//import "/model/products.dart";
//import "/util/constants.dart" as constant;

class DashboardController extends GetxController {
  RxList<SppaHeader> listAktifSppa = <SppaHeader>[].obs;
  RxList<Polis> listAktifPolis = <Polis>[].obs;

  // RxList<SppaStatus> listAktifSppaStatus = <SppaStatus>[].obs;
  // RxList<TernakSapi> listAktifSppaTernak = <TernakSapi>[].obs;
  // RxList<InfoAtsJasTan> listAktifSppaInfo = <InfoAtsJasTan>[].obs;

  RxList<RecapSppaDetail> listRecapDetail = <RecapSppaDetail>[].obs;
  RxList<RecapSppaHeader> listRecapHeader = <RecapSppaHeader>[].obs;
  RxList<RecapSppaStatus> listRecapStatus = <RecapSppaStatus>[].obs;

  LoginController loginController = Get.find();
  SessionController sessionController = Get.find();
  ThemeController themeController = Get.find();

  SppaHeaderController sppaController = Get.put(SppaHeaderController());
  CustomerController custController = Get.put(CustomerController());
//  RecapSppaController recapController = Get.put(RecapSppaController());
  PolisController polisController = Get.put(PolisController());

  // Sppa Status
  final List<int> custTodo = [1, 3];
  final List<int> custSubmit = [2, 4, 6, 8];
  final List<int> salesTodo = [2, 5];
  final List<int> salesSubmit = [4, 6, 8];
  final List<int> marketingTodo = [4, 7];
  final List<int> marketingSubmit = [6, 8];
  final List<int> brokerTodo = [6, 9];
  final List<int> brokerSubmit = [8];

  final List<int> custPolisTodo = [];
  final List<int> custPolisSubmit = [];
  final List<int> custPolisAktif = [2, 3, 4, 5];
  final List<int> salesPolisTodo = [];
  final List<int> salesPolisSubmit = [];
  final List<int> salesPolisAktif = [2, 3, 4, 5];
  final List<int> marketingPolisTodo = [2, 4];
  final List<int> marketingPolisSubmit = [3];
  final List<int> marketingPolisAktif = [5];
  final List<int> brokerPolisTodo = [1, 3];
  final List<int> brokerPolisSubmit = [2, 4];
  final List<int> brokerPolisAktif = [5];

  // RecapSppa Status
  final List<int> salesRecapTodo = [1, 3];
  final List<int> salesRecapSubmit = [2, 4, 6];
  final List<int> marketingRecapTodo = [2, 5];
  final List<int> marketingRecapSubmit = [4, 6, 7];
  // final List<int> brokerRecapTodo = [4];   sementara skip marketing
  // final List<int> brokerRecapSubmit = [6, 7]; sementara skip marketing
  final List<int> brokerRecapTodo = [2, 5];
  final List<int> brokerRecapSubmit = [4, 6, 7];

  var client = http.Client();

  void onInit() {
    super.onInit();
    print(
        'dashboardController on init ${loginController.check.value.roles} - ${loginController.check.value.userData.userId}');
    sessionController.registerActivity();
    if (loginController.check.value.roles.contains("ROLE_SALES")) {
      getAktifSppaSales();
      getAktifPolisSales();
    } else if (loginController.check.value.roles.contains("ROLE_MARKETING")) {
      getAktifSppaMarketing();
      getAktifPolisMarketing();
    } else if (loginController.check.value.roles.contains("ROLE_BROKER")) {
      getAktifSppaBroker();
      getAktifPolisBroker();
    } else {
      getAktifSppaCustomer();
      getAktifPolisCustomer();
    }
  }

  void getAktifSppaSales() async {
    //print('userRole: $userRole & userName: $userName');
    // get for status 2 and 4
    // 2 4 5 6 8
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

    // 4
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

    // 5
    param1 =
        '?salesId=${loginController.check.value.userData.name}&statusSppa=5';

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

    // 6
    param1 =
        '?salesId=${loginController.check.value.userData.name}&statusSppa=6';

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

    // 8
    param1 =
        '?salesId=${loginController.check.value.userData.name}&statusSppa=8';

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
  }

  void getAktifSppaMarketing() async {
    //print('userRole: $userRole & userName: $userName');
    // 4
    // final List<int> marketingTodo = [4, 7];
    // final List<int> marketingSubmit = [6, 8];

    // 4
    var param1 =
        '?marketingId=${loginController.check.value.userData.name}&statusSppa=4';

    print(baseUrl + '/SppaHeader' + param1);
    var url = Uri.parse(baseUrl + '/SppaHeader' + param1);

    http.Response response = await client.get(url); // no authentication needed
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

    // 6
    param1 =
        '?marketingId=${loginController.check.value.userData.name}&statusSppa=6';

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

    // 7
    param1 =
        '?marketingId=${loginController.check.value.userData.name}&statusSppa=7';

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

    // 8
    param1 =
        '?marketingId=${loginController.check.value.userData.name}&statusSppa=8';

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

    // sppaStatus tidak diambil
  }

  void getAktifSppaBroker() async {
    //print('userRole: $userRole & userName: $userName');
    // final List<int> brokerTodo = [6, 9];
    // final List<int> brokerSubmit = [8];

    // 6
    var param1 = '?brokerId=ISTPRO&statusSppa=6';

    print(baseUrl + '/SppaHeader' + param1);
    var url = Uri.parse(baseUrl + '/SppaHeader' + param1);

    http.Response response = await client.get(url); // no authentication needed
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

    // 8
    param1 = '?brokerId=ISTPRO&statusSppa=8';

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

    // 9
    param1 = '?brokerId=ISTPRO&statusSppa=9';

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

    // 10
    param1 = '?brokerId=ISTPRO&statusSppa=10';

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

    // sppaStatus tidak diambil
  }

  void getAktifSppaCustomer() async {
    // must get 2 times: status 1 and status 3 = maybe more later
    //     final List<int> custTodo = [1, 3];
    // final List<int> custSubmit = [2, 4, 6, 8];

    final userRole = loginController.check.value.roles;
    final userName = loginController.check.value.userData.name;

    // print('userRole: $userRole & userName: $userName');
    // 1
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
    // 3
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
    // 2
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
    // 4
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
    // for (var i = 0; i < listAktifSppa.length; i++) {
    //   // get sppaStatus for all in list
    //   param1 = '?sppaId=${listAktifSppa[i].id}';
    //   url = Uri.parse(baseUrl + '/SppaStatus' + param1);

    // 6
    param1 = '?customerId=${userName}&statusSppa=6';

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

    // 8
    param1 = '?customerId=${userName}&statusSppa=8';

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
  }

  void getAktifRecapSales() async {
    //print('userRole: $userRole & userName: $userName');

    // ROLE_ADMIN or ROLE_SALES get for status 1,2, 3 and 9
    // userData.name to be changed to the sales entity id (saspri kawasan ID)
    var responseBody;
    var param1;
    var url;

    http.Response response;

    // 1
    param1 =
        '?salesId=${loginController.check.value.userData.name}&recapSppaStatus=1';

    print(baseUrl + '/RecapSppaHeader' + param1);
    url = Uri.parse(baseUrl + '/RecapSppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBody.length; i++) {
        listRecapHeader.add(RecapSppaHeader.fromJson(responseBody[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load status 1 ${i} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    // 2
    param1 =
        '?salesId=${loginController.check.value.userData.name}&recapSppaStatus=2';

    print(baseUrl + '/RecapSppaHeader' + param1);
    url = Uri.parse(baseUrl + '/RecapSppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      //print(responseBody);
      for (var i = 0; i < responseBody.length; i++) {
        listRecapHeader.add(RecapSppaHeader.fromJson(responseBody[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load status 2 ${i + 1} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    // 3
    param1 =
        '?salesId=${loginController.check.value.userData.name}&recapSppaStatus=3';

    print(baseUrl + '/RecapSppaHeader' + param1);
    url = Uri.parse(baseUrl + '/RecapSppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBody.length; i++) {
        listRecapHeader.add(RecapSppaHeader.fromJson(responseBody[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load status 3 ${i + 1} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    // 9 belakangan

    // get RecapSppaStatus
    // untuk dashboard tidak usah! nantinya....
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

  void getAktifRecapMarketing() async {
    // ROLE_MARKETING get for status 2, 4 ,5 and 9
    // userData.name to be changed to the sales entity id (saspri kawasan ID)

    var responseBody;
    var param1;
    var url;

    http.Response response;

    // 2
    param1 =
        '?marketingId=${loginController.check.value.userData.name}&recapSppaStatus=2';

    print(baseUrl + '/RecapSppaHeader' + param1);
    url = Uri.parse(baseUrl + '/RecapSppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBody.length; i++) {
        listRecapHeader.add(RecapSppaHeader.fromJson(responseBody[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load status 2 ${i + 1} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    // 4
    param1 =
        '?marketingId=${loginController.check.value.userData.name}&recapSppaStatus=4';

    print(baseUrl + '/RecapSppaHeader' + param1);
    url = Uri.parse(baseUrl + '/RecapSppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBody.length; i++) {
        listRecapHeader.add(RecapSppaHeader.fromJson(responseBody[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load status 4 ${i + 1} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    // 5
    param1 =
        '?marketingId=${loginController.check.value.userData.name}&recapSppaStatus=5';

    print(baseUrl + '/RecapSppaHeader' + param1);
    url = Uri.parse(baseUrl + '/RecapSppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBody.length; i++) {
        listRecapHeader.add(RecapSppaHeader.fromJson(responseBody[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load status 5 ${i + 1} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    // get RecapSppaStatus
    // untuk dashboard tidak usah! nantinya....
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

  void getAktifRecapBroker() async {
    // ROLE_BROKER get for status and 4, 6, 9
    // userData.name to be changed to the sales entity id (saspri kawasan ID)

    var responseBody;
    var param1;
    var url;

    http.Response response;

    // 4
    param1 =
        '?brokerId=${loginController.check.value.userData.name}&recapSppaStatus=4';

    print(baseUrl + '/RecapSppaHeader' + param1);
    url = Uri.parse(baseUrl + '/RecapSppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBody.length; i++) {
        listRecapHeader.add(RecapSppaHeader.fromJson(responseBody[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load status 4 ${i + 1} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    // 6
    param1 =
        '?brokerId=${loginController.check.value.userData.name}&recapSppaStatus=6';

    print(baseUrl + '/RecapSppaHeader' + param1);
    url = Uri.parse(baseUrl + '/RecapSppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBody.length; i++) {
        listRecapHeader.add(RecapSppaHeader.fromJson(responseBody[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load status 6 ${i + 1} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    // 9
    param1 =
        '?brokerId=${loginController.check.value.userData.name}&recapSppaStatus=9';

    print(baseUrl + '/RecapSppaHeader' + param1);
    url = Uri.parse(baseUrl + '/RecapSppaHeader' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      //print(responseBodySppa);
      for (var i = 0; i < responseBody.length; i++) {
        listRecapHeader.add(RecapSppaHeader.fromJson(responseBody[i]));
        // print('add 1 sppa and details: ${listAktifSppa[i].id}');
        print('load status 9 ${i + 1} items');
      }
    } else {
      print(response.statusCode.toString());
    }

    // get RecapSppaStatus
    // untuk dashboard tidak usah! nantinya....
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
      case 'ROLE_ADMIN':
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

  void getAktifPolisCustomer() async {
    // print('userRole: $userRole & userName: $userName');
    final userName = loginController.check.value.userData.name;

//  status 2
    var param1 = '?customerId=${userName}&statusPolis=2';

    print(baseUrl + '/Polis' + param1);
    var url = Uri.parse(baseUrl + '/Polis' + param1);

    http.Response response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifPolis[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }

    // *********************************************************************
    // 3
    param1 = '?customerId=${userName}&statusPolis=3';

    print(baseUrl + '/Polis' + param1);
    url = Uri.parse(baseUrl + '/Polis' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifSppa[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }

    // 4
    param1 = '?customerId=${userName}&statusPolis=4';

    print(baseUrl + '/Polis' + param1);
    url = Uri.parse(baseUrl + '/Polis' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifSppa[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }
  }

  void getAktifPolisBroker() async {
    // print('userRole: $userRole & userName: $userName');
    final userName = loginController.check.value.userData.name;

    // status 1
    var param1 = '?brokerId=${userName}&statusPolis=1';

    print(baseUrl + '/Polis' + param1);
    var url = Uri.parse(baseUrl + '/Polis' + param1);

    http.Response response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBody||');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifPolis[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }

    // *********************************************************************
    // 2
    param1 = '?brokerId=${userName}&statusPolis=2';

    print(baseUrl + '/Polis' + param1);
    url = Uri.parse(baseUrl + '/Polis' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifPolis[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }

    // *********************************************************************
    // 3
    param1 = '?brokerId=${userName}&statusPolis=3';

    print(baseUrl + '/Polis' + param1);
    url = Uri.parse(baseUrl + '/Polis' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifPolis[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }

    // 4
    param1 = '?brokerId=${userName}&statusPolis=4';

    print(baseUrl + '/Polis' + param1);
    url = Uri.parse(baseUrl + '/Polis' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifPolis[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }

    // 5
    param1 = '?brokerId=${userName}&statusPolis=5';

    print(baseUrl + '/Polis' + param1);
    url = Uri.parse(baseUrl + '/Polis' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifPolis[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }
  }

  void getAktifPolisSales() async {
    // print('userRole: $userRole & userName: $userName');
    final userName = loginController.check.value.userData.name;

    // status 2
    var param1 = '?salesId=${userName}&statusPolis=2';

    print(baseUrl + '/Polis' + param1);
    var url = Uri.parse(baseUrl + '/Polis' + param1);

    http.Response response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifPolis[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }

    // *********************************************************************
    // 3
    param1 = '?salesId=${userName}&statusPolis=3';

    print(baseUrl + '/Polis' + param1);
    url = Uri.parse(baseUrl + '/Polis' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifPolis[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }

    // *********************************************************************
    // 4
    param1 = '?salesId=${userName}&statusPolis=4';

    print(baseUrl + '/Polis' + param1);
    url = Uri.parse(baseUrl + '/Polis' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifPolis[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }

    // 5
    param1 = '?salesId=${userName}&statusPolis=5';

    print(baseUrl + '/Polis' + param1);
    url = Uri.parse(baseUrl + '/Polis' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifPolis[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }
  }

  void getAktifPolisMarketing() async {
    // print('userRole: $userRole & userName: $userName');
    final userName = loginController.check.value.userData.name;

    // status 2
    var param1 = '?marketingId=${userName}&statusPolis=2';

    print(baseUrl + '/Polis' + param1);
    var url = Uri.parse(baseUrl + '/Polis' + param1);

    http.Response response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifPolis[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }

    // *********************************************************************
    // 3
    param1 = '?marketingId=${userName}&statusPolis=3';

    print(baseUrl + '/Polis' + param1);
    url = Uri.parse(baseUrl + '/Polis' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifPolis[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }

    // *********************************************************************
    // 4
    param1 = '?marketingId=${userName}&statusPolis=4';

    print(baseUrl + '/Polis' + param1);
    url = Uri.parse(baseUrl + '/Polis' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifPolis[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }

    // 5
    param1 = '?marketingId=${userName}&statusPolis=5';

    print(baseUrl + '/Polis' + param1);
    url = Uri.parse(baseUrl + '/Polis' + param1);

    response = await client.get(url); // no authentication needed

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      //print('response body :$responseBodySppa');
      for (var i = 0; i < responseBody.length; i++) {
        listAktifPolis.add(Polis.fromJson(responseBody[i]));
        print('${i + 1} polis : ${listAktifPolis[i].id}');
      }
    } else {
      print(' get Polis for $userName gagal ${response.statusCode}');
    }
  }
}
