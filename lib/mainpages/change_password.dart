import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/login_controller.dart';
import '../bloc/theme_controller.dart';
import '../util/screen_size.dart';
import '../util/theme.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {

    ThemeController themeController = Get.find();

    return MaterialApp(
      title: "Change_password".tr,
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: themeController.themeSetting.value=='isLight'? ThemeMode.light: ThemeMode.dark,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Change_password".tr)),

          ),
          body: changePassPage(context, Get.width, Get.height),
        ),
      ),

    );
  }
}

Widget changePassPage(BuildContext context, double _width, double _height){

  final _formKey = GlobalKey<FormState>();

  LoginController _loginController = Get.find();
  ThemeController themeController = Get.find();

  String _pass = "";
  String _pass2 = "";
  String _pass3 = "";


  return SingleChildScrollView(
    child: Center(
      child: Container(
        width: formWidth(Get.width),
        height: Get.height,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 24,
            ),
            SizedBox(
                width: 70,
                height: 70,
                child: Image.asset(themeController.themeSetting.value=='isLight'?"assets/images/logo_inv.png":"assets/images/logo.png")),
            const SizedBox(
              height: 33,
            ),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Obx((){
                    return TextFormField(
                      onChanged: (value){
                        _pass = value;
                      },
                      onSaved: (value){
                        _pass = value!;
                      },
                      validator: (value){
                        if(value!=null && value.isNotEmpty) {
                          if (value.length >= 6) {
                            return null;
                          } else {
                            return "bukan password yang valid";
                          }
                        } else {
                          return "isi kata sandi";
                        }
                      },
                      keyboardType: TextInputType.text,
                      obscureText: _loginController.showButton.value.isTrue?true:false,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.password),
                        label: Text('Password'.tr),

                        suffixIcon: Obx((){
                          if (_loginController.showButton.value.isTrue){
                            return IconButton(
                              icon: Icon(Icons.visibility, color: Get.theme.colorScheme.secondary,),
                              onPressed: (){
                                _loginController.showButton.value = RxBool(false);
                              },
                            );
                          } else {
                            return IconButton(
                              icon: Icon(Icons.visibility_off, color: Get.theme.colorScheme.secondary,),
                              onPressed: (){
                                _loginController.showButton.value = RxBool(true);
                              },
                            );
                          }

                        }),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 18,
                  ),

                  Obx((){
                    return TextFormField(
                      onChanged: (value){
                        _pass2 = value;
                      },
                      onSaved: (value){
                        _pass2 = value!;
                      },
                      validator: (value){
                        if(value!=null && value.isNotEmpty) {
                          if (value.length >= 6) {
                            return null;
                          } else {
                            return "bukan password yang valid";
                          }
                        } else {
                          return "isi kata sandi";
                        }
                      },
                      keyboardType: TextInputType.text,
                      obscureText: _loginController.showButton2.value.isTrue?true:false,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.password),
                        label: Text('New_Password'.tr),

                        suffixIcon: Obx((){
                          if (_loginController.showButton2.value.isTrue){
                            return IconButton(
                              icon: Icon(Icons.visibility, color: Get.theme.colorScheme.secondary,),
                              onPressed: (){
                                _loginController.showButton2.value = RxBool(false);
                              },
                            );
                          } else {
                            return IconButton(
                              icon: Icon(Icons.visibility_off, color: Get.theme.colorScheme.secondary,),
                              onPressed: (){
                                _loginController.showButton2.value = RxBool(true);
                              },
                            );
                          }

                        }),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 18,
                  ),

                  Obx((){
                    return TextFormField(
                      onChanged: (value){
                        _pass3 = value;
                      },
                      onSaved: (value){
                        _pass3 = value!;
                      },
                      validator: (value){
                        if(value!=null && value.isNotEmpty) {

                          if (value.length == _pass2.length) {
                            if(_pass2 == _pass3){
                              return null;
                            } else {
                              return "sandi tidak sama";
                            }
                          } else {
                            return "bukan password yang valid";
                          }
                        } else {
                          return "isi kata sandi";
                        }
                      },
                      keyboardType: TextInputType.text,
                      obscureText: _loginController.showButton3.value.isTrue?true:false,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.password),
                        label: Text('New_Password'.tr),

                        suffixIcon: Obx((){
                          if (_loginController.showButton3.value.isTrue){
                            return IconButton(
                              icon: Icon(Icons.visibility, color: Get.theme.colorScheme.secondary,),
                              onPressed: (){
                                _loginController.showButton3.value = RxBool(false);
                              },
                            );
                          } else {
                            return IconButton(
                              icon: Icon(Icons.visibility_off, color: Get.theme.colorScheme.secondary,),
                              onPressed: (){
                                _loginController.showButton3.value = RxBool(true);
                              },
                            );
                          }

                        }),
                      ),
                    );
                  }),
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

                              _loginController.submitChangePassword(_pass, _pass2);
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.all(12),
                              child: Text('Change_password'.tr, style: Get.textTheme.labelLarge!.copyWith(
                                color: Get.theme.colorScheme.onPrimary
                              ),)),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 0, height: 33,),

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
                              child: Text('back'.tr, style: Get.textTheme.labelLarge!.copyWith(
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