import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/mainpages/full_screen_dialog.dart';
import '../bloc/login_controller.dart';
import '../bloc/registration_controller.dart';
import '../bloc/reset_controller.dart';
import '../bloc/theme_controller.dart';
import '../util/screen_size.dart';
import '../util/theme.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();

    return MaterialApp(
      title: "Login".tr,
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: themeController.themeSetting.value == 'isLight'
          ? ThemeMode.light
          : ThemeMode.dark,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(
                child: Text(
              "Login".tr,
              style: Get.textTheme.titleLarge!.copyWith(
                color: Get.theme.colorScheme.onPrimary,
              ),
            )),
          ),
          body: Center(
            child: Container(
              width: formWidth(Get.width),
              height: Get.height - kToolbarHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    loginHeader(120, 120),
                    const SizedBox(
                      height: 42,
                    ),
                    SizedBox(
                        width: screenSizeIndex(Get.width) > 3
                            ? 0.5 * Get.width
                            : 0.9 * Get.width,
                        child: loginForm()),
                    const SizedBox(
                      height: 12,
                    ),
                    /*Text("v.0.1", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 8)),
                        SizedBox(height:12,),*/
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget loginHeader(double width, double height) {
  ThemeController themeController = Get.find();

  return SizedBox(
      width: width,
      height: height,
      child: Image.asset(themeController.themeSetting.value == 'isLight'
          ? "assets/images/logo_inv.png"
          : "assets/images/logo.png"));
}

Widget loginForm() {
  final formKey = GlobalKey<FormState>();

  LoginController loginController = Get.find();
  loginController.loginState.value = 0;

  String _uname = "";
  String _pass = "";

  return Form(
    key: formKey,
    child: Column(
      children: [
        TextFormField(
          controller: TextEditingController.fromValue(TextEditingValue(
              text: _uname,
              selection: TextSelection.collapsed(offset: _uname.length))),
          onChanged: (value) {
            _uname = value;
          },
          onSaved: (value) {
            _uname = value!;
          },
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              if (value.contains("@") && value.contains(".")) {
                return null;
              } else {
                return "bukan alamat email";
              }
            } else {
              return "Isi alamat email";
            }
          },
          enabled: loginController.loginState.value == 0 ? true : false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email),
            //icon: Icon(Icons.email),
            label: Text('Email'),
            // hintText: 'Email',
            // helperText: 'contoh: nama@mailserver.com',
            //counterText: '0 characters',
            //border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        Obx(() {
          return TextFormField(
            controller: TextEditingController.fromValue(TextEditingValue(
                text: _pass,
                selection: TextSelection.collapsed(offset: _pass.length))),
            onChanged: (value) {
              _pass = value;
            },
            onSaved: (value) {
              _pass = value!;
            },
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                if (value.length >= 6) {
                  return null;
                } else {
                  return "bukan password yang valid";
                }
              } else {
                return "isi kata sandi";
              }
            },
            enabled: loginController.loginState.value == 0 ? true : false,
            keyboardType: TextInputType.text,
            obscureText: loginController.showButton.value.isTrue ? true : false,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.password),
              //icon: const Icon(Icons.password),
              label: Text('Password'.tr),
              // hintText: 'Sandi',
              // helperText: 'password/kode',
              //counterText: '0 characters',
              //border: const OutlineInputBorder(),

              suffixIcon: Obx(() {
                if (loginController.showButton.value.isTrue) {
                  return IconButton(
                    icon: Icon(
                      Icons.visibility,
                      color: Get.theme.colorScheme.secondary,
                    ),
                    onPressed: () {
                      loginController.showButton.value = RxBool(false);
                    },
                  );
                } else {
                  return IconButton(
                    icon: Icon(
                      Icons.visibility_off,
                      color: Get.theme.colorScheme.secondary,
                    ),
                    onPressed: () {
                      loginController.showButton.value = RxBool(true);
                    },
                  );
                }
              }),
            ),
          );
        }),
        const SizedBox(
          height: 48,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: loginController.loginState.value == 0
                    ? () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          loginController.submitLogin(
                              _uname, _pass, "ROLE_USER");
                          // print("login");
                          FullScreenDialog.showDialog('center');
                          // Get.toNamed("/loader?title=Login");
                        } else {
                          return;
                        }
                      }
                    : null,
                child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Text('Login'.tr,
                        style: Get.theme.textTheme.bodyMedium!.copyWith(
                          color: Get.theme.colorScheme.onPrimary,
                        ))),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Text('back'.tr,
                        style: Get.theme.textTheme.bodyMedium!.copyWith(
                          color: Get.theme.colorScheme.primary,
                        ))),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 42,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Forgot_password?".tr,
              style: Get.theme.textTheme.bodySmall!.copyWith(
                color: Get.theme.colorScheme.onBackground,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed("/reset");
              },
              child: Text("Reset".tr,
                  style: Get.theme.textTheme.bodySmall!.copyWith(
                    color: Get.theme.colorScheme.secondary,
                  )),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Not_registered?".tr,
              style: Get.theme.textTheme.bodySmall!.copyWith(
                color: Get.theme.colorScheme.onBackground,
              ),
            ),
            TextButton(
                onPressed: () {
                  Get.toNamed("/registration");
                },
                child: Text("Register".tr,
                    style: Get.theme.textTheme.bodySmall!.copyWith(
                      color: Get.theme.colorScheme.secondary,
                    ))),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Change_password".tr,
              style: Get.theme.textTheme.bodySmall!.copyWith(
                color: Get.theme.colorScheme.onBackground,
              ),
            ),
            TextButton(
                onPressed: () {
                  Get.toNamed("/change/password");
                },
                child: Text("Change".tr,
                    style: Get.theme.textTheme.bodySmall!.copyWith(
                      color: Get.theme.colorScheme.secondary,
                    ))),
          ],
        ),
      ],
    ),
  );
}
