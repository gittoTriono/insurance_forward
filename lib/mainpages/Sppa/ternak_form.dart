import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/bloc/ternak_controller.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class TernakForm extends StatelessWidget {
  const TernakForm({super.key});

  @override
  Widget build(BuildContext context) {
    //SppaHeaderController sppaController = Get.find<SppaHeaderController>();
    TernakController controller = Get.find<TernakController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Ternak'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: controller.ternakFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  width: formWidth(Get.width),
                  child: TextFormField(
                    // focusNode: fn2,
                    // TODO double check duplicate eartag
                    style: TextStyle(fontSize: 12),
                    controller: controller.earTagController,
                    decoration: const InputDecoration(
                      //isDense: true,
                      //constraints: BoxConstraints.tightFor(),
                      border: OutlineInputBorder(),
                      labelText: 'Ear Tag',
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "*Wajib diisi.";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Container(
                      //                controller: controller.dobController,
                      width: formWidth(Get.width),
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(children: [
                        const Icon(Icons.edit_calendar),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            controller.chooseDate();
                          },
                          child: Text(
                            DateFormat("dd-MMM-yyyy")
                                .format(controller.pickedDate.value)
                                .toString(),
                          ),
                        )
                      ])
                      //label text of field,
                      ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: formWidth(Get.width),
                  padding: const EdgeInsets.only(top: 5),
                  child: DropdownMenu<String>(
                    textStyle: TextStyle(fontSize: 12),
                    width: formWidth(Get.width),
                    label: const Text('Jenis Sapi'),
                    controller: controller.jenisController,
                    inputDecorationTheme: const InputDecorationTheme(
                      //contentPadding: EdgeInsets.only(left: 10),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    initialSelection: controller.jenisSapi.first,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      Obx(() {
                        controller.jenisController.text = value!;
                        return Text(value);
                      });
                    },
                    dropdownMenuEntries: controller.jenisSapi
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: formWidth(Get.width),
                  padding: const EdgeInsets.only(top: 5),
                  child: DropdownMenu<String>(
                    textStyle: TextStyle(fontSize: 12),
                    width: formWidth(Get.width),
                    label: const Text('Jenis Kelamin'),
                    controller: controller.kelaminController,
                    inputDecorationTheme: const InputDecorationTheme(
                      isDense: true,
                      //contentPadding: EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    initialSelection: controller.jenisKelamin.first,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      Obx(() {
                        controller.kelaminController.text = value!;
                        return Text(value);
                      });
                    },
                    dropdownMenuEntries: controller.jenisKelamin
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: formWidth(Get.width),
                  padding: const EdgeInsets.only(top: 5),
                  child: TextFormField(
                    // focusNode: fn2,
                    style: TextStyle(fontSize: 12),

                    controller: controller.perolehanController,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Nilai pembelian',
                      hintStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(),
                      labelText: 'Nilai Pembelian',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "*Wajib disini.";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: formWidth(Get.width),
                  padding: const EdgeInsets.only(top: 5),
                  child: TextFormField(
                    // focusNode: fn2,
                    style: TextStyle(fontSize: 12),

                    controller: controller.pertanggunganController,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Nilai yang akan diasuransikan',
                      hintStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(),
                      labelText: 'Nilai Pertanggungan',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "*Wajib disini.";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    TextBodyMedium('Upload foto disini '),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          elevation: 10,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Get.toNamed('/sppa/ternakfoto');
                      },
                      icon: const Icon(Icons.photo, size: 35),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                  thickness: 1,
                  indent: 40,
                  endIndent: 40,
                ),
                Center(
                  child: IconButton(
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        elevation: 10,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      if (controller.ternakSeqNo.value <
                          int.parse(controller.jmlTernakController.text)) {
                        controller.saveATernak();
                        Get.back();
                        // TODO else snackBar
                      }
                    },
                    icon: const Icon(Icons.done, size: 35),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
