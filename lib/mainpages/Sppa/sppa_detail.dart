import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/customer_controller.dart';
import 'package:insurance/bloc/dashboard_controller.dart';
import 'package:insurance/bloc/login_controller.dart';
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

    thisSppaId == ''
        ? sppaController.isNewSppa.value = true
        : sppaController.isNewSppa.value = false;

    // load other controllers
    TernakController aTernakController = Get.put(TernakController());
    CustomerController custController = Get.put(CustomerController());
    ProdukController prodController = Get.find<ProdukController>();

    // init sppaHeader & sppaStatus from dashboard ONLY!!!
    // print('sppa header ada : ${controller.listAktifSppa.length}');
    // print('sppa status ada : ${controller.listAktifSppaStatus.length}');
    // print('set sppa Header');
    sppaController.sppaHeader = controller.listAktifSppa
        .firstWhere((element) => element.id == thisSppaId);
    // print(' sppa Header ${sppaController.sppaHeader.id}');

    // print('set sppa status');
    sppaController.sppaStatus = controller.listAktifSppaStatus
        .firstWhere((element) => element.sppaId == thisSppaId);
    // print('sppa status ${sppaController.sppaStatus.id}');
    sppaController.sppaHeaderStatusObs.value =
        sppaController.sppaHeader.statusSppa!; // for managing display
    // print(
    //     'set sppaHeaderStatusObs ${sppaController.sppaHeaderStatusObs.value} ');

    // load sppaInfo and Ternak into this controller
    custController.getSppaCustomer(sppaController.sppaHeader.customerId!);
    prodController.getProdukAsuransi(sppaController.sppaHeader.produkCode!);
    sppaController.getPerluasanRisikoSppa();
    aTernakController.loadTernak(sppaController.sppaHeader.id!);
    sppaController.loadInfoData(sppaController.sppaHeader.id!);

    // print('done setting detail sppaPage');
    return Scaffold(
      appBar: AppBar(
        title: Text('Detil Sppa'),
      ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextTitleMedium('Sppa Id ${thisSppaId}'),
                        TextTitleMedium(
                            'Tanggal ${sppaController.sppaStatus.tglCreated}'),
                        Row(
                          children: [
                            Obx(
                              () => Text(
                                  '${sppaController.sppaStatusDesc(sppaController.sppaHeaderStatusObs.value)}',
                                  style: Get.theme.textTheme.bodyMedium!
                                      .copyWith(
                                          color: sppaController
                                                      .sppaHeaderStatusObs
                                                      .value ==
                                                  3
                                              ? Get.theme.colorScheme.error
                                              : Get.theme.colorScheme.primary)),
                            ),
                            TextButton(
                              onPressed: () {
                                sppaController.dialogRiwayat();
                              },
                              child: Text('lihat detail',
                                  style: Get.textTheme.bodySmall!.copyWith(
                                      color: Get.theme.colorScheme.secondary)),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
              Obx(() => custController.isLoaded.value
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
                                    '${custController.theCustomer.value.fullName}'),
                                TextBodyMedium(
                                    '${custController.theCustomer.value.salesId}'),
                                TextBodyMedium(
                                    'Telp ${custController.theCustomer.value.noTelp}'),
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
                                    '${custController.theCustomer.value.alamat!.jalan}'),
                                TextBodyMedium(
                                    '${custController.theCustomer.value.alamat!.rt} / ${custController.theCustomer.value.alamat!.rw}'),
                                TextBodyMedium(
                                    '${custController.theCustomer.value.alamat!.kelurahan}, ${custController.theCustomer.value.alamat!.kecamatan}'),
                                TextBodyMedium(custController.theCustomer.value
                                            .alamat!.tipeDati2 ==
                                        'Kota'
                                    ? '${custController.theCustomer.value.alamat!.namaDati2}'
                                    : '${custController.theCustomer.value.alamat!.kota}, ${custController.theCustomer.value.alamat!.namaDati2}'),
                                TextBodyMedium(
                                    'Kode Pos ${custController.theCustomer.value.alamat!.kodePos}'),
                              ]),
                        ),
                      ]))
                  : Container()),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${sppaController.sppaHeader.produkName} '),
                              Text('${sppaController.sppaHeader.asuransiName} ')
                            ]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  TextBodySmall('Tenor'),
                                  TextBodyMedium(
                                      '${sppaController.sppaHeader.tenor} bulan')
                                ],
                              ),
                              Obx(
                                () => Column(
                                  children: [
                                    TextBodySmall('Rate'),
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
              SizedBox(height: 10),
              Obx(
                () => sppaController.listPerluasanRisikoSppa.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 10),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
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
                            runSpacing: 10,
                            children: sppaController.listPerluasanRisikoSppa
                                .map(
                                  (pr) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(pr.namaPerluasanRisiko!),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                              '${(pr.rate! * 100).toStringAsFixed(3)} %',
                                              textAlign: TextAlign.end),
                                        ),
                                      ]),
                                )
                                .toList()),
                      )
                    : Container(),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBodySmall('Total Pertanggungan'),
                          TextBodyMedium(
                              'Rp.  ${NumberFormat("#,###,###,###", "en_US").format(sppaController.sppaHeader.nilaiPertanggungan!).toString()}'),
                        ]),
                    Column(
                      children: [
                        TextBodySmall('Total Rate'),
                        Text(
                            '${(sppaController.sppaHeader.premiRate! * 100).toStringAsFixed(3)} %')
                      ],
                    ),
                    Column(
                      children: [
                        TextBodySmall('Total Premi'),
                        TextBodyMedium(
                            'Rp. ${NumberFormat("#,###,###,###", "en_US").format(sppaController.sppaHeader.premiAmount!).toString()}')
                      ],
                    )
                  ],
                ),
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
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Obx(
                  () => Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      Container(
                        width: Get.width,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: TextBodyMedium('Lokasi Kandang')),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child:
                                      TextBodyMedium('Kriteria Pemeliharaan')),
                              Expanded(
                                  flex: 2,
                                  child: TextBodyMedium(
                                      '${sppaController.infoAts.value.kriteriaPemeliharaan} '))
                            ]),
                      ),
                      Container(
                        width: Get.width,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: TextBodyMedium('Sistem Pakan')),
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
                    children: aTernakController.listTernak.value
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
                                      TextBodyMedium('tgl lahir ${e.tglLahir}')
                                    ]),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextBodyMedium(
                                          'Nilai Perolehan Rp. ${NumberFormat("#,###,###,###", "en_US").format(e.hargaPerolehan).toString()}'),
                                      TextBodyMedium(
                                          'Nilai Pertanggungan Rp. ${NumberFormat("#,###,###,###", "en_US").format(e.nilaiPertanggungan).toString()}'),
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
                  sppaController.cekBtnVisible();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                                  sppaController.sppaHeader.statusSppa!);
                              if (sppaController.jadiTolak.value) {
                                controller.listAktifSppa.value.removeWhere(
                                    (element) =>
                                        element.id ==
                                        sppaController.sppaHeader.id);
                                controller.refresh();
                                sppaController.refresh();
                              }
                            },
                            child: Text(
                              'Tolak',
                              style: TextStyle(color: Colors.red),
                            )),
                      ),
                      Visibility(
                        visible: sppaController.batalBtnVis.value,
                        child: ElevatedButton(
                            onPressed: () async {
                              // async {
                              // var res = await Get.to(() => B());
                              // // refresh A Page
                              // if (res != null && res == true)
                              // controller.refresh();
                              sppaController.confirmBatalDialog(
                                  sppaController.sppaHeader.statusSppa!);
                            },
                            child: Text(
                              'Batal',
                              style: TextStyle(color: Colors.red),
                            )),
                      ),
                      Visibility(
                        visible: sppaController.editBtnVis.value,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/sppa/main',
                                arguments: {'sppaId': thisSppaId});
                          },
                          child: Text('Edit',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Visibility(
                        visible: sppaController.submitBtnVis.value,
                        child: ElevatedButton(
                          onPressed: () {
                            sppaController.confirmSubmitDialog(
                                sppaController.sppaHeader.statusSppa!);
                          },
                          child: Text('Submit',
                              style: TextStyle(color: Colors.yellow)),
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
