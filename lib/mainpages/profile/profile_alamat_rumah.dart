import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/customer_controller.dart';
import 'package:insurance/bloc/theme_controller.dart';
import 'package:insurance/util/screen_size.dart';

class ProfileAlamat extends StatelessWidget {
  ProfileAlamat({super.key});

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
    String theTitle = Get.arguments['tipe'];

    return Scaffold(
        appBar: AppBar(title: Text('Alamat $theTitle')),
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
                          Text('Alamat Rumah',
                              style: Get.theme.textTheme.titleMedium!.copyWith(
                                  color: Get.theme.colorScheme.secondary)),
                          const SizedBox(height: 18),
                          Wrap(
                            spacing: 25,
                            runSpacing: 20,
                            direction: Axis.horizontal,
                            children: [
                              Obx(
                                () {
                                  if (custController.custIsLoaded.value) {
                                    custController.jalanCtrl.text =
                                        custController.theCustomer.value.jalan!;
                                    custController.rtCtrl.text =
                                        custController.theCustomer.value.rt!;
                                    custController.rwCtrl.text =
                                        custController.theCustomer.value.rw!;
                                    custController.kelurahanCtrl.text =
                                        custController
                                            .theCustomer.value.kelurahan!;
                                    custController.kecamatanCtrl.text =
                                        custController
                                            .theCustomer.value.kecamatan!;
                                    custController.kabupatenCtrl.text =
                                        custController
                                            .theCustomer.value.kabupaten!;
                                    custController.kotaCtrl.text =
                                        custController.theCustomer.value.kota!;
                                    custController.kodePosCtrl.text =
                                        custController
                                            .theCustomer.value.kodePos!;

                                    return TextFormField(
                                      controller: custController.jalanCtrl,
                                      maxLines: 2,
                                      onChanged: (value) {},
                                      onSaved: (value) {},
                                      validator: (value) {
                                        if (value != null && value.isNotEmpty) {
                                          if (value.length > 3) {
                                            return null;
                                          } else {
                                            return "Masukkan nama jalan dan nomor rumah";
                                          }
                                        } else {
                                          return "Masukkan nama jalan dan nomor rumah";
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.home),
                                        // icon: const Icon(Icons.person),
                                        label: Text('Jalan'.tr),
                                        // hintText: 'Nama',
                                        // helperText: 'Nama anda',
                                        //counterText: '0 characters',
                                        //border: OutlineInputBorder(),
                                      ),
                                    );
                                  } else
                                    return Container();
                                },
                              ),
                              Obx(
                                () => custController.custIsLoaded.value
                                    ? Container(
                                        width: 100,
                                        child: TextFormField(
                                          controller: custController.rtCtrl,
                                          onChanged: (value) {},
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              if (value.length > 3) {
                                                return null;
                                              } else {
                                                return "Masukkan RT";
                                              }
                                            } else {
                                              return "Masukkan RT";
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            // prefixIcon: const Icon(Icons.person),

                                            label: Text('RT'.tr),
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
                                        width: 100,
                                        child: TextFormField(
                                          controller: custController.rwCtrl,
                                          onChanged: (value) {},
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              if (value.length > 3) {
                                                return null;
                                              } else {
                                                return "Masukkan RW";
                                              }
                                            } else {
                                              return "Masukkan RW";
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            //prefixIcon: const Icon(Icons.person),
                                            label: Text('RW'.tr),
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
                                        width: 180,
                                        child: TextFormField(
                                          controller:
                                              custController.kelurahanCtrl,
                                          onChanged: (value) {},
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              if (value.length > 3) {
                                                return null;
                                              } else {
                                                return "Masukkan Kelurahan";
                                              }
                                            } else {
                                              return "Masukkan Kelurahan";
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            //prefixIcon: const Icon(Icons.person),
                                            label: Text('Kelurahan'.tr),
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
                                        width: 180,
                                        child: TextFormField(
                                          controller:
                                              custController.kecamatanCtrl,
                                          onChanged: (value) {},
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              if (value.length > 3) {
                                                return null;
                                              } else {
                                                return "Masukkan Kecamatan";
                                              }
                                            } else {
                                              return "Masukkan Kecamatan";
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            // prefixIcon: const Icon(Icons.person),
                                            label: Text('Kecamatan'.tr),
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
                                        width: 180,
                                        child: TextFormField(
                                          controller:
                                              custController.kabupatenCtrl,
                                          onChanged: (value) {},
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              if (value.length > 3) {
                                                return null;
                                              } else {
                                                return "Masukkan Kabupaten";
                                              }
                                            } else {
                                              return "Masukkan Kabupaten";
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            // prefixIcon: const Icon(Icons.person),
                                            label: Text('Kabupaten'.tr),
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
                                        width: 180,
                                        child: TextFormField(
                                          controller: custController.kotaCtrl,
                                          onChanged: (value) {},
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              if (value.length > 3) {
                                                return null;
                                              } else {
                                                return "Masukkan Kota";
                                              }
                                            } else {
                                              return "Masukkan Kota";
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            //prefixIcon: const Icon(Icons.person),
                                            label: Text('Kota'.tr),
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
                                          controller:
                                              custController.kodePosCtrl,
                                          onChanged: (value) {},
                                          onSaved: (value) {},
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              if (value.length > 3) {
                                                return null;
                                              } else {
                                                return "Masukkan kode pos";
                                              }
                                            } else {
                                              return "Masukkan Kota";
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                                Icons.local_post_office),
                                            // icon: const Icon(Icons.person),
                                            label: Text('Kode Pos'.tr),
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
