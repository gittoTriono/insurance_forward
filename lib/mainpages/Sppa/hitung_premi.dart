import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/produk_controller.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class HitungPremi extends StatelessWidget {
  HitungPremi({super.key});
  @override
  Widget build(BuildContext context) {
    ProdukController prodController = Get.find<ProdukController>();
    prodController.getPerluasanJaminan();

    final GlobalKey<FormState> hitungKey = GlobalKey<FormState>();
    final nilaiController = TextEditingController();
    RxBool hitungDone = false.obs;
    RxDouble totalPremi = 0.0.obs;
    RxDouble totalRate = 0.0.obs;

    void hitungPremi() {
      totalRate.value = prodController.selected.value.ratePremi!;

      for (int idx = 0;
          idx < prodController.listPerluasanRisiko.length;
          idx++) {
        if (prodController.listPerluasanRisiko[idx].selected!) {
          totalRate.value =
              totalRate.value + prodController.listPerluasanRisiko[idx].rate!;
          print('total rate: ${totalRate} , nilai ${nilaiController.text}');
        }
      }

      totalPremi.value = totalRate * double.parse(nilaiController.text);
      print('total premi ${totalPremi}');
      hitungDone.value = true;
    }

    Widget showHitung() {
      // NumberFormat("#,###,###,###", "en_US").format(totalAmount * totalPremi).toString()
      if (hitungDone.value) {
        print('go ahead show');
        return Container(
            width: formWidth(Get.width * 1.1),
            child: Column(
              children: [
                Divider(height: 30, thickness: 0.5),
                Container(
                    width: formWidth(Get.width * 1.1),
                    height: 40,
                    decoration:
                        BoxDecoration(color: Get.theme.colorScheme.primary),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Center(
                        child: Text('Hasil Perhitungan',
                            style: Get.theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white)),
                      ),
                    )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(children: [
                        Expanded(flex: 1, child: Text('Total rate ')),
                        Expanded(
                            flex: 1,
                            child: Text(
                                '${(totalRate.value * 100).toStringAsFixed(3)} %'))
                      ]),
                      SizedBox(height: 10),
                      Row(children: [
                        Expanded(
                            flex: 1, child: Text('Total Nilai Pertanggungan ')),
                        Expanded(
                            flex: 1,
                            child: Text(
                                'Rp. ${NumberFormat("#,###,###,###", "en_US").format(int.parse(nilaiController.text))}'))
                      ]),
                      SizedBox(height: 10),
                      Row(children: [
                        Expanded(flex: 1, child: Text('Total Premi ')),
                        Expanded(
                            flex: 1,
                            child: Text(
                                'Rp. ${NumberFormat("#,###,###,###", "en_US").format(totalPremi.value)}'))
                      ]),
                      SizedBox(height: 10),
                      Row(children: [
                        Expanded(flex: 1, child: Text('Tenor ')),
                        Expanded(
                            flex: 1,
                            child: Text(
                                '${prodController.selected.value.tenor} bulan'))
                      ]),
                    ],
                  ),
                ),
              ],
            ));
      } else {
        return Container();
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Hitung Premi')),
      body: Center(
        child: Container(
          width: formWidth(Get.width * 1.1),
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(flex: 4, child: Center(child: Text('Produk'))),
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Text('Rate'),
                        ))
                  ],
                ),
                Divider(height: 20),
                Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child:
                            Text(prodController.selected.value.productName!)),
                    Expanded(
                        flex: 1,
                        child: Text(
                            '${(prodController.selected.value.ratePremi! * 100).toStringAsFixed(3)} %'))
                  ],
                ),
                Divider(height: 20),
                Obx(
                  () => prodController.listPerluasanJaminanLoaded.value
                      ? Wrap(
                          spacing: 20,
                          runSpacing: 10,
                          children: prodController.listPerluasanRisiko
                              .map(
                                (pr) => Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Checkbox(value: false, onChanged: (value) setOption()),
                                      Checkbox(
                                          value: pr.selected,
                                          onChanged: (value) {
                                            // print('awal : ${pr.selected}');
                                            pr.selected = value!;
                                            hitungDone.value = false;
                                            // print('lalu : ${pr.selected}');

                                            prodController
                                                .listPerluasanJaminanLoaded
                                                .refresh();
                                          }),

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
                                                        color: Get
                                                            .theme
                                                            .colorScheme
                                                            .secondary))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                              '${(pr.rate! * 100).toStringAsFixed(3)} %')),
                                    ]),
                              )
                              .toList())
                      : Container(),
                ),
                Divider(height: 30),
                Form(
                  key: hitungKey,
                  child: TextFormField(
                    controller: nilaiController,
                    decoration: InputDecoration(
                        label: Text('Nilai Total Tertanggung'),
                        labelStyle: Get.theme.textTheme.bodyMedium!
                            .copyWith(color: Get.theme.colorScheme.secondary),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    onChanged: (value) {
                      hitungDone.value = false;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "*Required.";
                      } else {
                        nilaiController.text = value;
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      hitungPremi();
                    },
                    child: Text('Hitung Premi',
                        style: Get.theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.white))),
                SizedBox(height: 10),
                Obx(() => showHitung()),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
