import 'dart:convert';
import 'dart:io';

import '../model/page_user.dart';
import '../model/user_data.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../util/constants.dart' as constant;
import 'login_controller.dart';
import 'session_controller.dart';

class AdminDashboardController extends GetxController{

  LoginController _loginController = Get.find();
  SessionController _sessionController = Get.find();


  String _phDomain = constant.domain;

  var checkToc = RxBool(false).obs;
  var pageView = "DASHBOARD".obs;
  var usersView = "".obs;
  var credential = UserModel().obs;
  var pageUser = PageUser(content: []).obs;
  var message = "".obs;
  var userid = "".obs;
  var token = "".obs;
  String _userType="";
  int _page = 0;
  int _size = 20;
  String _sortField = "";

  void getBack(){
    pageView.value = "DASHBOARD";
  }

  void credentialForm(){
    pageView.value = "CREDENTIAL";
  }

  void submitUserRegistration(UserModel cred, String token, String userid) async {

    String json = jsonEncode(cred);

    Map<String, String> headers = {
      HttpHeaders.acceptHeader:"application/json",
      HttpHeaders.contentTypeHeader:"application/json",
      'token': token,
      'userid': userid
    };

    var uri = Uri.https(_phDomain, "/powerhost/registration/user");


    try{
      http.Response response = await http.post(uri, headers: headers, body: json);

      //print(response.body);

      if(response.statusCode == 200){
          if (response.body=="00"){
            pageView.value = "CREDENTIAL_SUCCESS";
          } else {
            pageView.value = "CREDENTIAL_FAIL";
          }
      } else {
        pageView.value = "CREDENTIAL_FAIL";
      }
    } catch (e){
      pageView.value = "CREDENTIAL_ERROR";
    }
  }

  void getUser(String userid, String token, String userType, int page, int size, String sortField) async {

    _userType = userType;
    _page = page;
    _size = size;
    _sortField = sortField;

    Map<String, String> headers = {
      HttpHeaders.acceptHeader:"application/json",
      HttpHeaders.contentTypeHeader:"application/json",
      'token': token,
      'userid': userid
    };

    Map<String, String> params = {
      'usertypes': userType,
      'page': page.toString(),
      'size': size.toString(),
      'sort': sortField,
      '${sortField}.dir': 'asc',
    };

    //print(params);

    var uri = Uri.https(_phDomain, "/powerhost/registration/page/usertypes", params);

    try {

      http.Response response = await http.get(uri, headers: headers);

      //print(response.body);

      if (response.statusCode == 200) {

        pageUser.value = PageUser.fromJson(jsonDecode(response.body));

        if(pageUser.value.numberOfElements!=999999){
          usersView.value = "USERS_VIEW_SUCCESS";
        } else {
          usersView.value = "USERS_VIEW_FAIL";
          message.value = response.statusCode.toString();
        }

      } else {
        usersView.value = "USERS_VIEW_FAIL";
        message.value = response.statusCode.toString();
      }

    } catch(e){
      usersView.value = "USERS_VIEW_ERROR";
      message.value = e.toString();
      //print(message.value);
    }

  }


  void resetUserPassword(String userIdToReset) async {

    _sessionController.registerActivity();

    Map<String, String> headers = {
      HttpHeaders.acceptHeader:"application/json",
      HttpHeaders.contentTypeHeader:"application/json",
      'token': _loginController.check.value.token,
      'userid': _loginController.check.value.userId
    };

    Map<String, String> params = {
      'userToReset': userIdToReset,
      'pass': 'NA'
    };

    print(headers);

    var uri = Uri.https(_phDomain, "/powerhost/credential/reset/pass", params);

    try {

      http.Response response = await http.get(uri, headers: headers);

      print(response.body);

      if (response.statusCode == 200) {
        if(response.body=='00') {
          getUser(_loginController.check.value.userId,
              _loginController.check.value.token, _userType, _page, _size,
              _sortField);
        }
      }

    } catch (e) {

    }

  }


}