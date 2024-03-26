import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/adminpages/admin_dashboard.dart';
import 'package:insurance/bloc/dashboard_controller.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';
import '../../bloc/login_controller.dart';
import '../../bloc/session_controller.dart';
import '../../bloc/theme_controller.dart';
import '../../util/theme.dart';

class SppaView extends StatelessWidget {
  const SppaView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.find<DashboardController>();

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextTitleMedium(
                          controller.listAktifSppa.value.isEmpty
                              ? ''
                              : 'Daftar Sppa Aktif'),
                    ),
                  ),
                  SizedBox(height: 5),
                  Obx(() => Column(
                      children: controller.listAktifSppa.value
                          .map((e) => Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 20),
                                      padding: EdgeInsets.all(10),
                                      width: formWidth(Get.width),
                                      decoration: BoxDecoration(
                                          color: Get.theme.colorScheme.surface,
                                          border: Border.all(
                                            width: 0.25,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Get.toNamed(
                                                          '/sppa/sppaDetail',
                                                          arguments: {
                                                            'sppaId': e.id
                                                          });
                                                    },
                                                    icon: Icon(
                                                        Icons.document_scanner,
                                                        size: 50,
                                                        color: Get
                                                            .theme
                                                            .colorScheme
                                                            .secondary)),
                                                TextBodySmall(e.statusSppa == 1
                                                    ? 'Baru'
                                                    : e.statusSppa == 2
                                                        ? 'Belum Lengkap'
                                                        : e.statusSppa == 3
                                                            ? 'Proses Sales'
                                                            : 'Proses')
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
                                                TextBodyMedium(e.customerId!),
                                                TextBodyMedium(e.produkName!),
                                              ],
                                            ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextBodySmall('Premi'),
                                                  TextBodySmall(
                                                      'Rp. ${e.premiAmount}'),
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
