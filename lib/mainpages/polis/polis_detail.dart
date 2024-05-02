import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/customer_controller.dart';
import 'package:insurance/bloc/login_controller.dart';
import 'package:insurance/bloc/polis_controller.dart';
import 'package:insurance/bloc/ternak_controller.dart';
import 'package:intl/intl.dart';

class PolisDetail extends StatelessWidget {
  const PolisDetail({super.key});

  @override
  Widget build(BuildContext context) {
    String polisId = Get.arguments['polisId'];

    PolisController polisController = Get.find();
    //CustomerController custController = Get.find();
    LoginController loginController = Get.find();

    polisController.getPolisWithPolisId(polisId);
    polisController.ternakController.getTernakWithPolisId(polisId);

    return Scaffold(
      appBar: AppBar(title: Text('Detil Polis'), actions: [
        Container(
          height: 90,
          margin: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${loginController.check.value.userData.name}',
                  style: Get.textTheme.labelSmall),
              Text(' - ${loginController.check.value.roles}',
                  style: Get.textTheme.labelSmall)
            ],
          ),
        ),
      ]),
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 20),
            // polis header info
            Obx(
              () => polisController.thePolisLoaded.value
                  ? Container(
                      height: 45,
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration:
                          BoxDecoration(color: Get.theme.colorScheme.surface),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'PolisNo : ${polisController.thePolis.value.polisDocId}',
                              style: Get.theme.textTheme.bodyLarge),
                          Text(
                              'Tanggal : ${polisController.thePolis.value.tglPolis}'),
                          // Text(
                          //     'Penerbit : ${polisController.thePolis.value.kantorCabang}'),
                          Text(
                            'Status : ${polisController.polisStatusDesc(polisController.thePolis.value.statusPolis)}',
                            style: TextStyle(
                                color: Get.theme.colorScheme.secondary),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
            SizedBox(height: 20),
            // pertanggungan
            Obx(
              () => polisController.thePolisLoaded.value
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Wrap(
                        spacing: 25,
                        runSpacing: 15,
                        children: [
                          Text(
                              'Produk:  ${polisController.thePolis.value.produkName}'),
                          Text(
                              'Asuransi:  ${polisController.thePolis.value.namaAsuransi}'),
                          // Text(
                          //     'Pertanggungan : Rp. ${NumberFormat("#,###,###,###", "en_US").format(polisController.thePolis.value.nilaiPertanggunganSppa)}'),
                        ],
                      ),
                    )
                  : Container(),
            ),
            SizedBox(height: 20),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Ternak Sapi',
                  style: Get.theme.textTheme.bodyLarge
                      ?.copyWith(color: Get.theme.colorScheme.secondary),
                )),
            Obx(
              () => polisController.ternakController.listTernak.isNotEmpty
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: polisController.ternakController.listTernak
                            .map((et) => Container(
                                padding: EdgeInsets.all(8),
                                child: Wrap(spacing: 10, children: [
                                  Text('Ear Tag: ${et.earTag}'),
                                  Text(
                                      'Jenis/Kelamin: ${et.jenis}/${et.kelamin}'),
                                  Text(
                                      'Nilai Pertanggungan: Rp. ${NumberFormat("#,###,###,###", "en_US").format(et.nilaiPertanggungan)}')
                                ])))
                            .toList(),
                      ),
                    )
                  : Container(),
            ),
            //TODO tambahkan info ternak atau button untuk lihat daftar ternak
            SizedBox(height: 20),

            // premi
            Obx(
              () => polisController.thePolisLoaded.value
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Wrap(
                        spacing: 25,
                        runSpacing: 15,
                        children: [
                          Text(
                              'Total Nilai Pertanggungan:  Rp. ${NumberFormat("#,###,###,###", "en_US").format(polisController.thePolis.value.nilaiPertanggunganSppa)}'),
                          Text(
                              'Nilai Premi:  Rp. ${NumberFormat("#,###,###,###", "en_US").format(polisController.thePolis.value.premiAmount)}'),
                          Text(
                              'Biaya Admin:  Rp. ${NumberFormat("#,###,###,###", "en_US").format(polisController.thePolis.value.biayaAdministrasi)}'),
                          Text(
                              'Bea Meterai:  Rp. ${NumberFormat("#,###,###,###", "en_US").format(polisController.thePolis.value.beaMaterei)}'),
                          Text(
                              'Total:  Rp. ${NumberFormat("#,###,###,###", "en_US").format(polisController.totalBiaya.value)}'),
                        ],
                      ),
                    )
                  : Container(),
            ),
            SizedBox(height: 20),

            // masa berlaku
            Obx(
              () => polisController.thePolisLoaded.value
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: [
                          Text(
                              'Jangka Pertanggungan:  dari ${polisController.thePolis.value.tglAwalPolis}'),
                          Text(
                              ' sampai ${polisController.thePolis.value.tglAkhirPolis}'),
                        ],
                      ),
                    )
                  : Container(),
            ),
            SizedBox(height: 30),
            Obx(
              () {
                polisController.cekPolisBtnVisible();
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Edit
                      Visibility(
                        visible: polisController.editBtnVis.value,
                        child: ElevatedButton(
                            onPressed: () async {
                              // polisController.editPolis();
                              print('edit polis');
                            },
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      // tagih
                      Visibility(
                        // Batal
                        visible: polisController.tagihBtnVis.value,
                        child: ElevatedButton(
                            onPressed: () async {
                              // TODO  polisController.confirmTagihDialog();
                              print('tagih');
                            },
                            child: Text(
                              'Tagih',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      // bayar
                      Visibility(
                        // Batal
                        visible: polisController.bayarBtnVis.value,
                        child: ElevatedButton(
                            onPressed: () async {
                              // TODO  Get.toNamed('/polis/bayar');
                              print('Bayar');
                            },
                            child: Text(
                              'Bayar',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      // problem Pembayaran
                      Visibility(
                        // Batal
                        visible: polisController.probBtnVis.value,
                        child: ElevatedButton(
                            onPressed: () async {
                              // TODO  Get.toNamed('/polis/problem');
                              print('Pembayaran Bermasalah');
                            },
                            child: Text(
                              'Pembayaran Bermasalah',
                              style: TextStyle(color: Colors.red),
                            )),
                      ),
                      // Aktifasi
                      Visibility(
                        // Batal
                        visible: polisController.aktifBtnVis.value,
                        child: ElevatedButton(
                            onPressed: () async {
                              // TODO  Get.toNamed('/polis/aktifasi');
                              print('Aktifasi');
                            },
                            child: Text(
                              'Aktifasi',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ]);
              },
            )
          ]),
        ),
      )),
    );
  }
}
