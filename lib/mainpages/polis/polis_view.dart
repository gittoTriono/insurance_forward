import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/dashboard_controller.dart';
import 'package:insurance/bloc/polis_controller.dart';
import 'package:insurance/model/polis.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class PolisView extends StatelessWidget {
  PolisView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.find<DashboardController>();
    PolisController polisController = Get.find<PolisController>();

    final displayStatus = Get.arguments['status'];
    polisController.listHelperPolis.clear();

    if (displayStatus == 'ToDo') {
      if (controller.loginController.check.value.roles == 'ROLE_SALES') {
        // print(controller.loginController.check.value.roles);
        polisController.listHelperPolis.addAll(controller.listAktifPolis
            .where((p0) => controller.salesPolisTodo.contains(p0.statusPolis))
            .toList());
        // print('helper length ${polisController.listHelperPolis.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_CUSTOMER') {
        // print(controller.loginController.check.value.roles);
        polisController.listHelperPolis.addAll(controller.listAktifPolis
            .where((p0) => controller.custPolisTodo.contains(p0.statusPolis))
            .toList());
        // print('helper length ${polisController.listHelperPolis.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_MARKETING') {
        print(controller.loginController.check.value.roles);
        polisController.listHelperPolis.addAll(controller.listAktifPolis
            .where(
                (p0) => controller.marketingPolisTodo.contains(p0.statusPolis))
            .toList());
        // print('helper length ${polisController.listHelperPolis.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_BROKER') {
        //print(controller.loginController.check.value.roles);
        polisController.listHelperPolis.addAll(controller.listAktifPolis
            .where((p0) => controller.brokerPolisTodo.contains(p0.statusPolis))
            .toList());
        // print('helper length ${polisController.listHelperPolis.length}');
      }
    } else if (displayStatus == 'Submit') {
      if (controller.loginController.check.value.roles == 'ROLE_ADMIN') {
        polisController.listHelperPolis.addAll(controller.listAktifPolis
            .where((p0) => controller.salesPolisSubmit.contains(p0.statusPolis))
            .toList());
        // print('helper length ${polisController.listHelperPolis.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_CUSTOMER') {
        polisController.listHelperPolis.addAll(controller.listAktifPolis
            .where((p0) => controller.custPolisSubmit.contains(p0.statusPolis))
            .toList());
        // print('helper length ${polisController.listHelperPolis.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_MARKETING') {
        polisController.listHelperPolis.addAll(controller.listAktifPolis
            .where((p0) =>
                controller.marketingPolisSubmit.contains(p0.statusPolis))
            .toList());
        // print('helper length ${polisController.listHelperPolis.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_BROKER') {
        polisController.listHelperPolis.addAll(controller.listAktifPolis
            .where(
                (p0) => controller.brokerPolisSubmit.contains(p0.statusPolis))
            .toList());
        // print('helper length ${sppaController.listHelperSppa.length}');
      }
    } else if (displayStatus == 'Aktif') {
      if (controller.loginController.check.value.roles == 'ROLE_ADMIN') {
        polisController.listHelperPolis.addAll(controller.listAktifPolis
            .where((p0) => controller.salesPolisAktif.contains(p0.statusPolis))
            .toList());
        // print('helper length ${polisController.listHelperPolis.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_CUSTOMER') {
        polisController.listHelperPolis.addAll(controller.listAktifPolis
            .where((p0) => controller.custPolisAktif.contains(p0.statusPolis))
            .toList());
        // print('helper length ${polisController.listHelperPolis.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_MARKETING') {
        polisController.listHelperPolis.addAll(controller.listAktifPolis
            .where(
                (p0) => controller.marketingPolisAktif.contains(p0.statusPolis))
            .toList());
        // print('helper length ${polisController.listHelperPolis.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_BROKER') {
        polisController.listHelperPolis.addAll(controller.listAktifPolis
            .where((p0) => controller.brokerPolisAktif.contains(p0.statusPolis))
            .toList());
        // print('helper length ${sppaController.listHelperSppa.length}');
      }
    } else {
      print('unknown display status ');
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Daftar Sppa Aktif'.tr),
          actions: [
            Container(
              height: 90,
              margin: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      '${controller.loginController.check.value.userData.name}',
                      style: Get.textTheme.labelSmall),
                  // Text(
                  //     '${controller.loginController.check.value.userData.userId}',
                  //     style: Get.textTheme.labelSmall),
                  Text(' - ${controller.loginController.check.value.roles}',
                      style: Get.textTheme.labelSmall)
                ],
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Wrap(
                  spacing: 20, runSpacing: 20,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => (polisController.listHelperPolis.isEmpty)
                        ? Text('Tidak ada aktif Polis ')
                        : Wrap(
                            spacing: 20,
                            children: polisController.listHelperPolis
                                .map((e) => Column(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(left: 20),
                                            padding: EdgeInsets.all(10),
                                            width: formWidth(Get.width),
                                            decoration: BoxDecoration(
                                                // color: Get
                                                //     .theme.colorScheme.surface,
                                                border: Border.all(
                                                  width: 0.25,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                // spacing: 10,
                                                // runSpacing: 10,
                                                children: [
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            // print(
                                                            //     'on pressed go get ${e.id}');
                                                            Get.toNamed(
                                                                '/polis/polisDetail',
                                                                arguments: {
                                                                  'polisId':
                                                                      e.id
                                                                });
                                                          },
                                                          icon: Icon(
                                                              Icons
                                                                  .document_scanner,
                                                              size: 50,
                                                              color: Get
                                                                  .theme
                                                                  .colorScheme
                                                                  .secondary)),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      e.sppaId == ''
                                                          ? TextBodyMedium(
                                                              'Id ${e.id}')
                                                          : TextBodyMedium(
                                                              'Tertanggung ${e.namaTertanggung}'),
                                                      Text(
                                                          '${polisController.polisStatusDesc(e.statusPolis)}',
                                                          style: Get
                                                              .theme
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  color: Get
                                                                      .theme
                                                                      .colorScheme
                                                                      .secondary)),
                                                      TextBodyMedium(
                                                          e.produkName),
                                                    ],
                                                  ),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextBodySmall('Premi'),
                                                        TextBodySmall(
                                                            'Rp. ${NumberFormat("#,###,###,###", "en_US").format(e.premiAmount)}'),
                                                        TextBodySmall('Tenor'),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextBodySmall(
                                                            '${e.tenorSppa} bulan'),
                                                      ]),
                                                ])),
                                        SizedBox(height: 10)
                                      ],
                                    ))
                                .toList()))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
