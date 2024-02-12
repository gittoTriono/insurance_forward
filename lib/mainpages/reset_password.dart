import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/reset_controller.dart';
import '../bloc/theme_controller.dart';
import '../util/screen_size.dart';
import '../util/theme.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {

    ThemeController themeController = Get.find();

    return MaterialApp(
      title: "Reset_password".tr,
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: themeController.themeSetting.value=='isLight'? ThemeMode.light: ThemeMode.dark,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Reset_password".tr)),
          ),
          body: resetPage(context, Get.width, Get.height),
        ),
      ),
    );
  }
}

Widget resetPage(BuildContext context, double width, double height){

  final _formKey = GlobalKey<FormState>();

  ResetController resetController = Get.put(ResetController());
  ThemeController themeController = Get.find();

  bool _unameOk = false;

  return SingleChildScrollView(
    child: Center(
      child: Container(
        width: formWidth(Get.width),
        height: Get.height - kToolbarHeight,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [

            const SizedBox(
              width: 0,
              height: 48,
            ),

            SizedBox(
                width: 70,
                height: 70,
                child: Image.asset(themeController.themeSetting.value=='isLight'?"assets/images/logo_inv.png":"assets/images/logo.png")),
            const SizedBox(
              height: 24,
            ),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (userId){
                      resetController.user.value.userId = userId;
                    },
                    onSaved: (userId){
                      resetController.user.value.userId = userId!;
                    },
                    validator: (value){
                      if(value!=null && value.isNotEmpty) {
                        if (value.contains("@") && value.contains(".")) {
                          _unameOk = true;
                          return null;
                        } else {
                          _unameOk = false;
                          return "bukan alamat email";
                        }
                      } else {
                        _unameOk = false;
                        return "Isi alamat email";
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      label: Text('Email'),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),

                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (){

                            if (_formKey.currentState!.validate()) {
                              if(_unameOk){
                                resetController.submitReset(resetController.user.value.userId);
                                resetController.views.value = 'RESET_ONGOING';
                              }
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.all(12),
                              child: Text('Reset'.tr, style: Get.theme.textTheme.labelLarge!.copyWith(
                                  color: Get.theme.colorScheme.onPrimary
                              ))),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    width: 0,
                    height: 33,
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: (){
                            Get.back();
                          },
                          child: Container(
                              padding: const EdgeInsets.all(12),
                              child: Text('back'.tr, style: Get.theme.textTheme.labelLarge!.copyWith(
                                  color: Get.theme.colorScheme.primary
                              ))),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],

        ),
      ),
    ),
  );
}
