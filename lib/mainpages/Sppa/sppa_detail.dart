import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/customer_controller.dart';
import 'package:insurance/bloc/dashboard_controller.dart';
import 'package:insurance/bloc/sppa_addinfo_controller.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/bloc/ternak_controller.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class SppaDetail extends StatelessWidget {
  const SppaDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final thisSppaId = Get.arguments['sppaId'];
    DashboardController controller = Get.find<DashboardController>();
    SppaHeaderController sppaController = Get.put(SppaHeaderController());
    thisSppaId == ''
        ? sppaController.isNewSppa.value = true
        : sppaController.isNewSppa.value = false;

    // load other controllers
    SppaAddInfoController infoController = Get.put(SppaAddInfoController());
    TernakController aTernakController = Get.put(TernakController());
    CustomerController custController = Get.put(CustomerController());

    // init sppaHeader & sppaStatus from dashboard ONLY!!!
    sppaController.sppaHeader = controller.listAktifSppa
        .firstWhere((element) => element.id == thisSppaId);
    sppaController.sppaStatus = controller.listAktifSppaStatus.value
        .firstWhere((element) => element.sppaId == thisSppaId);

    sppaController.isNewSppa.value = false;

    // load sppaInfo and Ternak into this controller
    aTernakController.loadTernak(sppaController.sppaHeader.id!);
    infoController.loadInfoData(sppaController.sppaHeader.id!);
    custController.getSppaCustomer(sppaController.sppaHeader.customerId!);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detil Sppa'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 15),
              Container(
                  height: 30,
                  decoration:
                      BoxDecoration(color: Get.theme.colorScheme.surface),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextBodyMedium('Sppa Id ${thisSppaId}'),
                        TextBodyMedium(
                            'Tanggal ${sppaController.sppaStatus.tglCreated}'),
                        Row(
                          children: [
                            TextBodyMedium(
                                '${sppaController.sppaStatusDesc(sppaController.sppaStatus.statusSppa!)} '),
                            TextButton(
                              onPressed: () {},
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
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${sppaController.sppaHeader.produkName} '),
                            Text('${sppaController.sppaHeader.asuransiName} ')
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextBodySmall('Rate'),
                            TextBodyMedium(
                                '${(sppaController.sppaHeader.premiRate! * 100).toStringAsFixed(2)} %'),
                            TextBodySmall('Tenor'),
                            TextBodyMedium(
                                '${sppaController.sppaHeader.tenor} bulan')
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextBodySmall('Total Pertanggungan'),
                            TextBodyMedium(
                                'Rp. ${NumberFormat("#,###,###,###", "en_US").format(sppaController.sppaHeader.nilaiPertanggungan!).toString()}'),
                            TextBodySmall('Total Premi'),
                            TextBodyMedium(
                                'Rp. ${NumberFormat("#,###,###,###", "en_US").format(sppaController.sppaHeader.nilaiPertanggungan!).toString()}')
                          ]),
                    ]),
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
                                      '${infoController.infoAts.value.lokasiKandang} '))
                            ]),
                      ),
                      Container(
                        width: Get.width,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: TextBodyMedium('Management Kandang')),
                              Expanded(
                                  flex: 2,
                                  child: TextBodyMedium(
                                      '${infoController.infoAts.value.infoMgmtKandang} '))
                            ]),
                      ),
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
                                      '${infoController.infoAts.value.kriteriaPemeliharaan} '))
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
                                      '${infoController.infoAts.value.sistemPakanTernak} '))
                            ]),
                      ),
                      Container(
                        width: Get.width,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: TextBodyMedium('Management Pakan')),
                              Expanded(
                                  flex: 2,
                                  child: TextBodyMedium(
                                      '${infoController.infoAts.value.infoMgmtPakan} '))
                            ]),
                      ),
                      Container(
                        width: Get.width,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child:
                                      TextBodyMedium('Management Kesehatan')),
                              Expanded(
                                  flex: 2,
                                  child: TextBodyMedium(
                                      '${infoController.infoAts.value.infoMgmtKesehatan} '))
                            ]),
                      ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/sppa/batal',
                            arguments: {'sppaId': thisSppaId});
                      },
                      child: Text(
                        'Batal',
                        style: TextStyle(color: Colors.red),
                      )),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/sppa/main',
                          arguments: {'sppaId': thisSppaId});
                    },
                    child: Text('Edit', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/sppa/submit',
                          arguments: {'sppaId': thisSppaId});
                    },
                    child:
                        Text('Submit', style: TextStyle(color: Colors.yellow)),
                  )
                ],
              ),
              SizedBox(height: 20)
            ]),
          ),
        ),
      ),
    );
  }
}
