import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/login_controller.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/bloc/ternak_controller.dart';
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
    ProdukController prodController = Get.find();
    LoginController loginController = Get.find();

    SppaHeaderController sppaController;

    final thisSppa = Get.arguments['sppaId'];
    final theProd = Get.arguments['prodId'];
    print('sppa_main  sppaId:$thisSppa prod:$theProd');

    if (thisSppa == '') {
      sppaController = Get.put(SppaHeaderController());
    } else {
      sppaController = Get.find<SppaHeaderController>();
    }

    print(
        'role ${loginController.check.value.roles} userId: ${loginController.check.value.userData.name} ');

    // TODO move this section to controller initSppaMainPage ()
    if (loginController.check.value.roles == 'ROLE_SALES') {
      print('new sppa by ROLE_SALES');
      sppaController.customerController.value.text = '';
      sppaController.initProduct =
          sppaController.appProdukController.listAllProdukAsuransi.first;
      sppaController.isNewSppa.value = true;
      sppaController.produkController.text = 'Pilih  Produk';
    } else if (thisSppa != '') {
      print('sppa main for editing $thisSppa');
      sppaController.isNewSppa.value = false;

      // load existing sppa for editing
      sppaController.customerController.value.text =
          sppaController.sppaHeader.value.customerId!;
      // print('set name ');
      sppaController.produkController.text =
          sppaController.sppaHeader.value.produkName!;
      // print('set product');
      sppaController.initProduct = sppaController
          .appProdukController.listAllProdukAsuransi
          .firstWhere((e) =>
              e.productName == sppaController.sppaHeader.value.produkName);
      // print('set initProd');
      // sppaController.produkController.text =
      //     sppaController.initProduct!.productName!;
      //print('proof ${sppaController.initProduct!.productName}');
    } else if (theProd != '') {
      // buy from product catalog
      print('sppa main for new sppa product $theProd');
      print('user :${loginController.check.value.userData.userId}');
      sppaController.isNewSppa.value = true;
      sppaController.customerController.value.text =
          loginController.check.value.userData.userId;
      sppaController.validateCustomer();
      sppaController.initProduct = prodController.selected.value;
      sppaController.produkController.text =
          sppaController.initProduct!.productName!;
      sppaController.selectProduct(sppaController.initProduct!);
    } else {
      // buy from dashboard
      // print(
      //     'sppa main : new Sppa by ${loginController.check.value.userData.userId} no product selected');
      sppaController.isNewSppa.value = true;
      sppaController.customerController.value.text =
          loginController.check.value.userData.userId;
      sppaController.validateCustomer();
      sppaController.produkController.text = 'Pilih  Produk';
      // to load all product data to sppaHeader
      if (sppaController.appProdukController.listAllProdloaded.value) {
        sppaController.initProduct =
            sppaController.appProdukController.listAllProdukAsuransi.first;
        sppaController.selectProduct(sppaController.initProduct!);
        sppaController.produkController.text = 'Pilih  Produk';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sppa (tahap 1 dari 3)'),
        actions: [
          Text(
            'User: ${loginController.check.value.userData.userId}',
            style: TextStyle(color: Colors.white),
          )
        ],
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
                if (sppaController
                    .appProdukController.listAllProdukAsuransi.isNotEmpty) {
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
                      // hintText: 'Pilih produk',
                      onSelected: (ProdukAsuransi? value) {
                        // This is called when the user selects an item.
                        print('selected: ${value!.productName}');
                        sppaController.selectProduct(value);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      //print('field diclear');
                      // sppaController.customerController.value.text = '';
                      // sppaController.produkController.text = '';
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlueAccent,
                      ),
                      width: 100,
                      height: 40,
                      child: Center(
                          child: Text('Batal',
                              style: Get.theme.textTheme.bodyMedium!.copyWith(
                                  color: Get.theme.colorScheme.onPrimary))),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/sppa/perluasan',
                          arguments: {'sppaId', thisSppa});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlueAccent,
                      ),
                      width: 100,
                      height: 40,
                      child: Center(
                          child: Text('Lanjut',
                              style: Get.theme.textTheme.bodyMedium!.copyWith(
                                  color: Get.theme.colorScheme.onPrimary))),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

    ;
  }
}
