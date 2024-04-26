import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/produk_controller.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/model/sppa_header.dart';

class SppaPerluasan extends StatelessWidget {
  const SppaPerluasan({super.key});

  @override
  Widget build(BuildContext context) {
    SppaHeaderController sppaController = Get.find<SppaHeaderController>();

    // ProdukController prodController = Get.find<ProdukController>();
    // if (sppaController.isNewSppa.value) {
    //   sppaController.getPerluasanRisikoSppa();
    // }

    // sppaController.calculateTotalRate(); // initial only from base

    return Scaffold(
        appBar: AppBar(title: Text('Sppa (tahap 2 dari 4)')),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Center(
                        child: Text(
                            '${sppaController.appProdukController.selected.value.productName}'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${(sppaController.appProdukController.selected.value.ratePremi! * 100).toStringAsFixed(3)} %',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 15),
              SizedBox(height: 15),
              Obx(() {
                if (sppaController
                    .appProdukController.listPerluasanJaminanLoaded.value) {
                  return Wrap(
                      spacing: 20,
                      runSpacing: 10,
                      children: sppaController
                          .appProdukController.listPerluasanRisiko.value
                          .map(
                            (pr) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Checkbox(value: false, onChanged: (value) setOption()),
                                  Expanded(
                                    flex: 1,
                                    child: Checkbox(
                                        value: pr.selected,
                                        onChanged: (value) {
                                          print('awal : ${pr.selected}');
                                          pr.selected = value!;
                                          print('lalu : ${pr.selected}');

                                          sppaController.appProdukController
                                              .listPerluasanRisiko
                                              .refresh();
                                          //sppaController.calculateTotalRate();
                                          print(
                                              'checkbox ${pr.namaPerluasanRisiko} is ${pr.selected}');
                                        }),
                                  ),

                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(pr.namaPerluasanRisiko!),
                                        Text(pr.deskripsi!,
                                            style: Get
                                                .theme.textTheme.bodySmall!
                                                .copyWith(
                                                    color: Get.theme.colorScheme
                                                        .secondary))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                        '${(pr.rate! * 100).toStringAsFixed(3)} %',
                                        textAlign: TextAlign.center),
                                  ),
                                ]),
                          )
                          .toList());
                } else {
                  return Container();
                }
              }),
              Divider(height: 30),
              Obx(() {
                if (sppaController
                    .appProdukController.listPerluasanJaminanLoaded.value) {
                  sppaController.calculateTotalRate();

                  return Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Center(child: Text('Total Rate Premi')),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                            '${(sppaController.totalRate.value * 100).toStringAsFixed(3)} %',
                            textAlign: TextAlign.center),
                      )
                    ],
                  );
                } else {
                  return Container();
                }
              }),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      print('field diclear');
                      // TODO clear selection
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
                      sppaController.sppaHeader.value.premiRate =
                          sppaController.totalRate.value;
                      Get.toNamed('/sppa/addInfo');
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
        )));
  }
}
