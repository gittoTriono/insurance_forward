import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';


class FullScreenDialog {

  static void showDialog(String pos) {
    
    Get.dialog(
      PopScope(
        canPop: true,
        onPopInvoked: (didPop){
          //Future.value(false);
          print("pop invoked");
          print(didPop);
          return;
        },
        child: Column(
          mainAxisAlignment: pos=='start'?MainAxisAlignment.start:pos=='end'?MainAxisAlignment.end:MainAxisAlignment.center,
          children: [
            SpinKitFadingCircle(
              color: Get.theme.colorScheme.tertiary,
              size: 50,

            ),
          ],
        ),),
      barrierDismissible: false,
      barrierColor: Get.theme.focusColor,
      useSafeArea: true,
    );
    
  }

  static void cancelDialog() {
    Get.back();
  }

}