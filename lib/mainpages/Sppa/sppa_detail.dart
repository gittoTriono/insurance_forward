import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/customer_controller.dart';
import 'package:insurance/bloc/dashboard_controller.dart';
import 'package:insurance/bloc/login_controller.dart';
import 'package:insurance/bloc/polis_controller.dart';
import 'package:insurance/bloc/produk_controller.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/bloc/ternak_controller.dart';
import 'package:insurance/model/sppa_header.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class SppaDetail extends StatelessWidget {
  const SppaDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final thisSppaId = Get.arguments['sppaId'];

    DashboardController controller;
    controller = Get.find<DashboardController>();

    SppaHeaderController sppaController = Get.find<SppaHeaderController>();

    // TODO buat apa ini?
    thisSppaId == ''
        ? sppaController.isNewSppa.value = true
        : sppaController.isNewSppa.value = false;

    // load other controllers
    TernakController aTernakController = Get.put(TernakController());
    CustomerController custController = Get.put(CustomerController());
    ProdukController prodController = Get.find<ProdukController>();

    // print('set sppa Header');

    sppaController.getSppaHeaderWithSppaId(thisSppaId);

    Future.delayed(Duration(milliseconds: 300), () {
      print(
          ' sppa Header for $thisSppaId get ${sppaController.sppaHeader.value.id}');
      sppaController.getSppaStatusWithSppaId(thisSppaId);
      // print('sppa status ${sppaController.sppaStatus.id}');

      custController
          .getSppaCustomer(sppaController.sppaHeader.value.customerId!);
      prodController
          .getProdukAsuransi(sppaController.sppaHeader.value.produkCode!);
      sppaController.getPerluasanRisikoSppa();
      aTernakController.loadTernak(sppaController.sppaHeader.value.id!);
      sppaController.loadInfoData(sppaController.sppaHeader.value.id!);
    });

    // print('done setting detail sppaPage');
    return Scaffold(
      appBar: AppBar(title: Text('Detil Sppa'), actions: [
        Container(
          height: 90,
          margin: EdgeInsets.all(16),
          child: Text(
              '${controller.loginController.check.value.userData.name} - ${controller.loginController.check.value.roles}',
              style: Get.textTheme.labelSmall!.copyWith(color: Colors.white)),
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
              SizedBox(height: 15),
              Container(
                  height: 45,
                  decoration:
                      BoxDecoration(color: Get.theme.colorScheme.surface),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5),
                    child: Obx(
                      () => sppaController.sppaLoaded.value
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    TextTitleMedium('Sppa ${thisSppaId}'),
                                    sppaController
                                            .sppaHeader.value.sppaId!.isNotEmpty
                                        ? TextTitleMedium(
                                            ' / No ${sppaController.sppaHeader.value.sppaId!}')
                                        : Container(),
                                  ],
                                ),
                                sppaController
                                        .sppaStatus.value.initSubmitDt.isEmpty
                                    ? TextTitleMedium(
                                        'Dibuat ${sppaController.sppaStatus.value.tglCreated}')
                                    : TextTitleMedium(
                                        'Tanggal ${sppaController.sppaStatus.value.initSubmitDt}'),
                                Obx(() => TextButton(
                                      onPressed: () {
                                        sppaController.dialogRiwayat();
                                      },
                                      child: Text(
                                          '${sppaController.sppaStatusDesc(sppaController.sppaStatusDisp.value)}',
                                          style: Get.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: Get.theme.colorScheme
                                                      .secondary)),
                                    )),
                              ],
                            )
                          : Container(),
                    ),
                  )),
              Obx(() => custController.custIsLoaded.value
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5),
                      child: Row(children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextBodyMedium(
                                    '${custController.theCustomer.value.name}'),
                                TextBodyMedium(
                                    '${custController.theCustomer.value.chain}'),
                                TextBodyMedium(
                                    'Telp ${custController.theCustomer.value.noHp}'),
                                TextBodyMedium(
                                    'Email ${custController.theCustomer.value.email}')
                              ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextBodyMedium(
                                    '${custController.theCustomer.value.jalan}'),
                                TextBodyMedium(
                                    '${custController.theCustomer.value.rt} / ${custController.theCustomer.value.rw}'),
                                TextBodyMedium(
                                    '${custController.theCustomer.value.kelurahan}, ${custController.theCustomer.value.kecamatan}'),
                                TextBodyMedium(
                                    '${custController.theCustomer.value.kabupaten}'),
                                TextBodyMedium(
                                    'Kode Pos ${custController.theCustomer.value.kodePos}'),
                              ]),
                        ),
                      ]))
                  : Container()),
              SizedBox(height: 15),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${sppaController.sppaHeader.value.produkName} ',
                                    style: TextStyle(
                                        color:
                                            Get.theme.colorScheme.secondary)),
                                Text(
                                    '${sppaController.sppaHeader.value.asuransiName} ')
                              ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    TextBodySmall('Tenor'),
                                    TextBodyMedium(
                                        '${sppaController.sppaHeader.value.tenor} bulan')
                                  ],
                                ),
                                Obx(
                                  () => Column(
                                    children: [
                                      TextBodySmall('Rate Dasar'),
                                      TextBodyMedium(prodController
                                              .selectedIsLoaded.value
                                          ? '${(prodController.selected.value.ratePremi! * 100).toStringAsFixed(2)} %'
                                          : '%'),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ]),
                ),
              ),
              SizedBox(height: 10),
              Obx(
                () => sppaController.listPerluasanRisikoSppa.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 10),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: TextBodySmall('Perluasan Risiko')),
                            Expanded(flex: 1, child: TextBodySmall('Rate')),
                          ],
                        ),
                      )
                    : Text(''),
              ),
              Obx(
                () => sppaController.listPerluasanRisikoSppaLoaded.value &&
                        sppaController.listPerluasanRisikoSppa.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 40, right: 10.0),
                        child: Wrap(
                            spacing: 20,
                            runSpacing: 5,
                            children: sppaController.listPerluasanRisikoSppa
                                .map(
                                  (pr) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(pr.namaPerluasanRisiko!),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                              '${(pr.rate! * 100).toStringAsFixed(3)} %',
                                              textAlign: TextAlign.start),
                                        ),
                                      ]),
                                )
                                .toList()),
                      )
                    : Container(),
              ),
              SizedBox(height: 10),
              Obx(
                () => sppaController.totPertanggungan.value > 0
                    ? Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Total Pertanggungan',
                                        style: Get.theme.textTheme.bodySmall!
                                            .copyWith(
                                                color: Get.theme.colorScheme
                                                    .secondary)),
                                    Text(
                                        'Rp.  ${NumberFormat("#,###,###,###", "en_US").format(sppaController.sppaHeader.value.nilaiPertanggungan!)}',
                                        style: Get.theme.textTheme.bodyMedium),
                                  ]),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Total Rate',
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(
                                              color: Get.theme.colorScheme
                                                  .secondary)),
                                  Text(
                                      '${(sppaController.sppaHeader.value.premiRate! * 100).toStringAsFixed(3)} %')
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Premi',
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(
                                              color: Get.theme.colorScheme
                                                  .secondary)),
                                  TextBodyMedium(
                                      'Rp. ${NumberFormat("#,###,###,###", "en_US").format(sppaController.sppaHeader.value.premiAmount!).toString()}')
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
              ),
              SizedBox(height: 10),
              Obx(
                () => sppaController.nilaiAnakan.value > 0
                    ? Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Pertanggungan Anakan',
                                        style: Get.theme.textTheme.bodySmall!
                                            .copyWith(
                                                color: Get.theme.colorScheme
                                                    .secondary)),
                                    TextBodyMedium(
                                        'Rp.  ${NumberFormat("#,###,###,###", "en_US").format(sppaController.nilaiAnakan.value)}'),
                                  ]),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Rate',
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(
                                              color: Get.theme.colorScheme
                                                  .secondary)),
                                  Text(
                                      '${(sppaController.rateAnakan * 100).toStringAsFixed(3)} %')
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Premi Anakan',
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(
                                              color: Get.theme.colorScheme
                                                  .secondary)),
                                  TextBodyMedium(
                                      'Rp. ${NumberFormat("#,###,###,###", "en_US").format(sppaController.premiAnakan)}')
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              Obx(
                () => sppaController.nilaiAnakan.value > 0
                    ? Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(''),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text('Total Premi'),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                  'Rp. ${NumberFormat("#,###,###,###", "en_US").format(sppaController.sppaHeader.value.premiAmount! + sppaController.premiAnakan)}',
                                  style: TextStyle(
                                      color: Get.theme.colorScheme.secondary)),
                            )
                          ],
                        ),
                      )
                    : Container(),
              ),
              SizedBox(height: 10),
              Container(
                  width: Get.width,
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration:
                      BoxDecoration(color: Get.theme.colorScheme.surface),
                  child: TextTitleMedium('Info Operasional')),
              SizedBox(height: 10),
              Obx(
                () => sppaController.infoAtsLoaded.value
                    ? Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Obx(
                          () => Wrap(
                            spacing: 15,
                            runSpacing: 15,
                            children: [
                              Container(
                                width: Get.width,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child:
                                              TextBodyMedium('Lokasi Kandang')),
                                      Expanded(
                                          flex: 2,
                                          child: TextBodyMedium(
                                              '${sppaController.infoAts.value.lokasiKandang} '))
                                    ]),
                              ),
                              // Container(
                              //   width: Get.width,
                              //   child: Row(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children: [
                              //         Expanded(
                              //             flex: 1,
                              //             child: TextBodyMedium('Management Kandang')),
                              //         Expanded(
                              //             flex: 2,
                              //             child: TextBodyMedium(
                              //                 '${sppaController.infoAts.value.infoMgmtKandang} '))
                              //       ]),
                              // ),
                              Container(
                                width: Get.width,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: TextBodyMedium(
                                              'Kriteria Pemeliharaan')),
                                      Expanded(
                                          flex: 2,
                                          child: TextBodyMedium(
                                              '${sppaController.infoAts.value.kriteriaPemeliharaan} '))
                                    ]),
                              ),
                              Container(
                                width: Get.width,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child:
                                              TextBodyMedium('Sistem Pakan')),
                                      Expanded(
                                          flex: 2,
                                          child: TextBodyMedium(
                                              '${sppaController.infoAts.value.sistemPakanTernak} '))
                                    ]),
                              ),
                              // // Container(
                              // //   width: Get.width,
                              // //   child: Row(
                              // //       crossAxisAlignment: CrossAxisAlignment.start,
                              // //       children: [
                              // //         Expanded(
                              // //             flex: 1,
                              // //             child: TextBodyMedium('Management Pakan')),
                              // //         Expanded(
                              // //             flex: 2,
                              // //             child: TextBodyMedium(
                              // //                 '${sppaController.infoAts.value.infoMgmtPakan} '))
                              // //       ]),
                              // // ),
                              // Container(
                              //   width: Get.width,
                              //   child: Row(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children: [
                              //         Expanded(
                              //             flex: 1,
                              //             child:
                              //                 TextBodyMedium('Management Kesehatan')),
                              //         Expanded(
                              //             flex: 2,
                              //             child: TextBodyMedium(
                              //                 '${sppaController.infoAts.value.infoMgmtKesehatan} '))
                              //       ]),
                              // ),
                              SizedBox(height: 20)
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ),
              Container(
                  width: Get.width,
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration:
                      BoxDecoration(color: Get.theme.colorScheme.surface),
                  child: TextTitleMedium('Daftar Ternak')),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Obx(
                  () => Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    //                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: aTernakController.listTernak
                        .map(
                          (e) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.3,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextTitleMedium('Ear Tag ${e.earTag}'),
                                      TextBodyMedium(
                                          '${e.jenis} / ${e.kelamin}'),
                                    ]),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // TextBodyMedium(
                                      //     'Nilai Perolehan Rp. ${NumberFormat("#,###,###,###", "en_US").format(e.hargaPerolehan).toString()}'),
                                      TextBodyMedium('tgl lahir ${e.tglLahir}'),
                                      TextBodyMedium(
                                          'Harga Pertanggungan Rp. ${NumberFormat("#,###,###,###", "en_US").format(e.nilaiPertanggungan).toString()}'),
                                    ]),
                                Icon(
                                  Icons.photo,
                                  size: 50,
                                  color: Get.theme.colorScheme.secondary,
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: Get.width,
                height: 20,
                decoration: BoxDecoration(color: Get.theme.colorScheme.surface),
              ),
              SizedBox(height: 20),
              Obx(
                () {
                  sppaController.cekSppaBtnVisible();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Tolak
                      Visibility(
                        visible: sppaController.tolakBtnVis.value,
                        child: ElevatedButton(
                            onPressed: () async {
                              // async {
                              // var res = await Get.to(() => B());
                              // // refresh A Page
                              // if (res != null && res == true)
                              // controller.refresh();
                              sppaController.confirmTolakDialog(
                                  sppaController.sppaHeader.value.statusSppa!);
                              if (sppaController.jadiTolak.value) {
                                controller.listAktifSppa.removeWhere(
                                    (element) =>
                                        element.id ==
                                        sppaController.sppaHeader.value.id);
                                // controller.refresh();
                                // sppaController.refresh();
                              }
                            },
                            child: Text(
                              'Tolak',
                              style: TextStyle(color: Colors.red),
                            )),
                      ),
                      Visibility(
                        // Batal
                        visible: sppaController.batalBtnVis.value,
                        child: ElevatedButton(
                            onPressed: () async {
                              // async {
                              // var res = await Get.to(() => B());
                              // // refresh A Page
                              // if (res != null && res == true)
                              // controller.refresh();
                              sppaController.confirmBatalDialog(
                                  sppaController.sppaHeader.value.statusSppa!);
                            },
                            child: Text(
                              'Batal',
                              style: TextStyle(color: Colors.red),
                            )),
                      ),
                      Visibility(
                        // Edit
                        visible: sppaController.editBtnVis.value,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/sppa/main', arguments: {
                              'sppaId': thisSppaId,
                              'prodId':
                                  sppaController.sppaHeader.value.produkCode
                            });
                          },
                          child: Text('Edit',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Visibility(
                        // Submit
                        visible: sppaController.submitBtnVis.value,
                        child: ElevatedButton(
                          onPressed: () {
                            sppaController.confirmSubmitDialog(
                                sppaController.sppaHeader.value.statusSppa!);
                          },
                          child: Text('Submit',
                              style: TextStyle(color: Colors.yellow)),
                        ),
                      ),
                      Visibility(
                        // Accept
                        visible: sppaController.acceptBtnVis.value,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.put(PolisController());
                            Get.toNamed('/polis/main', arguments: {
                              'type': 'new',
                              'sppaId': sppaController.sppaHeader.value.id
                            });
                          },
                          child: Text('Accept',
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  );
                },
              ),
              SizedBox(height: 20)
            ]),
          ),
        ),
      ),
    );
  }
}
