import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/sppa_addinfo_controller.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/bloc/ternak_controller.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';

class SppaAddInfo extends StatelessWidget {
  const SppaAddInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // load controllers and init
    SppaAddInfoController controller;
    final SppaHeaderController sppaController =
        Get.find<SppaHeaderController>();

    if (!sppaController.isNewSppa.value) {
      // load info data for editing
      controller = Get.find<SppaAddInfoController>();
      final sppaId = sppaController.sppaHeader.id;
      controller.kandangController.text =
          controller.infoAts.value.lokasiKandang!;
      controller.mgmtKandangController.text =
          controller.infoAts.value.infoMgmtKandang!;
      controller.mgmtPakanController.text =
          controller.infoAts.value.infoMgmtPakan!;
      controller.mgmtKesehatanController.text =
          controller.infoAts.value.infoMgmtKesehatan!;
      controller.initSistemPakan = controller.infoAts.value.sistemPakanTernak!;
      controller.initKriteriaPemeliharaan =
          controller.infoAts.value.kriteriaPemeliharaan!;
    } else {
      controller = Get.put(SppaAddInfoController());
      controller.initKriteriaPemeliharaan =
          controller.listKriteriaPemeliharaan.first;
      controller.initSistemPakan = controller.listSistemPakan.first;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sppa (tahap 2 dari 3)'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.addInfoFormKey,
            child: Column(
              children: [
                const SizedBox(height: 15),
                TextBodyMedium('Informasi Management Operasional'),
                const SizedBox(height: 15),
                Container(
                  width: formWidth(Get.width),
                  child: TextFormField(
                    controller: controller.kandangController,
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
                Container(
                  width: formWidth(Get.width),
                  child: TextFormField(
                    controller: controller.mgmtKandangController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Management Kandang',
                      counterStyle: TextStyle(fontSize: 9),
                    ),
                    maxLength: 150,
                    minLines: 1,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "*Wajib diisi berupa penjelasan.";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
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
                    controller: controller.sisPemeliharaanController,
                    label: const Text('Pemeliharaan Ternak'),

                    // expandedInsets: const EdgeInsets.symmetric(vertical: 10),
                    textStyle: TextStyle(fontSize: 12),
                    inputDecorationTheme: const InputDecorationTheme(
                      isDense: false,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                    ),
                    initialSelection: controller.initKriteriaPemeliharaan,
                    onSelected: (String? value) {},
                    dropdownMenuEntries: controller.listKriteriaPemeliharaan
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
                    controller: controller.sisPakanController,
                    // expandedInsets: const EdgeInsets.symmetric(vertical: 10),
                    inputDecorationTheme: const InputDecorationTheme(
                      isDense: false,
                    ),
                    initialSelection: controller.initSistemPakan,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                    },
                    dropdownMenuEntries: controller.listSistemPakan
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: formWidth(Get.width),
                  child: TextFormField(
                    controller: controller.mgmtPakanController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Management Pakan',
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
                Container(
                  width: formWidth(Get.width),
                  child: TextFormField(
                    controller: controller.mgmtKesehatanController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Management Kesehatan',
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
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      if (sppaController.isNewSppa.value) {
                        controller.saveInfoData();
                        Get.put(TernakController());
                        Get.toNamed('/sppa/ternaklist');
                      } else {
                        print(controller.infoAts.value.infoMgmtKandang);
                        print(controller.mgmtKandangController.text);
                        print(controller.infoAts.value.infoMgmtKesehatan);
                        print(controller.mgmtKesehatanController.text);
                        print(controller.infoAts.value.infoMgmtPakan);
                        print(controller.mgmtPakanController.text);
                        print(controller.infoAts.value.lokasiKandang);
                        print(controller.kandangController.text);
                        print(controller.infoAts.value.sistemPakanTernak);
                        print(controller.sisPakanController.text);
                        print(controller.infoAts.value.kriteriaPemeliharaan);
                        print(controller.sisPemeliharaanController.text);

                        if (controller.infoAts.value.infoMgmtKandang ==
                                controller.mgmtKandangController.text &&
                            controller.infoAts.value.infoMgmtKesehatan ==
                                controller.mgmtKesehatanController.text &&
                            controller.infoAts.value.infoMgmtPakan ==
                                controller.mgmtPakanController.text &&
                            controller.infoAts.value.lokasiKandang ==
                                controller.kandangController.text &&
                            controller.infoAts.value.sistemPakanTernak ==
                                controller.sisPakanController.text &&
                            controller.infoAts.value.kriteriaPemeliharaan ==
                                controller.sisPemeliharaanController.text) {
                          print('info no change');
                        } else {
                          print('info changed ');
                          controller.updateInfoData();
                        }
                        Get.put(TernakController());
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
