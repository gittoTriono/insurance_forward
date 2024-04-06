import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:insurance/adminpages/admin_dashboard.dart';
import 'package:insurance/bloc/dashboard_controller.dart';
import 'package:insurance/bloc/login_controller.dart';
import 'package:insurance/bloc/sppa_recap_controller.dart';
import 'package:insurance/mainpages/Sppa/sppa_view.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    print('in dashboard');

    DashboardController controller = Get.put(DashboardController());
    // pindah ke main.dart
    //DashboardController controller = Get.find<DashboardController>();

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
                    style: Get.textTheme.labelSmall!
                        .copyWith(color: Colors.white)),
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
                width: formWidth2(Get.width),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(children: [
                      Expanded(flex: 1, child: TextBodyMedium('Topik')),
                      Expanded(
                          flex: 3,
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
                          flex: 1,
                          child: Text(
                              'Profile  -  ${controller.loginController.check.value.userData.name}',
                              style: Get.theme.textTheme.bodyMedium!.copyWith(
                                  color: Get.theme.colorScheme.secondary))),
                      Expanded(
                          flex: 3, child: Center(child: TextBodyMedium('0')))
                    ]),
                    Divider(
                        height: 30,
                        thickness: 0.25,
                        color: Get.theme.colorScheme.secondary),
                    Obx(() {
                      if (controller.listAktifSppa.isNotEmpty) {
                        return Container(
                          width: Get.width,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 206, 203, 203)
                                          .withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3) // changes position of shadow
                                  ),
                            ],
                          ),
                          child: Row(children: [
                            Expanded(flex: 1, child: TextBodyMedium('Sppa')),
                            Expanded(
                                flex: 3,
                                child: Wrap(
                                    direction: Axis.horizontal,
                                    runSpacing: 20,
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Column(
                                          children: [
                                            Text('To Do'),
                                            TextButton(
                                              onPressed: () {
                                                Get.toNamed('/sppa',
                                                    arguments: {
                                                      'status': 'ToDo'
                                                    });
                                              },
                                              child: Center(
                                                  child: Text(
                                                      controller
                                                                  .loginController
                                                                  .check
                                                                  .value
                                                                  .roles ==
                                                              'ROLE_CUSTOMER'
                                                          ? '${controller.listAktifSppa.where((p0) => controller.custTodo.contains(p0.statusSppa)).length}'
                                                          : controller
                                                                      .loginController
                                                                      .check
                                                                      .value
                                                                      .roles ==
                                                                  'ROLE_ADMIN'
                                                              ? '${controller.listAktifSppa.where((p0) => controller.salesTodo.contains(p0.statusSppa)).length}'
                                                              : 'undef',
                                                      style: Get.theme.textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              color: Get
                                                                  .theme
                                                                  .colorScheme
                                                                  .secondary))),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        child: Column(
                                          children: [
                                            Text('Submit'),
                                            TextButton(
                                              onPressed: () {
                                                Get.toNamed('/sppa',
                                                    arguments: {
                                                      'status': 'Submit'
                                                    });
                                              },
                                              child: Center(
                                                  child: Text(
                                                      controller
                                                                  .loginController
                                                                  .check
                                                                  .value
                                                                  .roles ==
                                                              'ROLE_CUSTOMER'
                                                          ? '${controller.listAktifSppa.where((p0) => controller.custSubmit.contains(p0.statusSppa)).length}'
                                                          : controller
                                                                      .loginController
                                                                      .check
                                                                      .value
                                                                      .roles ==
                                                                  'ROLE_ADMIN'
                                                              ? '${controller.listAktifSppa.where((p0) => controller.salesSubmit.contains(p0.statusSppa)).length}'
                                                              : 'undef',
                                                      style: Get.theme.textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              color: Get
                                                                  .theme
                                                                  .colorScheme
                                                                  .secondary))),
                                            ),
                                          ],
                                        ),
                                      ),
                                      controller.loginController.check.value
                                                  .roles ==
                                              'ROLE_ADMIN'
                                          ? Container(
                                              width: 100,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  // controller.recapController
                                                  //     .createRecapSppa();
                                                },
                                                child: Text('Proses Recap',
                                                    style: Get.theme.textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.white)),
                                              ),
                                            )
                                          : Container()
                                    ]))
                          ]),
                        );
                      } else
                        return Row();
                    }),
                    Obx(() => controller.listRecapHeader.isNotEmpty
                        ? SizedBox(height: 20)
                        : Container()),
                    Obx(
                      () => controller.listRecapHeader.isEmpty
                          ? Container()
                          : Container(
                              width: Get.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color.fromARGB(
                                              255, 206, 203, 203)
                                          .withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3) // changes position of shadow
                                      ),
                                ],
                              ),
                              child: Row(children: [
                                Expanded(
                                    flex: 1,
                                    child: TextBodyMedium('Recap Sppa')),
                                Expanded(
                                  flex: 3,
                                  child: Wrap(
                                      direction: Axis.horizontal,
                                      children: [
                                        Container(
                                          width: 100,
                                          child: Column(
                                            children: [
                                              Text('To Do'),
                                              TextButton(
                                                onPressed: () {
                                                  Get.toNamed('/recapSppa',
                                                      arguments: {
                                                        'status': 'ToDo'
                                                      });
                                                },
                                                child: Center(
                                                    child: Text(
                                                        controller
                                                                    .loginController
                                                                    .check
                                                                    .value
                                                                    .roles ==
                                                                'ROLE_ADMIN'
                                                            ? '${controller.listRecapHeader.where((p0) => controller.salesRecapTodo.contains(p0.recapSppaStatus)).length}'
                                                            : '',
                                                        style: Get
                                                            .theme
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: Get
                                                                    .theme
                                                                    .colorScheme
                                                                    .secondary))),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          child: Column(
                                            children: [
                                              Text('Submit'),
                                              TextButton(
                                                onPressed: () {
                                                  Get.toNamed('/recapSppa',
                                                      arguments: {
                                                        'status': 'Submit'
                                                      });
                                                },
                                                child: Center(
                                                    child: Text(
                                                        controller
                                                                    .loginController
                                                                    .check
                                                                    .value
                                                                    .roles ==
                                                                'ROLE_ADMIN'
                                                            ? '${controller.listRecapHeader.where((p0) => controller.salesRecapSubmit.contains(p0.recapSppaStatus)).length}'
                                                            : '',
                                                        style: Get
                                                            .theme
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: Get
                                                                    .theme
                                                                    .colorScheme
                                                                    .secondary))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              ]),
                            ),
                    ),
                    SizedBox(height: 20),
                    Row(children: [
                      Expanded(flex: 1, child: TextBodyMedium('Polis')),
                      Expanded(
                          flex: 3, child: Center(child: TextBodyMedium('0')))
                    ]),
                    SizedBox(height: 20),
                    Row(children: [
                      Expanded(flex: 1, child: TextBodyMedium('Klaim')),
                      Expanded(
                          flex: 3, child: Center(child: TextBodyMedium('0')))
                    ]),
                    SizedBox(height: 20),
                    Row(children: [
                      Expanded(flex: 1, child: TextBodyMedium('Endorsement')),
                      Expanded(
                          flex: 3, child: Center(child: TextBodyMedium('0')))
                    ]),
                    SizedBox(height: 40),
                    Visibility(
                      visible: !controller.loginController.login.value.isTrue,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/sppa/main', arguments: {'sppaId': ''});
                        },
                        child: Text('Sppa Baru',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 15),
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
