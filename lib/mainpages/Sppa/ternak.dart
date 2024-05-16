import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/bloc/ternak_controller.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class TernakSppa extends StatelessWidget {
  const TernakSppa({super.key});

  @override
  Widget build(BuildContext context) {
    // load controllers
    TernakController controller;

    SppaHeaderController sppaController = Get.find<SppaHeaderController>();
    //final sppaId = sppaController.sppaHeader.id;

    // move this section to contoller initTernakPage()
    if (!sppaController.isNewSppa.value) {
      // load ternak for edit
      controller = Get.find<TernakController>();
    } else {
      controller = Get.put(TernakController());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sppa (4 dari 4)'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Container(
              //   width: formWidth(Get.width),
              //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //   child: TextFormField(
              //     validator: (value) {
              //       if (value == null ||
              //           value.isEmpty ||
              //           !value.isNumericOnly) {
              //         return "*Wajib diisi oleh angka.";
              //       } else {
              //         return null;
              //       }
              //     },
              //     controller: controller.jmlTernakController,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(gapPadding: 10),
              //       focusColor: Colors.blueAccent,
              //       label: Text('Jumlah Ternak'),
              //       hintText: 'Masukkan Jumlah Ternak Yang Akan Diasuransikan',
              //       contentPadding: EdgeInsets.all(15),
              //       prefixIcon: Icon(Icons.check_box),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20),
              TextBodyMedium('Klik untuk menambah ternak '),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      elevation: 10,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    Get.toNamed('/sppa/ternakform');
                  },
                  icon: const Icon(Icons.add, size: 35),
                ),
              ]),
              const Divider(height: 30, thickness: 1),
              TextBodyMedium('Daftar Ternak'),
              const SizedBox(height: 10),
              Obx(
                // list tiles with inputed ternak
                () => Column(
                    children: controller.listTernak.value
                        .map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                tileColor: Colors.blue[100],
                                title: Text(
                                    'Jenis / Kelamin -  ${item.jenis} / ${item.kelamin}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Pertanggungan      Rp. ${NumberFormat("#,###,###,###", "en_US").format(item.nilaiPertanggungan)} '),
                                    Text(
                                        'Perolehan          Rp. ${NumberFormat("#,###,###,###", "en_US").format(item.hargaPerolehan)} '),
                                    Text('Tgl lahir : ${item.tglLahir!}'),
                                  ],
                                ),
                                leading: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width: 120,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black),
                                  child: Center(
                                    child: Text(item.earTag.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red, size: 30),
                                  onPressed: () {
                                    controller.deleteATernak(item);
                                  },
                                ),
                              ),
                            ))
                        .toList()),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: InkWell(
                  onTap: () {
                    if (sppaController.isNewSppa.value) {
                      Get.until((route) => route.settings.name == '/sppa');
                    } else {
                      Get.until(
                        (route) => route.settings.name == '/sppa/sppaDetail',
                      );
                    }
                    ;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lightBlueAccent,
                    ),
                    width: Get.context!.width * 0.80,
                    height: 40,
                    child: Center(
                        child: Text('Sppa Selesai ',
                            style: Get.theme.textTheme.bodyMedium!.copyWith(
                                color: Get.theme.colorScheme.onPrimary))),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
