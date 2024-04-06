import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/bloc/ternak_controller.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';

class SppaAddInfo extends StatelessWidget {
  const SppaAddInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // load controllers and init

    final SppaHeaderController sppaController =
        Get.find<SppaHeaderController>();

    // TODO move this section to controller initSppaInfoPage()
    if (!sppaController.isNewSppa.value) {
      // load info data for editing
      sppaController.kandangController.text =
          sppaController.infoAts.value.lokasiKandang!;
      // controller.mgmtKandangController.text =
      //     controller.infoAts.value.infoMgmtKandang!;
      // controller.mgmtPakanController.text =
      //     controller.infoAts.value.infoMgmtPakan!;
      // controller.mgmtKesehatanController.text =
      //     controller.infoAts.value.infoMgmtKesehatan!;
      sppaController.initSistemPakan =
          sppaController.infoAts.value.sistemPakanTernak!;
      sppaController.initKriteriaPemeliharaan =
          sppaController.infoAts.value.kriteriaPemeliharaan!;
    } else {
      // sppaController = Get.put(SppaAddInfoController());
      sppaController.initKriteriaPemeliharaan =
          sppaController.listKriteriaPemeliharaan.first;
      sppaController.initSistemPakan = sppaController.listSistemPakan.first;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sppa (tahap 3 dari 4)'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: sppaController.addInfoFormKey,
            child: Column(
              children: [
                const SizedBox(height: 15),
                TextBodyMedium('Informasi Management Operasional'),
                const SizedBox(height: 15),
                Container(
                  width: formWidth(Get.width),
                  child: TextFormField(
                    controller: sppaController.kandangController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Alamat Kandang',
                      counterStyle: TextStyle(fontSize: 9),
                    ),
                    maxLength: 150,
                    minLines: 1,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "*Wajib diisi.";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 15),
                // Container(
                //   width: formWidth(Get.width),
                //   child: TextFormField(
                //     controller: controller.mgmtKandangController,
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Management Kandang',
                //       counterStyle: TextStyle(fontSize: 9),
                //     ),
                //     maxLength: 150,
                //     minLines: 1,
                //     maxLines: 3,
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return "*Wajib diisi berupa penjelasan.";
                //       } else {
                //         return null;
                //       }
                //     },
                //   ),
                // ),
                const SizedBox(height: 15),
                Container(
                  width: formWidth(Get.width),
                  //padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownMenu<String>(
                    width: formWidth(Get.width),
                    //   0.85, //Get.context!.width * 0.80,
                    controller: sppaController.sisPemeliharaanController,
                    label: const Text('Pemeliharaan Ternak'),

                    // expandedInsets: const EdgeInsets.symmetric(vertical: 10),
                    textStyle: TextStyle(fontSize: 12),
                    inputDecorationTheme: const InputDecorationTheme(
                      isDense: false,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                    ),
                    initialSelection: sppaController.initKriteriaPemeliharaan,
                    onSelected: (String? value) {},
                    dropdownMenuEntries: sppaController.listKriteriaPemeliharaan
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: formWidth(Get.width),
                  //padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    // border: Border.all(width: 0.5)
                  ),
                  child: DropdownMenu<String>(
                    width: formWidth(Get.width),
                    //    0.85, // Get.context!.width * 0.80,
                    label: const Text('Sistem Pakan'),
                    textStyle: TextStyle(fontSize: 12),
                    controller: sppaController.sisPakanController,
                    // expandedInsets: const EdgeInsets.symmetric(vertical: 10),
                    inputDecorationTheme: const InputDecorationTheme(
                      isDense: false,
                    ),
                    initialSelection: sppaController.initSistemPakan,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                    },
                    dropdownMenuEntries: sppaController.listSistemPakan
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 15),
                // Container(
                //   width: formWidth(Get.width),
                //   child: TextFormField(
                //     controller: controller.mgmtPakanController,
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Management Pakan',
                //       counterStyle: TextStyle(fontSize: 9),
                //     ),
                //     maxLength: 150,
                //     minLines: 1,
                //     maxLines: 3,
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return "*Wajib diisi.";
                //       } else {
                //         return null;
                //       }
                //     },
                //   ),
                // ),
                const SizedBox(height: 15),
                // Container(
                //   width: formWidth(Get.width),
                //   child: TextFormField(
                //     controller: controller.mgmtKesehatanController,
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Management Kesehatan',
                //       counterStyle: TextStyle(fontSize: 9),
                //     ),
                //     maxLength: 150,
                //     minLines: 1,
                //     maxLines: 3,
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return "*Wajib diisi.";
                //       } else {
                //         return null;
                //       }
                //     },
                //   ),
                // ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      if (sppaController.isNewSppa.value) {
                        sppaController.saveHeader();
                        Get.put(TernakController());
                        Get.toNamed('/sppa/ternaklist');
                      } else {
                        sppaController.updateHeader();
                        Get.toNamed('/sppa/ternaklist');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlueAccent,
                      ),
                      width: Get.context!.width * 0.80,
                      height: 40,
                      child: Center(
                          child: Text('Lanjut ',
                              style: Get.theme.textTheme.bodyMedium!.copyWith(
                                  color: Get.theme.colorScheme.onPrimary))),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
