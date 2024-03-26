import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:insurance/adminpages/admin_dashboard.dart';
import 'package:insurance/bloc/dashboard_controller.dart';
import 'package:insurance/bloc/login_controller.dart';
import 'package:insurance/mainpages/Sppa/sppa_view.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    print('in dashboard');
    DashboardController controller = Get.put(DashboardController());

    return Scaffold(
        appBar: AppBar(title: Text('Dashboard'), actions: [
          Container(
            height: 80,
            margin: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('${controller.loginController.check.value.userData.name}',
                    style: Get.textTheme.labelSmall),
                // Text(
                //     '${controller.loginController.check.value.userData.userId}',
                //     style: Get.textTheme.labelSmall),
                // Text('${controller.loginController.check.value.userData.roles}')
              ],
            ),
          ),
        ]),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Container(
                width: formWidth(Get.width),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(children: [
                      Expanded(flex: 3, child: TextBodyMedium('Topik')),
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Text('Jumlah',
                                style: Get.theme.textTheme.bodyMedium!.copyWith(
                                    color: Get.theme.colorScheme.secondary)),
                          ))
                    ]),
                    Divider(
                        height: 30,
                        thickness: 0.5,
                        color: Get.theme.colorScheme.secondary),
                    Row(children: [
                      Expanded(
                          flex: 3,
                          child: Text(
                              'Profile  -  ${controller.loginController.check.value.userData.name}',
                              style: Get.theme.textTheme.bodyMedium!.copyWith(
                                  color: Get.theme.colorScheme.secondary))),
                      Expanded(
                          flex: 1, child: Center(child: TextBodyMedium('0')))
                    ]),
                    Divider(
                        height: 30,
                        thickness: 0.25,
                        color: Get.theme.colorScheme.secondary),
                    Obx(() {
                      if (controller.listAktifSppa.isNotEmpty) {
                        return Row(children: [
                          Expanded(flex: 3, child: TextBodyMedium('Sppa')),
                          Expanded(
                              flex: 1,
                              child: TextButton(
                                  onPressed: () {
                                    Get.toNamed('/sppa');
                                  },
                                  child: Center(
                                    child: Text(
                                        '${controller.listAktifSppa.value.length}',
                                        style: Get.theme.textTheme.bodyMedium!
                                            .copyWith(
                                                color: Get.theme.colorScheme
                                                    .secondary)),
                                  )))
                        ]);
                      } else
                        return Row();
                    }),
                    SizedBox(height: 20),
                    Row(children: [
                      Expanded(flex: 3, child: TextBodyMedium('Polis')),
                      Expanded(
                          flex: 1, child: Center(child: TextBodyMedium('0')))
                    ]),
                    SizedBox(height: 20),
                    Row(children: [
                      Expanded(flex: 3, child: TextBodyMedium('Klaim')),
                      Expanded(
                          flex: 1, child: Center(child: TextBodyMedium('0')))
                    ]),
                    SizedBox(height: 20),
                    Row(children: [
                      Expanded(flex: 3, child: TextBodyMedium('Endorsement')),
                      Expanded(
                          flex: 1, child: Center(child: TextBodyMedium('0')))
                    ]),
                    SizedBox(height: 40),
                    Obx(
                      () {
                        if (controller.loginController.check.value.roles
                                .contains("ROLE_SUPER") ||
                            controller.loginController.check.value.roles
                                .contains("ROLE_ADMIN")) {
                          return Center(child: AdminDashboard());
                        } else {
                          return Container();
                        }
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
