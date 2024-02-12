import 'dart:io';
import 'package:flutter/foundation.dart';

class Tools {




  String platformType(){

    if (kIsWeb) {
      return "web";
    } else {
      if (Platform.isAndroid) {
        return "android";
      } else if (Platform.isIOS) {
        return "ios";
      } else if (Platform.isLinux) {
        return "linux";
      } else if (Platform.isMacOS) {
        return "macos";
      } else if (Platform.isWindows) {
        return "window";
      } else {
        return "not known";
      }
    }

  }

}