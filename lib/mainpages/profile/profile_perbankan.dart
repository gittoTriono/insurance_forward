import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/customer_controller.dart';
import 'package:insurance/bloc/theme_controller.dart';
import 'package:insurance/util/screen_size.dart';

class ProfilePerbankan extends StatelessWidget {
  ProfilePerbankan({super.key});

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
        appBar: AppBar(title: Text('Perbankan')),
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
                          Obx(
                            () {
                              custController.bankCtrl.text =
                                  custController.theCustomer.value.bankName!;
                              custController.accntNoCtrl.text = custController
                                  .theCustomer.value.bankAccountNumber!;
                              custController.namaAccntCtrl.text = custController
                                  .theCustomer.value.bankAccountNama!;

                              return Text('Perbankan',
                                  style: Get.theme.textTheme.titleMedium!
                                      .copyWith(
                                          color:
                                              Get.theme.colorScheme.secondary));
                            },
                          ),
                          const SizedBox(height: 9),
                          Wrap(
                            spacing: 25,
                            runSpacing: 20,
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                width: 150,
                                child: TextFormField(
                                  controller: custController.bankCtrl,
                                  onChanged: (value) {},
                                  onSaved: (value) {},
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      if (value.length > 3) {
                                        return null;
                                      } else {
                                        return "Pilih Kode Bank";
                                      }
                                    } else {
                                      return "Pilih Kode Bank";
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    // prefixIcon: const Icon(Icons.person),
                                    label: Text('Kode Bank'.tr),
                                    // hintText: 'Nama',
                                    // helperText: 'Nama anda',
                                    //counterText: '0 characters',
                                    //border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                child: TextFormField(
                                  controller: custController.accntNoCtrl,
                                  onChanged: (value) {},
                                  onSaved: (value) {},
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      if (value.length > 3) {
                                        return null;
                                      } else {
                                        return "Masukkan nomor rekening Bank";
                                      }
                                    } else {
                                      return "Masukkan nomor rekening Bank";
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    // prefixIcon: const Icon(Icons.person),
                                    label: Text('Nomor Rekening'.tr),
                                    // hintText: 'Nama',
                                    // helperText: 'Nama anda',
                                    //counterText: '0 characters',
                                    //border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              Container(
                                width: 250,
                                child: TextFormField(
                                  controller: custController.namaAccntCtrl,
                                  onChanged: (value) {},
                                  onSaved: (value) {},
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      if (value.length > 3) {
                                        return null;
                                      } else {
                                        return "Masukkan nama anda pada rekening Bank";
                                      }
                                    } else {
                                      return "Masukkan nama anda pada rekening Bank";
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    // prefixIcon: const Icon(Icons.person),
                                    label: Text('Nama Pada Rekening'.tr),
                                    // hintText: 'Nama',
                                    // helperText: 'Nama anda',
                                    //counterText: '0 characters',
                                    //border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
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
