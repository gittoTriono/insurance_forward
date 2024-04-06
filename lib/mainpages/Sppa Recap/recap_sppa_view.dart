import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/dashboard_controller.dart';
import 'package:insurance/bloc/login_controller.dart';
import 'package:insurance/bloc/sppa_recap_controller.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class RecapSppaView extends StatelessWidget {
  const RecapSppaView({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();
    final recapController = Get.put(RecapSppaController());
    final loginController = Get.find<LoginController>();

    if (loginController.check.value.roles == 'ADMIN') {}
    return Scaffold(
        appBar: AppBar(title: Text('Recap Sppa')),
        body: SingleChildScrollView(
            child: Wrap(
          children: [
            SizedBox(height: 20),
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextTitleMedium(controller.listRecapHeader.isEmpty
                    ? ''
                    : 'Daftar Recap Sppa Aktif'),
              ),
            ),
            SizedBox(height: 5),
            Obx(() => (controller.listRecapHeader.isEmpty)
                ? Text('Tidak ada aktif Recap Sppa ')
                : Wrap(
                    spacing: 20,
                    children: controller.listRecapHeader
                        .map((e) => Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left: 20),
                                    padding: EdgeInsets.all(10),
                                    width: formWidth2(Get.width),
                                    decoration: BoxDecoration(
                                        color: Get.theme.colorScheme.surface,
                                        border: Border.all(
                                          width: 0.25,
                                        ),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Wrap(children: [
                                      Column(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Get.toNamed(
                                                    '/recapSppa/recapSppaDetail',
                                                    arguments: {
                                                      'recapSppaId': e.id
                                                    });
                                              },
                                              icon: Icon(Icons.document_scanner,
                                                  size: 50,
                                                  color: Get.theme.colorScheme
                                                      .secondary)),
                                          Text(
                                            recapController.recapStatusDesc(
                                                e.recapSppaStatus!),
                                            style: Get
                                                .theme.textTheme.bodySmall!
                                                .copyWith(
                                                    color:
                                                        e.recapSppaStatus == 3
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
                                          TextBodyMedium('Recap Id ${e.id!} '),
                                          TextBodyMedium('${e.salesId!}'),
                                          TextBodyMedium(e.produkAsuransiNama!),
                                        ],
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextBodySmall(
                                                'Total Pertanggungan'),
                                            TextBodySmall(
                                                'Rp. ${NumberFormat("#,###,###,###", "en_US").format(e.totalNilaiPertanggungan)}'),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextBodySmall('Total Premi'),
                                            TextBodySmall(
                                                'Rp. ${NumberFormat("#,###,###,###", "en_US").format(e.totalNilaiPremi!)}'),
                                          ]),
                                    ])),
                                SizedBox(height: 10)
                              ],
                            ))
                        .toList()))
          ],
        )));
  }
}
