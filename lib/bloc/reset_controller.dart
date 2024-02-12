import 'dart:convert';
import 'dart:io';
import '../model/user_data.dart';
import 'package:get/get.dart';
import '../util/constants.dart' as constants;
import 'package:http/http.dart' as http;

import 'login_controller.dart';

class ResetController extends GetxController{

  final LoginController _loginController = Get.find();

  final _ph = constants.ph;

  var user = SimpleUserModel().obs;
  var resetStatus = 0.obs;

  var views = "MAIN_PAGE".obs;

  void getBack(){
    views.value = "MAIN_PAGE";

  }



  void submitReset(String userId) async {
    UserModel auth = UserModel(userId: userId,);
    String json = jsonEncode(auth);
    var url = Uri.parse("$_ph/registration/simple/email/resetpwd");
    http.Response response = await http.post(url, body: json, headers: {HttpHeaders.contentTypeHeader: "application/json;charset=UTF-8"});

    //print("BLOC reset by email response : ${response.statusCode} and body is : ${response.body}");

    try {
      if(response.statusCode==200){
        user.value = SimpleUserModel.fromJson(jsonDecode(response.body));
        resetStatus.value = 1;
        views.value = "RESET_SUCCESS";
      } else {
        user.value = SimpleUserModel(userId: auth.userId, responseCode: "111",);
        resetStatus.value = 2;
        views.value = "RESET_FAIL";
      }
    } catch (e){
      views.value = "RESET_ERROR";
    }


  }

}