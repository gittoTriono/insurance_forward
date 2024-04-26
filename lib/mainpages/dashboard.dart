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
//    DashboardController controller = Get.put(DashboardController());
    DashboardController controller = Get.find();

    return Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        appBar: AppBar(title: Text('Dashboard'), actions: [
          Container(
            height: 80,
            margin: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${controller.loginController.check.value.userData.name}',
                    style: Get.textTheme.labelSmall!
                        .copyWith(color: Colors.white)),
                // Text(
                //     '${controller.loginController.check.value.userData.userId}',
                //     style: Get.textTheme.labelSmall),
                Text(' - ${controller.loginController.check.value.roles}',
                    style:
                        Get.textTheme.labelSmall!.copyWith(color: Colors.white))
              ],
            ),
          ),
        ]),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: formWidth2(Get.width),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    width: formWidth(Get.width),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(children: [
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Text('Topik',
                                style: Get.theme.textTheme.titleMedium!
                                    .copyWith(
                                        color:
                                            Get.theme.colorScheme.secondary)),
                          )),
                      Expanded(
                          flex: 2,
                          child: Center(
                            child: Text('Jumlah',
                                style: Get.theme.textTheme.titleMedium!
                                    .copyWith(
                                        color:
                                            Get.theme.colorScheme.secondary)),
                          ))
                    ]),
                  ),
                  Divider(
                      height: 30,
                      thickness: 0.5,
                      color: Get.theme.colorScheme.secondary,
                      indent: 60,
                      endIndent: 100),
                  controller.loginController.check.value.roles ==
                          'ROLE_CUSTOMER'
                      ? Container(
                          width: formWidth(Get.width),
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
                            Expanded(
                                flex: 1,
                                child: Text('Profile ',
                                    style: Get.theme.textTheme.titleMedium!
                                        .copyWith(
                                            color: Get
                                                .theme.colorScheme.secondary))),
                            Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      Get.toNamed('/profile');
                                    },
                                    child: Text(
                                      controller.loginController.check.value
                                          .userData.name,
                                      style: Get.theme.textTheme.bodyMedium!
                                          .copyWith(
                                              color: Get
                                                  .theme.colorScheme.secondary),
                                      textAlign: TextAlign.start,
                                    ))),
                            TextBodyMedium(
                                controller.loginController.check.value.roles),
                          ]),
                        )
                      : Container(),
                  controller.loginController.check.value.roles ==
                          'ROLE_CUSTOMER'
                      ? Divider(
                          height: 30,
                          thickness: 0.25,
                          color: Get.theme.colorScheme.secondary,
                          indent: 60,
                          endIndent: 100,
                        )
                      : Container(),
                  Obx(() {
                    if (controller.listAktifSppa.isNotEmpty) {
                      return Container(
                        width: formWidth(Get.width),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 206, 203, 203)
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
                              child: Text('Sppa',
                                  style: Get.theme.textTheme.titleMedium!
                                      .copyWith(
                                          color: Get
                                              .theme.colorScheme.secondary))),
                          Expanded(
                              flex: 2,
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
                                              Get.toNamed('/sppa', arguments: {
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
                                                                'ROLE_SALES'
                                                            ? '${controller.listAktifSppa.where((p0) => controller.salesTodo.contains(p0.statusSppa)).length}'
                                                            : controller
                                                                        .loginController
                                                                        .check
                                                                        .value
                                                                        .roles ==
                                                                    'ROLE_MARKETING'
                                                                ? '${controller.listAktifSppa.where((p0) => controller.marketingTodo.contains(p0.statusSppa)).length}'
                                                                : controller
                                                                            .loginController
                                                                            .check
                                                                            .value
                                                                            .roles ==
                                                                        'ROLE_BROKER'
                                                                    ? '${controller.listAktifSppa.where((p0) => controller.brokerTodo.contains(p0.statusSppa)).length}'
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
                                              Get.toNamed('/sppa', arguments: {
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
                                                                'ROLE_SALES'
                                                            ? '${controller.listAktifSppa.where((p0) => controller.salesSubmit.contains(p0.statusSppa)).length}'
                                                            : controller
                                                                        .loginController
                                                                        .check
                                                                        .value
                                                                        .roles ==
                                                                    'ROLE_MARKETING'
                                                                ? '${controller.listAktifSppa.where((p0) => controller.marketingSubmit.contains(p0.statusSppa)).length}'
                                                                : controller
                                                                            .loginController
                                                                            .check
                                                                            .value
                                                                            .roles ==
                                                                        'ROLE_BROKER'
                                                                    ? '${controller.listAktifSppa.where((p0) => controller.brokerSubmit.contains(p0.statusSppa)).length}'
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
                                            'ROLE_SALES'
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
                                                          color: Colors.white)),
                                            ),
                                          )
                                        : Container()
                                  ]))
                        ]),
                      );
                    } else
                      return Row();
                  }),
                  // Obx(() => controller.listRecapHeader.isNotEmpty
                  //     ? SizedBox(height: 20)
                  //     : Container()),
                  // Obx(
                  //   () => controller.listRecapHeader.isEmpty
                  //       ? Container()
                  //       : Container(
                  //           width: formWidth(Get.width),
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: 10, vertical: 5),
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             color: Colors.white,
                  //             boxShadow: [
                  //               BoxShadow(
                  //                   color:
                  //                       const Color.fromARGB(255, 206, 203, 203)
                  //                           .withOpacity(0.5),
                  //                   spreadRadius: 5,
                  //                   blurRadius: 7,
                  //                   offset: const Offset(
                  //                       0, 3) // changes position of shadow
                  //                   ),
                  //             ],
                  //           ),
                  //           child: Row(children: [
                  //             Expanded(
                  //                 flex: 1,
                  //                 child: Text('Recap Sppa',
                  //                     style: Get.theme.textTheme.titleMedium!
                  //                         .copyWith(
                  //                             color: Get.theme.colorScheme
                  //                                 .secondary))),
                  //             Expanded(
                  //               flex: 2,
                  //               child:
                  //                   Wrap(direction: Axis.horizontal, children: [
                  //                 Container(
                  //                   width: 100,
                  //                   child: Column(
                  //                     children: [
                  //                       Text('To Do'),
                  //                       TextButton(
                  //                         onPressed: () {
                  //                           Get.toNamed('/recapSppa',
                  //                               arguments: {'status': 'ToDo'});
                  //                         },
                  //                         child: Center(
                  //                             child: Text(
                  //                                 controller
                  //                                             .loginController
                  //                                             .check
                  //                                             .value
                  //                                             .roles ==
                  //                                         'ROLE_ADMIN'
                  //                                     ? '${controller.listRecapHeader.where((p0) => controller.salesRecapTodo.contains(p0.recapSppaStatus)).length}'
                  //                                     : controller
                  //                                                 .loginController
                  //                                                 .check
                  //                                                 .value
                  //                                                 .roles ==
                  //                                             'ROLE_BROKER'
                  //                                         ? '${controller.listRecapHeader.where((p0) => controller.brokerRecapTodo.contains(p0.recapSppaStatus)).length}'
                  //                                         : controller
                  //                                                     .loginController
                  //                                                     .check
                  //                                                     .value
                  //                                                     .roles ==
                  //                                                 'ROLE_MARKETING'
                  //                                             ? '${controller.listRecapHeader.where((p0) => controller.marketingRecapTodo.contains(p0.recapSppaStatus)).length}'
                  //                                             : '',
                  //                                 style: Get.theme.textTheme
                  //                                     .bodyMedium!
                  //                                     .copyWith(
                  //                                         color: Get
                  //                                             .theme
                  //                                             .colorScheme
                  //                                             .secondary))),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 Container(
                  //                   width: 100,
                  //                   child: Column(
                  //                     children: [
                  //                       Text('Submit'),
                  //                       TextButton(
                  //                         onPressed: () {
                  //                           Get.toNamed('/recapSppa',
                  //                               arguments: {
                  //                                 'status': 'Submit'
                  //                               });
                  //                         },
                  //                         child: Center(
                  //                             child: Text(
                  //                                 controller
                  //                                             .loginController
                  //                                             .check
                  //                                             .value
                  //                                             .roles ==
                  //                                         'ROLE_ADMIN'
                  //                                     ? '${controller.listRecapHeader.where((p0) => controller.salesRecapSubmit.contains(p0.recapSppaStatus)).length}'
                  //                                     : controller
                  //                                                 .loginController
                  //                                                 .check
                  //                                                 .value
                  //                                                 .roles ==
                  //                                             'ROLE_MARKETING'
                  //                                         ? '${controller.listRecapHeader.where((p0) => controller.marketingRecapSubmit.contains(p0.recapSppaStatus)).length}'
                  //                                         : controller
                  //                                                     .loginController
                  //                                                     .check
                  //                                                     .value
                  //                                                     .roles ==
                  //                                                 'ROLE_BROKER'
                  //                                             ? '${controller.listRecapHeader.where((p0) => controller.brokerRecapSubmit.contains(p0.recapSppaStatus)).length}'
                  //                                             : '',
                  //                                 style: Get.theme.textTheme
                  //                                     .bodyMedium!
                  //                                     .copyWith(
                  //                                         color: Get
                  //                                             .theme
                  //                                             .colorScheme
                  //                                             .secondary))),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ]),
                  //             ),
                  //           ]),
                  //         ),
                  // ),
                  //SizedBox(height: 20),
                  // Row(children: [
                  //   Expanded(
                  //       flex: 1,
                  //       child: Text('Polis',
                  //           style: Get.theme.textTheme.titleMedium!.copyWith(
                  //               color: Get.theme.colorScheme.secondary))),
                  //   Expanded(
                  //       flex: 3, child: Center(child: TextBodyMedium('0')))
                  // ]),
                  //SizedBox(height: 20),
                  // Row(children: [
                  //   Expanded(
                  //       flex: 1,
                  //       child: Text('Klaim',
                  //           style: Get.theme.textTheme.titleMedium!.copyWith(
                  //               color: Get.theme.colorScheme.secondary))),
                  //   Expanded(
                  //       flex: 3, child: Center(child: TextBodyMedium('0')))
                  // ]),
                  //SizedBox(height: 20),
                  // Row(children: [
                  //   Expanded(
                  //       flex: 1,
                  //       child: Text('Endorsement',
                  //           style: Get.theme.textTheme.titleMedium!.copyWith(
                  //               color: Get.theme.colorScheme.secondary))),
                  //   Expanded(
                  //       flex: 3, child: Center(child: TextBodyMedium('0')))
                  // ]),
                  SizedBox(height: 40),
                  Visibility(
                    visible: controller.loginController.check.value.roles ==
                                'ROLE_SALES' ||
                            controller.loginController.check.value.roles ==
                                'ROLE_CUSTOMER'
                        // ? !controller.loginController.login.value.isTrue
                        // : controller.loginController.login.value.isTrue,
                        ? true
                        : false,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.loginController.check.value.userData.userId =
                            //     '';
                            'SASPRI12-05';
                        // controller.loginController.check.value.roles =
                        //     'ROLE_SALES'; //  'ROLE_CUSTOMER';
                        print(
                            'before go beli : ${controller.loginController.check.value.userData.userId}');
                        Get.toNamed('/sppa/main',
                            arguments: {'sppaId': '', 'prodId': ''});
                      },
                      child:
                          Text('Beli', style: TextStyle(color: Colors.white)),
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
        ));
  }
}
