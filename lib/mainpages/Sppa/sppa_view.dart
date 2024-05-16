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
    DashboardController controller = Get.find<DashboardController>();
    SppaHeaderController sppaController = Get.find<SppaHeaderController>();

    final displayStatus = Get.arguments['status'];
    sppaController.listHelperSppa.clear();

    // print('display status $displayStatus');
    // print('helper length ${sppaController.listHelperSppa.length}');
    // helper list to assits displayin part of listAktifSppa
    if (displayStatus == 'ToDo') {
      if (controller.loginController.check.value.roles == 'ROLE_SALES') {
        // print(controller.loginController.check.value.roles);
        sppaController.listHelperSppa.addAll(controller.listAktifSppa
            .where((p0) => controller.salesTodo.contains(p0.statusSppa))
            .toList());
        // print('helper length ${sppaController.listHelperSppa.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_CUSTOMER') {
        print(controller.loginController.check.value.roles);
        sppaController.listHelperSppa.addAll(controller.listAktifSppa
            .where((p0) => controller.custTodo.contains(p0.statusSppa))
            .toList());
        // print('helper length ${sppaController.listHelperSppa.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_MARKETING') {
        print(controller.loginController.check.value.roles);
        sppaController.listHelperSppa.addAll(controller.listAktifSppa
            .where((p0) => controller.marketingTodo.contains(p0.statusSppa))
            .toList());
        // print('helper length ${sppaController.listHelperSppa.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_BROKER') {
        print(controller.loginController.check.value.roles);
        sppaController.listHelperSppa.addAll(controller.listAktifSppa
            .where((p0) => controller.brokerTodo.contains(p0.statusSppa))
            .toList());
        // print('helper length ${sppaController.listHelperSppa.length}');
      }
    } else if (displayStatus == 'Submit') {
      if (controller.loginController.check.value.roles == 'ROLE_SALES') {
        sppaController.listHelperSppa.addAll(controller.listAktifSppa
            .where((p0) => controller.salesSubmit.contains(p0.statusSppa))
            .toList());
        // print('helper length ${sppaController.listHelperSppa.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_CUSTOMER') {
        sppaController.listHelperSppa.addAll(controller.listAktifSppa
            .where((p0) => controller.custSubmit.contains(p0.statusSppa))
            .toList());
        // print('helper length ${sppaController.listHelperSppa.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_MARKETING') {
        sppaController.listHelperSppa.addAll(controller.listAktifSppa
            .where((p0) => controller.marketingSubmit.contains(p0.statusSppa))
            .toList());
        // print('helper length ${sppaController.listHelperSppa.length}');
      } else if (controller.loginController.check.value.roles ==
          'ROLE_BROKER') {
        sppaController.listHelperSppa.addAll(controller.listAktifSppa
            .where((p0) => controller.brokerSubmit.contains(p0.statusSppa))
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
                      style: Get.textTheme.labelSmall!
                          .copyWith(color: Colors.white))
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
                    Obx(() => (sppaController.listHelperSppa.isEmpty)
                        ? Text('Tidak ada aktif Sppa ')
                        : Wrap(
                            spacing: 20,
                            children: sppaController.listHelperSppa
                                .map((e) => Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // print(
                                            //     'on pressed go get ${e.id}');
                                            Get.toNamed('/sppa/sppaDetail',
                                                arguments: {'sppaId': e.id});
                                          },
                                          child: Container(
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
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      color: Get
                                                          .theme
                                                          .colorScheme
                                                          .secondary,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text('SPPA',
                                                              style: Get
                                                                  .theme
                                                                  .textTheme
                                                                  .headlineSmall!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white)),
                                                          // e.sppaId == ''
                                                          //     ? TextBodyMedium(
                                                          //         'Id ${e.id!}')
                                                          //     : TextBodyMedium(
                                                          //         'Customer Id ${e.sppaId!}'),

                                                          Text(e.id!,
                                                              style: Get
                                                                  .theme
                                                                  .textTheme
                                                                  .headlineSmall!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white))
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        e.sppaId!.isNotEmpty
                                                            ? Text(
                                                                'No ${e.sppaId}')
                                                            : Container(),
                                                        Text(
                                                            '${sppaController.sppaStatusDesc(e.statusSppa!)}',
                                                            style: Get
                                                                .theme
                                                                .textTheme
                                                                .bodyLarge!
                                                                .copyWith(
                                                                    color: Get
                                                                        .theme
                                                                        .colorScheme
                                                                        .secondary)),
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
                                                          TextBodySmall(
                                                              'Premi'),
                                                          TextBodySmall(
                                                              'Rp. ${NumberFormat("#,###,###,###", "en_US").format(e.premiAmount)}'),
                                                          TextBodySmall(
                                                              'Tenor'),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          TextBodySmall(
                                                              '${e.tenor} bulan'),
                                                        ]),
                                                  ])),
                                        ),
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
