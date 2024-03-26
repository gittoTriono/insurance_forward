import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/sppa_addinfo_controller.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/bloc/ternak_controller.dart';
//import 'package:insurance_inputer/controller/counters.dart';
import 'package:insurance/model/products.dart';
import 'package:insurance/model/sppa_header.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';
import '/bloc/produk_controller.dart';
import '/util/constants.dart';

class SppaMaintenance extends StatelessWidget {
  const SppaMaintenance({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO  periksa di SppaController apakah isNewSppa?
    // kalau iya create mode; no initialize texteditingcontroller
    // kalau nggak edit mode; isi semua controller variable to accept update

    SppaHeaderController sppaController = Get.find<SppaHeaderController>();

    if (!sppaController.isNewSppa.value) {
      final thisSppaId = Get.arguments['sppaId'];
      print('sppa main for editing $thisSppaId');
      // load existing sppa for editing
      sppaController.customerController.value.text =
          sppaController.sppaHeader.customerId!;
      sppaController.produkController.text =
          sppaController.sppaHeader.produkName!;
      sppaController.initProduct =
          sppaController.appProdukController.listAllProdukAsuransi.firstWhere(
              (e) => e.productName == sppaController.sppaHeader.produkName);
      print('proof ${sppaController.initProduct!.productName}');
    } else {
      print('sppa main for new');
      if (sppaController.sppaHeader.customerId != '') {
        sppaController.customerController.value.text =
            sppaController.sppaHeader.customerId!;
        // to load all customer data to sppaHeader
        sppaController.validateCustomer();
        print(
            'customer id sudah ada ${sppaController.customerController.value.text}');
      }

      if (sppaController.sppaHeader.produkCode != '') {
        print('product code sudah ada ${sppaController.sppaHeader.produkCode}');
        print(
            'product loaded ada ${sppaController.appProdukController.listSelectedProdukAsuransi.value.length}');
        sppaController.initProduct = sppaController
            .appProdukController.listSelectedProdukAsuransi.value
            .firstWhere(
                (e) => e.productCode == sppaController.sppaHeader.produkCode);
        // to load all product data to sppaHeader
        sppaController.selectProduct(sppaController.initProduct!);
        sppaController.produkController.text =
            sppaController.initProduct!.productName!;
      } else {
        print('product pilih dulu');
        sppaController.initProduct = sppaController
            .appProdukController.listAllProdukAsuransi.value.first;
        SppaAddInfoController infoController = Get.put(SppaAddInfoController());
        TernakController aTernakController = Get.put(TernakController());
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sppa (tahap 1 dari 3)'),
      ),
      body: Form(
        key: sppaController.sppaFormKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              TextBodyMedium('Data Utama'),
              const SizedBox(height: 20),
              Obx(
                () => Container(
                  width: formWidth(Get.width),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                      focusNode: sppaController.fn1,
                      controller: sppaController.customerController.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "*Wajib diisi.";
                        } else {
                          sppaController.validateCustomer();
                          if (!sppaController.custOk.value) {
                            return 'Customer Id tidak dikernal';
                          }
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(gapPadding: 10),
                        focusColor: Colors.blueAccent,
                        label: Text('Nomer Pelanggan'),
                        hintText: 'Masukkan Nomer Pelanggan anda',
                        contentPadding: EdgeInsets.all(15),
                        prefixIcon: Icon(Icons.people_alt_rounded),
                      )),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (sppaController.appProdukController.listAllProdukAsuransi
                    .value.isNotEmpty) {
                  return Container(
                    // width: formWidth(Get.width),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownMenu<ProdukAsuransi>(
                      width: formWidth(Get.width) *
                          0.95, // Get.context!.width * 0.80,
                      controller: sppaController.produkController,
                      inputDecorationTheme: const InputDecorationTheme(
                        contentPadding: EdgeInsets.only(left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      initialSelection: sppaController.initProduct,
                      hintText: 'Pilih produk',
                      onSelected: (ProdukAsuransi? value) {
                        // This is called when the user selects an item.
                        sppaController.selectProduct(value!);

                        sppaController.produkController.text =
                            '${value.productName}';
                        // sppaController.validateNextButton();
                      },
                      dropdownMenuEntries: sppaController
                          .appProdukController.listAllProdukAsuransi
                          .map<DropdownMenuEntry<ProdukAsuransi>>(
                              (ProdukAsuransi value) {
                        return DropdownMenuEntry<ProdukAsuransi>(
                          value: value,
                          label: value.productName!,
                        );
                      }).toList(),
                    ),
                  );
                } else
                  return Text('No Product Loaded.');
              }),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: InkWell(
                  onTap: () {
                    if (sppaController.isNewSppa.value) {
                      sppaController.saveHeader();
                      sppaController.nextButOk.value = true;
                      // SppaAddInfoController controller =
                      //     Get.put(SppaAddInfoController());
                      Get.toNamed('/sppa/addInfo');
                    } else {
                      print(sppaController.sppaHeader.produkName);
                      print(sppaController.produkController.text);
                      print(sppaController.sppaHeader.customerId);
                      print(sppaController.customerController.value.text);
                      if (sppaController.sppaHeader.produkName ==
                              sppaController.produkController.text &&
                          sppaController.sppaHeader.customerId ==
                              sppaController.customerController.value.text) {
                        print('header no change');
                      } else {
                        print('header changed');
                        sppaController.updateHeader();
                      }
                      Get.toNamed('/sppa/addInfo');
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
    );
  }
}
