import 'package:get/get.dart';

class ThemeController extends GetxController{

  var themeSetting = "isLight".obs;

  void setTheme(String setting) {
    themeSetting.value = setting;
  }


}