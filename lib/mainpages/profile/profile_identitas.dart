import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/customer_controller.dart';
import 'package:insurance/bloc/theme_controller.dart';
import 'package:insurance/util/screen_size.dart';

class ProfileIdentitas extends StatelessWidget {
  ProfileIdentitas({super.key});

  ThemeController themeController = Get.find();
  CustomerController custController = Get.put(CustomerController());

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
    return Scaffold(
        appBar: AppBar(title: Text('Identitas')),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
              child: Container(
                  width: formWidth(Get.width),
                  child: Form(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 18),
                          Obx(() {
                            if (custController.custIsLoaded.value) {
                              custController.ktpCtrl.text =
                                  custController.theCustomer.value.ktp!;
                              custController.pobCtrl.text =
                                  custController.theCustomer.value.pob!;
                              custController.dobCtrl.text =
                                  custController.theCustomer.value.dob!;

                              return Text('Identitas',
                                  style: Get.theme.textTheme.titleMedium!
                                      .copyWith(
                                          color:
                                              Get.theme.colorScheme.secondary));
                            } else
                              return Container();
                          }),
                          const SizedBox(height: 9),
                          Wrap(
                            spacing: 25,
                            runSpacing: 20,
                            direction: Axis.horizontal,
                            children: [
                              Obx(
                                () => custController.custIsLoaded.value
                                    ? Container(
                                        width: 220,
                                        child: TextFormField(
                                          controller: custController.ktpCtrl,
                                          onChanged: (value) {},
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              if (value.length > 3) {
                                                return null;
                                              } else {
                                                return "Masukkan nomor ktp anda";
                                              }
                                            } else {
                                              return "Masukkan nomor ktp anda";
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                const Icon(Icons.person),
                                            // icon: const Icon(Icons.person),
                                            label: Text('Ktp'.tr),
                                            // hintText: 'Nama',
                                            // helperText: 'Nama anda',
                                            //counterText: '0 characters',
                                            //border: OutlineInputBorder(),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                              Obx(
                                () => custController.custIsLoaded.value
                                    ? Container(
                                        width: 150,
                                        child: TextFormField(
                                          controller: custController.dobCtrl,
                                          onChanged: (value) {},
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              if (value.length > 3) {
                                                return null;
                                              } else {
                                                return "Masukkan tanggal Lahir";
                                              }
                                            } else {
                                              return "Masukkan tanggal Lahir";
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            // prefixIcon: const Icon(Icons.person),
                                            label: Text('Tanggal Lahir'.tr),
                                            // hintText: 'Nama',
                                            // helperText: 'Nama anda',
                                            //counterText: '0 characters',
                                            //border: OutlineInputBorder(),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                              Obx(
                                () => custController.custIsLoaded.value
                                    ? Container(
                                        width: 200,
                                        child: TextFormField(
                                          controller: custController.pobCtrl,
                                          onChanged: (value) {},
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              if (value.length > 3) {
                                                return null;
                                              } else {
                                                return "Masukkan kota kelahiran";
                                              }
                                            } else {
                                              return "Masukkan kota kelahiran";
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            // prefixIcon: const Icon(Icons.person),
                                            label: Text('Kota Kelahiran'.tr),
                                            // hintText: 'Nama',
                                            // helperText: 'Nama anda',
                                            //counterText: '0 characters',
                                            //border: OutlineInputBorder(),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              )
                            ],
                          ),
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
                                              color: Get.theme.colorScheme
                                                  .secondary))),
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
                        ]),
                  ))),
        ));
  }
}
