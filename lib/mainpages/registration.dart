import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bloc/registration_controller.dart';
import '../bloc/theme_controller.dart';
import '../util/screen_size.dart';
import '../util/theme.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();

    return MaterialApp(
        title: 'Registration'.tr,
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
                  child: Text('Registration'.tr,
                      style: Get.theme.textTheme.titleLarge!.copyWith(
                        color: Get.theme.colorScheme.onPrimary,
                      ))),
            ),
            body: registrationPage(context, Get.width, Get.height),
          ),
        ));
  }
}

Widget registrationPage(BuildContext context, double _width, double _height) {
  final _formKey = GlobalKey<FormState>();

  String _pass1 = "";
  String _pass2 = "";
  bool _unameOk = false;
  bool _passOk = false;

  RegistrationController regController = Get.find();
  ThemeController themeController = Get.find();

  bool isNumeric(String s) {
    int? num = int.tryParse(s);
    if (num == null) {
      return false;
    } else {
      return true;
    }
  }

  return Center(
    child: Container(
      width: formWidth(_width),
      height: Get.height - kToolbarHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 24,
            ),
            SizedBox(
                width: 70,
                height: 70,
                child: Image.asset(
                    themeController.themeSetting.value == 'isLight'
                        ? "assets/images/logo_inv.png"
                        : "assets/images/logo.png")),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: formWidth(_width),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        regController.userData.value.userId = value;
                      },
                      onSaved: (value) {
                        regController.userData.value.userId = value!;
                      },
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
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
                        prefixIcon: Icon(Icons.email),
                        //icon: Icon(Icons.email),
                        label: Text('Email'),
                        //hintText: 'Email',
                        //helperText: 'contoh: nama@mailserver.com',
                        //counterText: '0 characters',
                        //border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        regController.userData.value.alias = value;
                      },
                      onSaved: (value) {
                        regController.userData.value.alias = value!;
                      },
                      validator: (value) {
                        if (isNumeric(value!) && value.length >= 10) {
                          return null;
                        } else {
                          return "Masukkan nomor HP yang benar";
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone_android_sharp),
                        // icon: Icon(Icons.phone_android_sharp),
                        label: Text('HP'),
                        //hintText: 'Nomor HP',
                        //helperText: 'Nomor HP anda',
                        //counterText: '0 characters',
                        //border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        regController.userData.value.name = value;
                      },
                      onSaved: (value) {
                        regController.userData.value.name = value!;
                      },
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          if (value.length > 3) {
                            return null;
                          } else {
                            return "Masukkan nama anda yang benar";
                          }
                        } else {
                          _unameOk = false;
                          return "Masukkan nama anda yang benar";
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        // icon: const Icon(Icons.person),
                        label: Text('Name'.tr),
                        // hintText: 'Nama',
                        // helperText: 'Nama anda',
                        //counterText: '0 characters',
                        //border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Obx(() {
                      return TextFormField(
                        onChanged: (value) {
                          _pass1 = value;
                        },
                        onSaved: (value) {
                          _pass1 = value!;
                        },
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (value.length >= 6) {
                              _passOk = true;
                              return null;
                            } else {
                              _passOk = false;
                              return "bukan password yang valid";
                            }
                          } else {
                            _passOk = false;
                            return "isi kata sandi";
                          }
                        },
                        keyboardType: TextInputType.text,
                        obscureText: regController.showButton1.value.isTrue
                            ? true
                            : false,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          // icon: const Icon(Icons.password),
                          label: Text('Password'.tr),
                          //hintText: 'Sandi',
                          //helperText: 'password/kode',
                          //counterText: '0 characters',
                          //border: const OutlineInputBorder(),
                          suffixIcon: Obx(() {
                            if (regController.showButton1.value.isTrue) {
                              return IconButton(
                                icon: Icon(Icons.visibility,
                                    color: Get.theme.colorScheme.secondary),
                                onPressed: () {
                                  regController.showButton1.value =
                                      RxBool(false);
                                },
                              );
                            } else {
                              return IconButton(
                                icon: Icon(Icons.visibility_off,
                                    color: Get.theme.colorScheme.secondary),
                                onPressed: () {
                                  regController.showButton1.value =
                                      RxBool(true);
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
                    Obx(() {
                      return TextFormField(
                        onChanged: (value) {
                          _pass2 = value;
                        },
                        onSaved: (value) {
                          _pass2 = value!;
                        },
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (value.length >= 6) {
                              _passOk = true;
                              return null;
                            } else {
                              _passOk = false;
                              return "bukan password yang valid";
                            }
                          } else {
                            _passOk = false;
                            return "isi kata sandi";
                          }
                        },
                        keyboardType: TextInputType.text,
                        obscureText: regController.showButton2.value.isTrue
                            ? true
                            : false,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          // icon: const Icon(Icons.password),
                          label: Text('Password'.tr),
                          //hintText: 'Sandi',
                          //helperText: 'password/kode',
                          //counterText: '0 characters',
                          //border: const OutlineInputBorder(),

                          suffixIcon: Obx(() {
                            if (regController.showButton2.value.isTrue) {
                              return IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.visibility,
                                    color: Get.theme.colorScheme.secondary),
                                onPressed: () {
                                  regController.showButton2.value =
                                      RxBool(false);
                                },
                              );
                            } else {
                              return IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.visibility_off,
                                    color: Get.theme.colorScheme.secondary),
                                onPressed: () {
                                  regController.showButton2.value =
                                      RxBool(true);
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                regController.views.value = "REG_ONGOING";
                                regController.userData.value.roles =
                                    "ROLE_USER";
                                regController.submitRegistration(
                                    regController.userData.value,
                                    _pass1,
                                    _pass2);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                "Registration".tr,
                                style: Get.theme.textTheme.bodyMedium!.copyWith(
                                  color: Get.theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
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
                              child: Text(
                                "back".tr,
                                style: Get.theme.textTheme.bodyMedium!.copyWith(
                                  color: Get.theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
