import 'dart:async';
//import '../model/check_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../model/user_data.dart';
import 'login_controller.dart';

class SessionController extends FullLifeCycleController
    with FullLifeCycleMixin {
  LoginController _loginController = Get.find();

  late Timer _timer;
  late final prefs;

  @override
  void onInit() {
    initializeThings();
    print(">>> SessionController is initializing");
    super.onInit();
  }

  void initializeThings() async {
    prefs = await SharedPreferences.getInstance();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      //print("fire periodically");
      _checkTimeOut();
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    print(">>> SessionController is closing");
    super.onClose();
  }

  @override
  void onDetached() {
    print(">>> SessionController onDetach");
  }

  @override
  void onInactive() {
    print(">>> SessionController onInActive");
  }

  @override
  void onPaused() {
    print(">>> SessionController onPause");
  }

  @override
  void onResumed() {
    print(">>> SessionController onResume");
  }

  void registerActivity() async {
    int millis = _timeMillisNow();
    try {
      await prefs.setInt('time', millis);
    } catch (e) {
      initPrefs().then((value) => {prefs.setInt('time', millis)});
    }
  }

  void _checkTimeOut() {
    int? lastActivityTime = prefs.getInt('time');
    int millisNow = _timeMillisNow();
    if (lastActivityTime == null) {
      lastActivityTime = millisNow;
    }
    int delta = millisNow - lastActivityTime;
    if (delta > 30 * 60 * 1000) {
      if (_loginController.login.value.isTrue) {
        _loginController.logout();
      }
      print("session expired");
    } else {
      //print("delta : $delta");
    }
  }

  int _timeMillisNow() {
    DateTime dateTime = DateTime.now();
    return dateTime.millisecondsSinceEpoch;
  }

  Future<SharedPreferences> initPrefs() {
    return SharedPreferences.getInstance();
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}
