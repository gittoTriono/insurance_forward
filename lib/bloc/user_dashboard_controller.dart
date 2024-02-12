import 'dart:convert';
import 'dart:io';

import '../model/credential.dart';
import 'login_controller.dart';
import '../model/check_password.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../util/constants.dart' as constant;

enum PageViewConst {DASHBOARD, TEACH_REG, TEACH_ONGOING, TEACH_SUCCESS, TEACH_FAIL, TECH_ERR}

class UserDashboardController extends GetxController{

  String _phDomain = constant.domain;

  LoginController _loginController = Get.find();

  String userid = '';
  String token = '';
  String roles = '';

  var pageView = PageViewConst.TEACH_REG.obs;
  var usersView = "".obs;
  var checkToc = RxBool(false).obs;
  var credential = Credential().obs;



  void submitPrincipalRegistration(Credential cred, String token, String userid) async {

    String json = jsonEncode(cred);

    Map<String, String> headers = {
      HttpHeaders.acceptHeader:"application/json",
      HttpHeaders.contentTypeHeader:"application/json",
      'token': token,
      'userid': userid
    };


    Map<String, String> params = {
      'role': 'ROLE_PRINCIPAL',
    };

    var uri = Uri.https(_phDomain, "/powerhost/credential/save/upgrade", params);


    try{

      pageView.value = PageViewConst.TEACH_ONGOING;

      http.Response response = await http.post(uri, headers: headers, body: json);

      print(response.body);

      if(response.statusCode == 200){

        CheckPassword check = CheckPassword.fromJson(jsonDecode(response.body));

        if (check.responseCode=="00"){
          CheckUser checkPassword2 = CheckUser.fromJson(jsonDecode(response.body));
          check.userData = checkPassword2.userData;
          _loginController.check.value = check;

          pageView.value = PageViewConst.TEACH_SUCCESS;

        } else {
          pageView.value = PageViewConst.TEACH_FAIL;
        }
      } else {
        pageView.value = PageViewConst.TEACH_FAIL;
      }
    } catch (e){
      pageView.value = PageViewConst.TECH_ERR;
    }
  }

}