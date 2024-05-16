import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/customer_controller.dart';
import 'package:insurance/bloc/login_controller.dart';
import 'package:insurance/bloc/registration_controller.dart';
import 'package:insurance/bloc/theme_controller.dart';
import 'package:insurance/mainpages/profile/profile_alamat_rumah.dart';
import 'package:insurance/mainpages/profile/profile_identitas.dart';
import 'package:insurance/mainpages/profile/profile_perbankan.dart';
import 'package:insurance/mainpages/profile/profile_peternak.dart';
import 'package:insurance/util/screen_size.dart';

class ProfileCustomer extends StatelessWidget {
  ProfileCustomer({super.key});

  CustomerController custController = Get.put(CustomerController());
  RegistrationController regController = Get.find();
  ThemeController themeController = Get.find();
  LoginController loginController = Get.find();

  bool _passOk = false;
  String _pass2 = '';

  bool isNumeric(String s) {
    int? num = int.tryParse(s);
    if (num == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    custController.initPageData();
    custController.getKandangSapi();
    //

    return Scaffold(
        appBar: AppBar(title: Text('Profile Customer')),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
              width: formWidth(Get.width),
              child: Form(
                  key: custController.CustomerFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Obx(() {
                        if (custController.custIsLoaded.value) {
                          print('cust variable is ditributed ');

                          custController.emailCtrl.text =
                              custController.theCustomer.value.email!;
                          custController.noHpCtrl.text =
                              custController.theCustomer.value.noHp!;
                          custController.namaCtrl.text =
                              custController.theCustomer.value.name!;

                          custController.pekerjaanCtrl.text =
                              custController.theCustomer.value.pekerjaan!;
                          custController.initPekerjaan =
                              custController.pekerjaanCtrl.text;

                          return Text('Login Data',
                              style: Get.theme.textTheme.titleMedium!.copyWith(
                                  color: Get.theme.colorScheme.secondary));
                        } else {
                          return Container();
                        }
                      }),
                      const SizedBox(height: 18),
                      Obx(
                        () => custController.custIsLoaded.value
                            ? TextFormField(
                                controller: custController.emailCtrl,
                                enabled: false,
                                onChanged: (value) {
                                  custController.theCustomer.value.email =
                                      value;
                                },
                                onSaved: (value) {
                                  custController.theCustomer.value.email =
                                      value!;
                                },
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.contains("@") &&
                                        value.contains(".")) {
                                      return null;
                                    } else {
                                      return "bukan alamat email";
                                    }
                                  } else {
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
                              )
                            : Container(),
                      ),
                      const SizedBox(height: 18),
                      Obx(() => custController.custIsLoaded.value
                          ? TextFormField(
                              controller: custController.noHpCtrl,
                              enabled: false,
                              onChanged: (value) {
                                custController.theCustomer.value.noHp = value;
                              },
                              onSaved: (value) {
                                custController.theCustomer.value.noHp = value!;
                              },
                              validator: (value) {
                                if (isNumeric(value!) && value.length >= 10) {
                                  return null;
                                } else {
                                  return "Masukkan nomor HP yang sesuai";
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
                            )
                          : Container()),
                      const SizedBox(height: 18),
                      Obx(
                        () => custController.custIsLoaded.value
                            ? TextFormField(
                                controller: custController.namaCtrl,
                                onChanged: (value) {
//                        regController.userData.value.name = value;
                                },
                                onSaved: (value) {
//                        regController.userData.value.name = value!;
                                  custController.theCustomer.value.name = value;
                                },
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.length > 3) {
                                      custController.theCustomer.value.name =
                                          value;

                                      return null;
                                    } else {
                                      return "Masukkan nama lengkap anda";
                                    }
                                  } else {
                                    return "Masukkan nama lengkap anda";
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  // icon: const Icon(Icons.person),
                                  label: Text('Nama Lengkap'.tr),
                                  // hintText: 'Nama',
                                  // helperText: 'Nama anda',
                                  //counterText: '0 characters',
                                  //border: OutlineInputBorder(),
                                ),
                              )
                            : Container(),
                      ),
                      // const SizedBox(height: 18),
                      // Obx(() {
                      //   return TextFormField(
                      //     onChanged: (value) {},
                      //     onSaved: (value) {},
                      //     validator: (value) {
                      //       if (value != null && value.isNotEmpty) {
                      //         if (value.length >= 6) {
                      //           _passOk = true;
                      //           return null;
                      //         } else {
                      //           _passOk = false;
                      //           return "bukan password yang valid";
                      //         }
                      //       } else {
                      //         _passOk = false;
                      //         return "isi kata sandi";
                      //       }
                      //     },
                      //     keyboardType: TextInputType.text,
                      //     obscureText: regController.showButton1.value.isTrue
                      //         ? true
                      //         : false,
                      //     decoration: InputDecoration(
                      //       prefixIcon: const Icon(Icons.password),
                      //       // icon: const Icon(Icons.password),
                      //       label: Text('Password'.tr),
                      //       //hintText: 'Sandi',
                      //       //helperText: 'password/kode',
                      //       //counterText: '0 characters',
                      //       //border: const OutlineInputBorder(),
                      //       suffixIcon: Obx(() {
                      //         if (regController.showButton1.value.isTrue) {
                      //           return IconButton(
                      //             icon: Icon(Icons.visibility,
                      //                 color: Get.theme.colorScheme.secondary),
                      //             onPressed: () {
                      //               regController.showButton1.value =
                      //                   RxBool(false);
                      //             },
                      //           );
                      //         } else {
                      //           return IconButton(
                      //             icon: Icon(Icons.visibility_off,
                      //                 color: Get.theme.colorScheme.secondary),
                      //             onPressed: () {
                      //               regController.showButton1.value =
                      //                   RxBool(true);
                      //             },
                      //           );
                      //         }
                      //       }),
                      //     ),
                      //   );
                      // }),
                      // const SizedBox(height: 18),
                      // Obx(() {
                      //   return TextFormField(
                      //     onChanged: (value) {
                      //       _pass2 = value;
                      //     },
                      //     onSaved: (value) {
                      //       _pass2 = value!;
                      //     },
                      //     validator: (value) {
                      //       if (value != null && value.isNotEmpty) {
                      //         if (value.length >= 6) {
                      //           _passOk = true;
                      //           return null;
                      //         } else {
                      //           _passOk = false;
                      //           return "bukan password yang valid";
                      //         }
                      //       } else {
                      //         _passOk = false;
                      //         return "isi kata sandi";
                      //       }
                      //     },
                      //     keyboardType: TextInputType.text,
                      //     obscureText: regController.showButton2.value.isTrue
                      //         ? true
                      //         : false,
                      //     decoration: InputDecoration(
                      //       prefixIcon: const Icon(Icons.password),
                      //       // icon: const Icon(Icons.password),
                      //       label: Text('Password'.tr),
                      //       //hintText: 'Sandi',
                      //       //helperText: 'password/kode',
                      //       //counterText: '0 characters',
                      //       //border: const OutlineInputBorder(),
                      //       suffixIcon: Obx(() {
                      //         if (regController.showButton2.value.isTrue) {
                      //           return IconButton(
                      //             padding: EdgeInsets.zero,
                      //             icon: Icon(Icons.visibility,
                      //                 color: Get.theme.colorScheme.secondary),
                      //             onPressed: () {
                      //               regController.showButton2.value =
                      //                   RxBool(false);
                      //             },
                      //           );
                      //         } else {
                      //           return IconButton(
                      //             padding: EdgeInsets.zero,
                      //             icon: Icon(Icons.visibility_off,
                      //                 color: Get.theme.colorScheme.secondary),
                      //             onPressed: () {
                      //               regController.showButton2.value =
                      //                   RxBool(true);
                      //             },
                      //           );
                      //         }
                      //       }),
                      //     ),
                      //   );
                      // }),
                      const SizedBox(height: 18),
                      Container(
                          // width: formWidth2(Get.width),
                          height: 35,
                          decoration:
                              BoxDecoration(color: Get.theme.primaryColor),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('     Alamat Rumah',
                                    style: Get.theme.textTheme.titleMedium!
                                        .copyWith(color: Colors.white)),
                                InkWell(
                                    onTap: () {
                                      Get.to(ProfileAlamat(),
                                          arguments: {'tipe': 'Rumah'});
                                    },
                                    child: Icon(Icons.chevron_right, size: 30)),
                              ])),
                      const SizedBox(height: 18),
                      Container(
                          // width: formWidth2(Get.width),
                          height: 35,
                          decoration:
                              BoxDecoration(color: Get.theme.primaryColor),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('     Identitas',
                                    style: Get.theme.textTheme.titleMedium!
                                        .copyWith(color: Colors.white)),
                                InkWell(
                                    onTap: () {
                                      Get.to(ProfileIdentitas());
                                    },
                                    child: Icon(Icons.chevron_right, size: 30)),
                              ])),
                      const SizedBox(height: 18),
                      Container(
                          // width: formWidth2(Get.width),
                          height: 35,
                          decoration:
                              BoxDecoration(color: Get.theme.primaryColor),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('     Peternakan',
                                    style: Get.theme.textTheme.titleMedium!
                                        .copyWith(color: Colors.white)),
                                InkWell(
                                    onTap: () {
                                      Get.to(ProfilePeternak());
                                    },
                                    child: Icon(Icons.chevron_right, size: 30)),
                              ])),
                      const SizedBox(height: 18),
                      Container(
                          // width: formWidth2(Get.width),
                          height: 35,
                          decoration:
                              BoxDecoration(color: Get.theme.primaryColor),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('     Perbankan',
                                    style: Get.theme.textTheme.titleMedium!
                                        .copyWith(color: Colors.white)),
                                InkWell(
                                    onTap: () {
                                      Get.to(ProfilePerbankan());
                                    },
                                    child: Icon(Icons.chevron_right, size: 30)),
                              ])),
                      const SizedBox(height: 38),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('Batal',
                                  style: Get.theme.textTheme.titleMedium!
                                      .copyWith(
                                          color: Get
                                              .theme.colorScheme.secondary))),
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('Save',
                                  style: Get.theme.textTheme.titleMedium!
                                      .copyWith(color: Colors.white))),
                        ],
                      ),
                      const SizedBox(height: 28),
                    ],
                  )),
            ),
          ),
        ));
  }
}
