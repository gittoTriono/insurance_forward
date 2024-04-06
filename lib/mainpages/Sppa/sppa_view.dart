import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/adminpages/admin_dashboard.dart';
import 'package:insurance/bloc/dashboard_controller.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/model/sppa_header.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';
import '../../bloc/login_controller.dart';
import '../../bloc/session_controller.dart';
import '../../bloc/theme_controller.dart';
import '../../util/theme.dart';

class SppaView extends StatelessWidget {
  const SppaView({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find<LoginController>();
    DashboardController controller = Get.find<DashboardController>();
    SppaHeaderController sppaController = Get.find<SppaHeaderController>();

    final displayStatus = Get.arguments['status'];
    RxList<SppaHeader> listHelperSppa = <SppaHeader>[].obs;

    print('display status $displayStatus');
    print('helper length ${listHelperSppa.length}');
    // helper list to assits displayin part of listAktifSppa
    if (displayStatus == 'ToDo') {
      if (loginController.check.value.roles == 'ROLE_ADMIN') {
        print(loginController.check.value.roles);
        listHelperSppa.addAll(controller.listAktifSppa
            .where((p0) => controller.salesTodo.contains(p0.statusSppa))
            .toList());
        print('helper length ${listHelperSppa.length}');
      } else if (loginController.check.value.roles == 'ROLE_CUSTOMER') {
        print(loginController.check.value.roles);
        listHelperSppa.addAll(controller.listAktifSppa
            .where((p0) => controller.custTodo.contains(p0.statusSppa))
            .toList());
        print('helper length ${listHelperSppa.length}');
      } else {
        listHelperSppa.addAll(controller.listAktifSppa);
        print('helper length ${listHelperSppa.length}');
      }
    } else if (displayStatus == 'Submit') {
      if (loginController.check.value.roles == 'ROLE_ADMIN') {
        listHelperSppa.addAll(controller.listAktifSppa
            .where((p0) => controller.salesSubmit.contains(p0.statusSppa))
            .toList());
        print('helper length ${listHelperSppa.length}');
      } else if (loginController.check.value.roles == 'ROLE_CUSTOMER') {
        listHelperSppa.addAll(controller.listAktifSppa
            .where((p0) => controller.custSubmit.contains(p0.statusSppa))
            .toList());
        print('helper length ${listHelperSppa.length}');
      } else {
        listHelperSppa.addAll(controller.listAktifSppa);
        print('list all');
        print('helper length ${listHelperSppa.length}');
      }
    } else {
      print('unknown display status ');
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Sppa'.tr),
          actions: [
            Container(
              height: 80,
              margin: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                      '${controller.loginController.check.value.userData.name}',
                      style: Get.textTheme.labelSmall),
                  // Text(
                  //     '${controller.loginController.check.value.userData.userId}',
                  //     style: Get.textTheme.labelSmall),
                  // Text(
                  //     '${controller.loginController.check.value.userData.roles}')
                ],
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Wrap(
                spacing: 20, runSpacing: 20,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextTitleMedium(
                          listHelperSppa.isEmpty ? '' : 'Daftar Sppa Aktif'),
                    ),
                  ),
                  SizedBox(height: 5),
                  Obx(() => (listHelperSppa.isEmpty)
                      ? Text('Tidak ada aktif Sppa ')
                      : Wrap(
                          spacing: 20,
                          children: listHelperSppa
                              .map((e) => Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(left: 20),
                                          padding: EdgeInsets.all(10),
                                          width: formWidth(Get.width),
                                          decoration: BoxDecoration(
                                              color:
                                                  Get.theme.colorScheme.surface,
                                              border: Border.all(
                                                width: 0.25,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          Get.toNamed(
                                                              '/sppa/sppaDetail',
                                                              arguments: {
                                                                'sppaId': e.id,
                                                                'isNew': 'false'
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
                                                    Text(
                                                      sppaController
                                                          .sppaStatusDesc(
                                                              e.statusSppa!),
                                                      style: Get.theme.textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              color: e.statusSppa == 3
                                                                  ? Get
                                                                      .theme
                                                                      .colorScheme
                                                                      .error
                                                                  : Get
                                                                      .theme
                                                                      .colorScheme
                                                                      .primary),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    e.sppaId == ''
                                                        ? TextBodyMedium(
                                                            'Id ${e.id!}')
                                                        : TextBodyMedium(
                                                            'Customer Id ${e.sppaId!}'),
                                                    TextBodyMedium(
                                                        e.customerId!),
                                                    TextBodyMedium(
                                                        e.produkName!),
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
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextBodySmall('Tenor'),
                                                      TextBodySmall(
                                                          '${e.tenor} bulan'),
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
        ));
  }
}
