import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/customer_controller.dart';
import 'package:insurance/bloc/login_controller.dart';
import 'package:insurance/bloc/polis_controller.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/bloc/ternak_controller.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:intl/intl.dart';

class PolisMaintenance extends StatelessWidget {
  const PolisMaintenance({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find();
    SppaHeaderController sppaController = Get.find();
    PolisController polisController = Get.find();
    TernakController ternakController = Get.find();

    final opType = Get.arguments['type'];
    switch (opType) {
      case 'new':
        final sppaId = Get.arguments['sppaId'];
        print('pos 1');
        sppaController.getSppaHeaderWithSppaId(sppaId);
        print('pos 2');
        Future.delayed(Duration(milliseconds: 300), () {
          print(
              'go get the customer :${sppaController.sppaHeader.value.customerId!}');
          polisController.custController
              .getSppaCustomer(sppaController.sppaHeader.value.customerId!);
        });
        print('pos 3');
        Future.delayed(Duration(milliseconds: 300), () {
          ternakController.loadTernak(sppaId);
        });
        print('pos 4');
        Future.delayed(Duration(milliseconds: 300), () {
          sppaController.getPerluasanRisikoSppa();
        });
        print('pos 5');
        Future.delayed(Duration(milliseconds: 300), () {
          polisController.copyFromSppa();
        });
        print('pos 6');
        //polisController.makeEdit.value = true;
        break;
      case 'edit':
        final polisId = Get.arguments['polisId'];
        final sppaId = Get.arguments['sppaId'];
        sppaController.getSppaHeaderWithSppaId(sppaId);
        polisController.getPolisWithPolisId(polisId);
        Future.delayed(Duration(milliseconds: 300), () {
          print(
              'go get the customer :${sppaController.sppaHeader.value.customerId!}');
          polisController.custController
              .getSppaCustomer(sppaController.sppaHeader.value.customerId!);
        });
        Future.delayed(Duration(milliseconds: 300), () {
          ternakController.loadTernak(sppaId);
        });
        Future.delayed(Duration(milliseconds: 300), () {
          sppaController.getPerluasanRisikoSppa();
        });
        Future.delayed(Duration(milliseconds: 300), () {
          polisController.copyFromSppa();
        });
        break;
    }

    return Scaffold(
        appBar: AppBar(title: Text('Polis Maintenance'), actions: [
          Container(
            height: 90,
            margin: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${loginController.check.value.userData.name}',
                    style: Get.textTheme.labelSmall),
                // Text(
                //     '${controller.loginController.check.value.userData.userId}',
                //     style: Get.textTheme.labelSmall),
                Text(' - ${loginController.check.value.roles}',
                    style:
                        Get.textTheme.labelSmall!.copyWith(color: Colors.white))
              ],
            ),
          ),
        ]),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              Container(
                width: 0.95 * Get.width,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(width: 0.25, color: Colors.black26),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      width: formWidth2(Get.width),
                      child: Row(
                        children: [
                          Text(
                              'Info Utama Sppa ${sppaController.sppaHeader.value.id}',
                              textAlign: TextAlign.center,
                              style: Get.theme.textTheme.headlineSmall!
                                  .copyWith(
                                      color: Get.theme.colorScheme.secondary)),
                          sppaController.sppaHeader.value.sppaId!.isNotEmpty
                              ? Text(
                                  ' - No ${sppaController.sppaHeader.value.sppaId!}')
                              : Container()
                        ],
                      )),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 15,
                    runSpacing: 20,
                    children: [
                      Obx(() => polisController
                              .custController.custIsLoaded.value
                          ? Container(
                              width: 250,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Detil Customer',
                                        style: Get.theme.textTheme.bodyMedium!
                                            .copyWith(
                                                color: Get.theme.colorScheme
                                                    .secondary)),
                                    Text(
                                        '${polisController.custController.theCustomer.value.name}'),
                                    Text(
                                        '${polisController.custController.theCustomer.value.chain} / ${polisController.custController.theCustomer.value.noAnggota}'),
                                    Text(
                                        'Telp ${polisController.custController.theCustomer.value.noHp}'),
                                    Text(
                                        'Email ${polisController.custController.theCustomer.value.email}')
                                  ]),
                            )
                          : Container()),
                      Obx(() => polisController
                              .custController.custIsLoaded.value
                          ? Container(
                              width: 250,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Alamat',
                                        style: Get.theme.textTheme.bodyMedium!
                                            .copyWith(
                                                color: Get.theme.colorScheme
                                                    .secondary)),
                                    Text(
                                        '${polisController.custController.theCustomer.value.jalan}'),
                                    Text(
                                        'RT ${polisController.custController.theCustomer.value.rt} / RW ${polisController.custController.theCustomer.value.rw}'),
                                    Text(
                                        '${polisController.custController.theCustomer.value.kelurahan}, ${polisController.custController.theCustomer.value.kecamatan}'),
                                    Text(
                                        '${polisController.custController.theCustomer.value.kabupaten}'),
                                    Text(
                                        'Kode Pos ${polisController.custController.theCustomer.value.kodePos}'),
                                  ]),
                            )
                          : Container()),
                      Container(
                        width: 250,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Product',
                                  style: Get.theme.textTheme.bodyMedium!
                                      .copyWith(
                                          color:
                                              Get.theme.colorScheme.secondary)),
                              Text(
                                  '${sppaController.sppaHeader.value.produkName}'),
                              Text(
                                  'Pertanggungan : Rp. ${NumberFormat("#,###,###,###", "en_US").format(sppaController.sppaHeader.value.nilaiPertanggungan)}'),
                              Text('Rate: ${(sppaController.sppaHeader.value.premiRate! * 100).toStringAsFixed(3)} % -' +
                                  ' Tenor: ${sppaController.sppaHeader.value.tenor!} bulan'),
                              Text(
                                  'Premi: Rp. ${NumberFormat("#,###,###,###", "en_US").format(sppaController.sppaHeader.value.premiAmount)}'),
                            ]),
                      ),
                      Obx(() => sppaController.nilaiAnakan.value > 0
                          ? Column(
                              children: [
                                Text('Anakan',
                                    style: Get.theme.textTheme.bodyMedium!
                                        .copyWith(
                                            color: Get
                                                .theme.colorScheme.secondary)),
                                Text(
                                    'Nilai Anakan: Rp. ${NumberFormat("#,###,###,###", "en_US").format(sppaController.nilaiAnakan.value)}'),
                                Text(
                                    'Premi Anakan: Rp. ${NumberFormat("#,###,###,###", "en_US").format(sppaController.premiAnakan)}'),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                    'Total Premi: Rp. ${NumberFormat("#,###,###,###", "en_US").format(sppaController.premiAnakan + sppaController.sppaHeader.value.premiAmount!)}'),
                              ],
                            )
                          : Container())
                    ],
                  ),

                  SizedBox(height: 10),
                  Text('Ternak Sapi',
                      style: Get.theme.textTheme.bodyMedium!
                          .copyWith(color: Get.theme.colorScheme.secondary)),
                  SizedBox(height: 10),
                  Column(
                    children: ternakController.listTernak
                        .map((et) => Container(
                            padding: EdgeInsets.all(8),
                            child: Wrap(spacing: 10, children: [
                              Text('Ear Tag: ${et.earTag}'),
                              Text('Jenis/Kelamin: ${et.jenis}/${et.kelamin}'),
                              Text(
                                  'Nilai Pertanggungan: Rp. ${NumberFormat("#,###,###,###", "en_US").format(et.nilaiPertanggungan)}')
                            ])))
                        .toList(),
                  ),
                  //TODO tambahkan info ternak atau button untuk lihat daftar ternak
                  SizedBox(height: 10),
                ]),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(10),
                height: 40,
                child: Row(
                  children: [
                    Obx(
                      () => polisController.makeEdit.value
                          ? IconButton(
                              onPressed: () {
                                polisController.makeEdit.value = false;
                              },
                              icon: Icon(Icons.edit),
                              color: Colors.red,
                              iconSize: 25)
                          : IconButton(
                              onPressed: () {
                                polisController.makeEdit.value = true;
                              },
                              icon: Icon(Icons.edit),
                              iconSize: 25,
                              color: Get.theme.colorScheme.secondary,
                            ),
                    ),
                    Text('   Data Sertifikat',
                        style: Get.theme.textTheme.titleMedium!
                            .copyWith(color: Get.theme.colorScheme.secondary)),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(),
                  child: Form(
                    key: polisController.polisFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                            direction: Axis.horizontal,
                            spacing: 25,
                            runSpacing: 25,
                            children: [
                              Obx(
                                () => Container(
                                  width: 250,
                                  child: TextFormField(
                                      controller:
                                          polisController.noPolisController,
                                      enabled: polisController.makeEdit.value,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "*Wajib diisi.";
                                        } else {
                                          polisController
                                                  .thePolis.value.polisDocId =
                                              polisController
                                                  .noPolisController.text;
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        border:
                                            OutlineInputBorder(gapPadding: 10),
                                        focusColor: Colors.blueAccent,
                                        label: Text('Nomer Sertifikat'),
                                        hintText: '', // 'Masukkan Nomer Polis',
                                        contentPadding: EdgeInsets.all(15),
                                        prefixIcon: Icon(Icons.short_text),
                                      )),
                                ),
                              ),
                              Obx(
                                () => Container(
                                  width: 200,
                                  height: 50,
                                  child: TextFormField(
                                    enabled: polisController.makeEdit.value,
                                    controller:
                                        polisController.tglPolisController,
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.edit_calendar,
                                          color:
                                              Get.theme.colorScheme.secondary),
                                      labelText: 'Tanggal',
                                      hintText: DateFormat("dd-MMM-yyyy")
                                          .format(DateTime
                                              .now()), // .add(Duration(days: 720))
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "*Wajib diisi.";
                                      } else {
                                        polisController
                                                .thePolis.value.tglPolis =
                                            polisController
                                                .tglPolisController.text;
                                        return null;
                                      }
                                    },
                                    onTap: () async {
                                      await polisController
                                          .chooseDate()
                                          .then((selectedDate) {
                                        if (selectedDate != null) {
                                          polisController
                                                  .tglPolisController.text =
                                              DateFormat('dd-MMM-yyyy')
                                                  .format(selectedDate);
                                          polisController
                                                  .thePolis.value.tglPolis =
                                              polisController
                                                  .tglPolisController.text;
                                          polisController.thePolis.value
                                                  .tglPolisMillis =
                                              polisController.pickedDate.value
                                                  .millisecondsSinceEpoch;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                              // Obx(
                              //   () => Container(
                              //     width: 200,
                              //     child: TextFormField(
                              //         controller: polisController
                              //             .kantorCabangController,
                              //         enabled: polisController.makeEdit.value,
                              //         validator: (value) {
                              //           if (value == null || value.isEmpty) {
                              //             return "*Wajib diisi.";
                              //           } else {
                              //             polisController
                              //                     .thePolis.value.kantorCabang =
                              //                 polisController
                              //                     .kantorCabangController.text;
                              //             return null;
                              //           }
                              //         },
                              //         keyboardType: TextInputType.text,
                              //         decoration: const InputDecoration(
                              //           border:
                              //               OutlineInputBorder(gapPadding: 10),
                              //           focusColor: Colors.blueAccent,
                              //           label: Text('Kantor Cabang'),
                              //           hintText: '', // 'Masukkan Nomer Polis',
                              //           contentPadding: EdgeInsets.all(15),
                              //           prefixIcon: Icon(Icons.short_text),
                              //         )),
                              //   ),
                              // ),
                            ]),
                        SizedBox(height: 25),
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 25,
                          runSpacing: 25,
                          children: [
                            Obx(
                              () => Container(
                                width: 200,
                                height: 50,
                                child: TextFormField(
                                  enabled: polisController.makeEdit.value,
                                  controller: polisController.tglAwalController,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.edit_calendar,
                                        color: Get.theme.colorScheme.secondary),
                                    labelText: 'Awal Pertanggungan',
                                  ),
                                  onTap: () async {
                                    await polisController
                                        .chooseDate()
                                        .then((selectedDate) {
                                      if (selectedDate != null) {
                                        polisController.tglAwalController.text =
                                            DateFormat('dd-MMM-yyyy')
                                                .format(selectedDate);
                                        polisController
                                                .thePolis.value.tglAwalPolis =
                                            polisController
                                                .tglAwalController.text;
                                        polisController.thePolis.value
                                                .tglAwalPolisMillis =
                                            polisController.pickedDate.value
                                                .millisecondsSinceEpoch;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            Obx(
                              () => Container(
                                width: 200,
                                height: 50,
                                child: TextFormField(
                                  enabled: polisController.makeEdit.value,
                                  controller:
                                      polisController.tglAkhirController,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.edit_calendar,
                                        color: Get.theme.colorScheme.secondary),
                                    labelText: 'Akhir Pertanggungan',
                                  ),
                                  onTap: () async {
                                    await polisController
                                        .chooseDate()
                                        .then((selectedDate) {
                                      if (selectedDate != null) {
                                        polisController
                                                .tglAkhirController.text =
                                            DateFormat('dd-MMM-yyyy')
                                                .format(selectedDate);
                                        polisController
                                                .thePolis.value.tglAkhirPolis =
                                            polisController
                                                .tglAkhirController.text;
                                        polisController.thePolis.value
                                                .tglAkhirPolisMillis =
                                            polisController.pickedDate.value
                                                .millisecondsSinceEpoch;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Wrap(
                        //   direction: Axis.horizontal,
                        //   spacing: 25,
                        //   runSpacing: 25,
                        //   children: [
                        //     Obx(
                        //       () => Container(
                        //         width: 250,
                        //         child: TextFormField(
                        //             controller:
                        //                 polisController.namaPolisNoController,
                        //             enabled: polisController.makeEdit.value,
                        //             validator: (value) {
                        //               if (value == null || value.isEmpty) {
                        //                 return "*Wajib diisi.";
                        //               } else {
                        //                 polisController.thePolis.value
                        //                         .namaTertanggung =
                        //                     polisController
                        //                         .namaPolisNoController.text;
                        //                 return null;
                        //               }
                        //             },
                        //             keyboardType: TextInputType.text,
                        //             decoration: const InputDecoration(
                        //               border:
                        //                   OutlineInputBorder(gapPadding: 10),
                        //               focusColor: Colors.blueAccent,
                        //               label: Text('Nama Pada Polis'),
                        //               hintText:
                        //                   '', // 'Masukkan tertera Pada Polis',
                        //               contentPadding: EdgeInsets.all(15),
                        //               prefixIcon: Icon(Icons.short_text),
                        //             )),
                        //       ),
                        //     ),
                        //     Obx(
                        //       () => Container(
                        //         width: 350,
                        //         child: TextFormField(
                        //             controller:
                        //                 polisController.alamatCustController,
                        //             enabled: polisController.makeEdit.value,
                        //             validator: (value) {
                        //               if (value == null || value.isEmpty) {
                        //                 return "*Wajib diisi.";
                        //               } else {
                        //                 polisController
                        //                         .thePolis.value.alamatCustomer =
                        //                     polisController
                        //                         .alamatCustController.text;
                        //                 return null;
                        //               }
                        //             },
                        //             maxLines: 2,
                        //             keyboardType: TextInputType.text,
                        //             decoration: const InputDecoration(
                        //               border:
                        //                   OutlineInputBorder(gapPadding: 10),
                        //               focusColor: Colors.blueAccent,
                        //               label: Text('Alamat'),
                        //               hintText: '', // 'Masukkan Nomer Polis',
                        //               contentPadding: EdgeInsets.all(15),
                        //               prefixIcon: Icon(Icons.short_text),
                        //             )),
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // SizedBox(height: 25),

                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 25,
                          runSpacing: 25,
                          children: [
                            // Obx(
                            //   () => Container(
                            //     width: 300,
                            //     child: TextFormField(
                            //         controller:
                            //             polisController.objectPolisController,
                            //         enabled: polisController.makeEdit.value,
                            //         validator: (value) {
                            //           if (value == null || value.isEmpty) {
                            //             return "*Wajib diisi.";
                            //           } else {
                            //             polisController
                            //                     .thePolis.value.jenisObject =
                            //                 polisController
                            //                     .objectPolisController.text;
                            //             return null;
                            //           }
                            //         },
                            //         maxLines: 2,
                            //         keyboardType: TextInputType.number,
                            //         decoration: const InputDecoration(
                            //           border:
                            //               OutlineInputBorder(gapPadding: 10),
                            //           focusColor: Colors.blueAccent,
                            //           label: Text('Object Pertanggungan'),
                            //           hintText:
                            //               '', // 'Masukkan tertera Pada Polis',
                            //           contentPadding: EdgeInsets.all(15),
                            //           prefixIcon: Icon(Icons.short_text),
                            //         )),
                            //   ),
                            // ),
                            // Obx(
                            //   () => Container(
                            //     width: 300,
                            //     child: TextFormField(
                            //         controller:
                            //             polisController.alamatObjectController,
                            //         enabled: polisController.makeEdit.value,
                            //         validator: (value) {
                            //           if (value == null || value.isEmpty) {
                            //             return "*Wajib diisi.";
                            //           } else {
                            //             polisController
                            //                     .thePolis.value.alamatKandang =
                            //                 polisController
                            //                     .alamatObjectController.text;
                            //             return null;
                            //           }
                            //         },
                            //         maxLines: 2,
                            //         keyboardType: TextInputType.number,
                            //         decoration: const InputDecoration(
                            //           border:
                            //               OutlineInputBorder(gapPadding: 10),
                            //           focusColor: Colors.blueAccent,
                            //           label: Text('Lokasi Object'),
                            //           hintText:
                            //               '', // 'Masukkan tertera Pada Polis',
                            //           contentPadding: EdgeInsets.all(15),
                            //           prefixIcon: Icon(Icons.short_text),
                            //         )),
                            //   ),
                            // ),
                            // Obx(
                            //   () => Container(
                            //     width: 200,
                            //     child: TextFormField(
                            //         controller: polisController
                            //             .hargaPertanggunganController,
                            //         enabled: polisController.makeEdit.value,
                            //         validator: (value) {
                            //           if (value == null || value.isEmpty) {
                            //             return "*Wajib diisi.";
                            //           } else {
                            //             polisController.thePolis.value
                            //                     .hargaPertanggungan =
                            //                 double.parse(polisController
                            //                     .hargaPertanggunganController
                            //                     .text);
                            //             return null;
                            //           }
                            //         },
                            //         keyboardType: TextInputType.number,
                            //         decoration: const InputDecoration(
                            //           border:
                            //               OutlineInputBorder(gapPadding: 10),
                            //           focusColor: Colors.blueAccent,
                            //           label: Text('Nilai Pertanggungan'),
                            //           hintText:
                            //               '', // 'Masukkan tertera Pada Polis',
                            //           contentPadding: EdgeInsets.all(15),
                            //           prefixIcon: Icon(Icons.short_text),
                            //         )),
                            //   ),
                            // ),
                            Obx(
                              () => Container(
                                width: 200,
                                child: TextFormField(
                                    controller:
                                        polisController.nilaiPremiController,
                                    enabled: polisController.makeEdit.value,
                                    onChanged: (value) =>
                                        polisController.updateTotalBiaya(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "*Wajib diisi.";
                                      } else {
                                        polisController
                                                .thePolis.value.premiAmount =
                                            double.parse(polisController
                                                .nilaiPremiController.text);
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border:
                                          OutlineInputBorder(gapPadding: 10),
                                      focusColor: Colors.blueAccent,
                                      label: Text('Nilai Premi'),
                                      hintText: '', // 'Masukkan Nomer Polis',
                                      contentPadding: EdgeInsets.all(15),
                                      prefixIcon: Icon(Icons.short_text),
                                    )),
                              ),
                            ),
                            Obx(
                              () => Container(
                                width: 150,
                                child: TextFormField(
                                    controller:
                                        polisController.biayaAdminController,
                                    enabled: polisController.makeEdit.value,
                                    onChanged: (value) =>
                                        polisController.updateTotalBiaya(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "*Wajib diisi.";
                                      } else {
                                        polisController.thePolis.value
                                                .biayaAdministrasi =
                                            double.parse(polisController
                                                .biayaAdminController.text);
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border:
                                          OutlineInputBorder(gapPadding: 10),
                                      focusColor: Colors.blueAccent,
                                      label: Text('Biaya'),
                                      hintText: '', // 'Masukkan Nomer Polis',
                                      contentPadding: EdgeInsets.all(15),
                                      prefixIcon: Icon(Icons.short_text),
                                    )),
                              ),
                            ),
                            // Obx(
                            //   () => Container(
                            //     width: 150,
                            //     child: TextFormField(
                            //         controller:
                            //             polisController.beaMeteraiController,
                            //         enabled: polisController.makeEdit.value,
                            //         onChanged: (value) =>
                            //             polisController.updateTotalBiaya(),
                            //         validator: (value) {
                            //           if (value == null || value.isEmpty) {
                            //             return "*Wajib diisi.";
                            //           } else {
                            //             polisController
                            //                     .thePolis.value.beaMaterei =
                            //                 double.parse(polisController
                            //                     .beaMeteraiController.text);
                            //             return null;
                            //           }
                            //         },
                            //         keyboardType: TextInputType.number,
                            //         decoration: const InputDecoration(
                            //           border:
                            //               OutlineInputBorder(gapPadding: 10),
                            //           focusColor: Colors.blueAccent,
                            //           label: Text('Bea Meterai'),
                            //           hintText: '', // 'Masukkan Nomer Polis',
                            //           contentPadding: EdgeInsets.all(15),
                            //           prefixIcon: Icon(Icons.short_text),
                            //         )),
                            //   ),
                            // ),
                            Obx(() {
                              return polisController.totalBiaya.value == 0
                                  ? Container()
                                  : Container(
                                      width: 150,
                                      child: TextField(
                                          readOnly: true,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(15),
                                              fillColor: Colors.black12,
                                              label: Text('Total Biaya'),
                                              labelStyle:
                                                  TextStyle(color: Colors.blue),
                                              hintText:
                                                  'Rp. ${polisController.totalBiaya.value}')));
                            }),
                          ],
                        ),
                        SizedBox(height: 25),

                        Text('Tagihan',
                            style: Get.theme.textTheme.titleMedium!.copyWith(
                                color: Get.theme.colorScheme.secondary)),
                        SizedBox(height: 20),

                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 25,
                          runSpacing: 25,
                          children: [
                            Obx(
                              () => Container(
                                width: 200,
                                height: 50,
                                child: TextFormField(
                                  enabled: polisController.makeEdit.value,
                                  controller:
                                      polisController.invoiceNoController,
                                  onChanged: (value) {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "*Wajib diisi.";
                                    } else {
                                      polisController.thePolis.value.invoiceNo =
                                          value;
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(gapPadding: 10),
                                    focusColor: Colors.blueAccent,
                                    labelText: 'Nomor Tagihan',
                                    hintText: '',
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => Container(
                                width: 200,
                                height: 50,
                                child: TextFormField(
                                  enabled: polisController.makeEdit.value,
                                  controller:
                                      polisController.tglInvoiceController,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.edit_calendar,
                                        color: Get.theme.colorScheme.secondary),
                                    labelText: 'Tanggal Tagihan',
                                    hintText: DateFormat("dd-MMM-yyyy").format(
                                        DateTime
                                            .now()), // .add(Duration(days: 720))
                                  ),
                                  onTap: () async {
                                    await polisController
                                        .chooseDate()
                                        .then((selectedDate) {
                                      if (selectedDate != null) {
                                        polisController
                                                .tglInvoiceController.text =
                                            DateFormat('dd-MMM-yyyy')
                                                .format(selectedDate);
                                        polisController
                                                .thePolis.value.tglInvoice =
                                            polisController
                                                .tglInvoiceController.text;
                                        polisController.thePolis.value
                                                .tglInvoiceMillis =
                                            polisController.pickedDate.value
                                                .millisecondsSinceEpoch;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            Obx(
                              () => Container(
                                width: 150,
                                height: 50,
                                child: TextFormField(
                                  enabled:
                                      false, // polisController.makeEdit.value,
                                  controller:
                                      polisController.invoiceAmountController,
                                  onChanged: (value) {},
                                  validator: (value) {
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border:
                                          OutlineInputBorder(gapPadding: 10),
                                      focusColor: Colors.blueAccent,
                                      labelText: 'Nilai Tagihan',
                                      hintText:
                                          'Rp. ${polisController.totalBiaya.value}',
                                      hintStyle: TextStyle(
                                          color:
                                              Get.theme.colorScheme.secondary)),
                                ),
                              ),
                            ),
                            Obx(
                              () => Container(
                                width: 200,
                                height: 50,
                                child: TextFormField(
                                  enabled: polisController.makeEdit.value,
                                  controller:
                                      polisController.tglPaymentDueController,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.edit_calendar,
                                          color:
                                              Get.theme.colorScheme.secondary),
                                      labelText:
                                          'Jatuh Tempo Pembayaran Tagihan',
                                      hintText: polisController
                                          .thePolis.value.tglPaymentDue),
                                  onTap: () async {
                                    await polisController
                                        .chooseDate()
                                        .then((selectedDate) {
                                      if (selectedDate != null) {
                                        polisController
                                                .tglInvoiceController.text =
                                            DateFormat('dd-MMM-yyyy')
                                                .format(selectedDate);
                                        polisController
                                                .thePolis.value.tglPaymentDue =
                                            polisController
                                                .tglPaymentDueController.text;
                                        polisController.thePolis.value
                                                .tglPaymentDueMillis =
                                            polisController.pickedDate.value
                                                .millisecondsSinceEpoch;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 35),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                OutlinedButton(
                  onPressed: () {
                    // kembali ke awal

                    Get.back();
                  },
                  child: Text('Batal'),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (polisController.polisFormKey.currentState!
                          .validate()) {
                        // set other variables

                        polisController.savePolis();
                      }
                    },
                    child: Text('Simpan & Tagih',
                        style: Get.theme.textTheme.titleMedium!
                            .copyWith(color: Colors.white))),
              ]),
              const SizedBox(height: 28),
            ],
          ),
        )));
  }
}
