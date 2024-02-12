import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import '../model/change_password.dart';
import '../model/check_password.dart';
import '../model/content_data.dart';
import '../model/image_data.dart';
import '../model/user_data.dart';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import '../util/constants.dart' as constants;


class LoginController extends GetxController {

  final _ph = constants.ph;
  final _phDomain = constants.domain;

  var check = CheckPassword(userData: UserModel(), responseCode: "919").obs;
  var showButton = RxBool(true).obs;
  var showButton2 = RxBool(true).obs;
  var showButton3 = RxBool(true).obs;
  var login = RxBool(false).obs;
  var imageData = ImageData().obs;


  //======== InfoController =================================

  Map contentDataMap = <String, ContentData>{};
  Map<String, ImageSimple> imageMap = <String, ImageSimple>{};
  var dataLength = 0.obs;
  var imageLength = 0.obs;

  bool dataAvailable(String key){
    return dataLength.value>0 && contentDataMap.containsKey(key)?true:false;
  }

  bool imageAvailable(String key){
    return imageLength.value>0 && imageMap.containsKey(key)?true:false;
  }


  //=========================================================


  var loginState = 0.obs;  // value 2 is successful login

  void changeLanguage(var param1, var param2){
    var locale = Locale(param1, param2);
    Get.updateLocale(locale);
  }



  void submitLogin(String _uname, String _password, String roles) async {

    var passBytes = utf8.encode(_password);
    var passDigest = sha256.convert(passBytes);

    CheckPassword checkPass = CheckPassword(
        userId: _uname, pass: passDigest.toString(), roles: roles, userData: UserModel());

    var url = Uri.parse(_ph + "/aut/pass");
    String json = jsonEncode(checkPass);

    print(json);

    try {

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      http.Response response = await http.post(url, body: json,
          headers: requestHeaders);

      loginState.value = 1;

      print("response : ${response.body}");

      if (response.statusCode == 200) {
        check.value = CheckPassword.fromJson(jsonDecode(response.body));
        if (check.value.responseCode=="00"){
          CheckUser checkPassword2 = CheckUser.fromJson(jsonDecode(response.body));
          check.value.userData = checkPassword2.userData;
          login.value = RxBool(true);

          _getUserAvatar(_uname, check.value.token);
          loginState.value = 2;
          if(!check.value.userData.accountNonExpired){
            Get.offAllNamed("/");
          } else {

            Get.offAllNamed("/");
          }

        } else {
          check.value = CheckPassword.fromJson(jsonDecode(response.body));
          login.value = RxBool(false);
          loginState.value = 3;
          Get.offAllNamed("/");
        }
      } else {
        check.value = CheckPassword.fromJson(jsonDecode(response.body));
        login.value = RxBool(false);
        loginState.value = 4;

        Get.offAllNamed("/");

      }

    } catch (e){

      check.value=CheckPassword(responseCode: '05', responseMessage: 'error', userData: UserModel());
      login.value = RxBool(false);
      loginState.value = 5;

      Get.offAllNamed("/");


    }

  }

  void submitUserLogin(String _uname, String _password, String roles) async {

    var passBytes = utf8.encode(_password);
    var passDigest = sha256.convert(passBytes);

    CheckPassword checkPass = CheckPassword(
        userId: _uname, pass: passDigest.toString(), roles: roles, userData: UserModel());

    var url = Uri.parse(_ph + "/aut/pass");
    String json = jsonEncode(checkPass);

    //print(json);

    try {

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      http.Response response = await http.post(url, body: json,
          headers: requestHeaders);

      loginState.value = 1;

      //print("response : ${response.body}");

      if (response.statusCode == 200) {
        check.value = CheckPassword.fromJson(jsonDecode(response.body));
        if (check.value.responseCode=="00"){
          CheckUser checkPassword2 = CheckUser.fromJson(jsonDecode(response.body));
          check.value.userData = checkPassword2.userData;
          login.value = RxBool(true);

          _getUserAvatar(_uname, check.value.token);
          loginState.value = 2;

        } else {
          check.value = CheckPassword.fromJson(jsonDecode(response.body));
          login.value = RxBool(false);
          loginState.value = 3;
        }
      } else {
        check.value = CheckPassword.fromJson(jsonDecode(response.body));
        login.value = RxBool(false);
        loginState.value = 4;
      }

    } catch (e){

      check.value=CheckPassword(responseCode: '05', responseMessage: 'error', userData: UserModel());
      login.value = RxBool(false);
      loginState.value = 5;


    }

  }

  void logout(){
    check.value = CheckPassword(userData: UserModel(), responseCode: "919");
    login.value = RxBool(false);

    loginState.value = 0;
    Get.offAllNamed("/");
  }

  void _getUserAvatar(String userId, String token) async{

    imageData.value.available=false;

    Map<String, String> params = {
      'userid': userId,
      'token': token,
      'id': "useravatar_$userId",
    };

    Map<String, String> headers = {HttpHeaders.acceptHeader:"application/json",
      HttpHeaders.contentTypeHeader:"application/json"};

    var uri = Uri.https(_phDomain, "/img/get", params);

    try {

      http.Response response = await http.get(uri, headers: headers, );

      //print("avatar response : ${response.body}");

      if (response.statusCode == 200) {
        imageData.value = ImageData.fromJson(jsonDecode(response.body));
        var imageArray = imageData.value.content.split(",");
        imageData.value.content = imageArray[1];
        imageData.value.img = base64Decode(imageData.value.content);
        imageData.value.available=true;
        //print("at login : ${imageData.value.available}");
      } else {
        imageData.value = ImageData(name:"NA", content: response.statusCode.toString() + " : " + response.body);
      }
    } catch(e){
      imageData.value = ImageData(name:"NA", content: e.toString());
      //print("error : ${e.toString()}");
    }

  }

  // Change password

  void submitChangePassword(String _pass, String _newPass) async{



    var passBytes = utf8.encode(_pass);
    var passDigest = sha256.convert(passBytes);

    var newPassBytes = utf8.encode(_newPass);
    var newPassDigest = sha256.convert(newPassBytes);

    ChangePassword changePassword = ChangePassword(userId: check.value.userId, token: check.value.token, oldPass: passDigest.toString(), newPass: newPassDigest.toString());

    var url = Uri.parse(_ph + "/userset/change/pass");
    String json = jsonEncode(changePassword);

    print("submitChangePassowrd Json $json");

    try {



      http.Response response = await http.post(url, body: json, headers: {HttpHeaders.contentTypeHeader: "application/json"});

      print("submitChangePassword response status : ${response.statusCode.toString()} body ${response.body}");

      if (response.statusCode == 200) {
        ChangePassword changeResponse = ChangePassword.fromJson(jsonDecode(response.body));
        if (changeResponse.responseCode=='00'){


          logout();

        } else {


        }

      } else {


      }

    } catch (e){


    }

  }


}