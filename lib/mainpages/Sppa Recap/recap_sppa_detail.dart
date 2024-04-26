import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/dashboard_controller.dart';
import 'package:insurance/bloc/sppa_recap_controller.dart';
import 'package:insurance/util/screen_size.dart';
import 'package:insurance/widgets/custom_textfield.dart';

class RecapSppaDetailView extends StatelessWidget {
  const RecapSppaDetailView({super.key});

  @override
  Widget build(context) {
    final dashboardController = Get.find<DashboardController>();
    final recapController = Get.find<RecapSppaController>();

    var recapSppaId = Get.arguments['recapSppaId'];

    recapController.recapHeader.value = dashboardController.listRecapHeader
        .firstWhere((element) => element.id == recapSppaId);
    recapController.recapStatus.value = dashboardController.listRecapStatus
        .firstWhere((element) => element.recapHeaderId == recapSppaId);

    recapController.getRecapDetail(recapSppaId);

    print('get recap header ${recapController.recapHeader.value.id}');

    return Scaffold(
        appBar: AppBar(title: Text('Recap Sppa')),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
            // width: formWidth(Get.width),
            child: Column(
              children: [
                SizedBox(height: 15),
                Wrap(
                  spacing: 20,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.spaceAround,
                  children: [
                    TextBodyMedium(
                        'Recap Id ${recapController.recapHeader.value.id!}'),
                    TextBodyMedium(
                        'Dibuat ${recapController.recapStatus.value.tglCreated!}'),
                    TextButton(
                      onPressed: () {
                        recapController.dialogRiwayat();
                      },
                      child: Text(
                          'Status ${recapController.recapStatusDesc(recapController.recapStatus.value.recapSppaStatus!)}',
                          style: Get.theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.teal)),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 20,
                  children: [
                    TextBodyMedium(
                        'Group Id ${recapController.recapHeader.value.salesId!}'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBodyMedium(
                            'Nama Produk ${recapController.recapHeader.value.produkAsuransiNama!}'),
                        TextBodyMedium(
                            'Asuransi ${recapController.recapHeader.value.codeAsuransi!}'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Wrap(
                    spacing: 30,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text('Jumlah Sppa'),
                          Text(
                              '${recapController.recapHeader.value.jumlahSppa!}'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Total Pertanggungan'),
                          Text(
                              'Rp. ${recapController.recapHeader.value.totalNilaiPertanggungan!}'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Total Premi'),
                          Text(
                              'Rp. ${recapController.recapHeader.value.totalNilaiPremi!}'),
                        ],
                      )
                    ]),
                SizedBox(height: 10),
                Container(
                    width: Get.width,
                    padding: EdgeInsets.only(left: 15),
                    height: 30,
                    decoration: BoxDecoration(color: Get.theme.primaryColor),
                    child: Text(
                      'Sppa Detail',
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(height: 10),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: recapController.listRecapDetail
                          .map((el) => Column(
                                children: [
                                  Container(
                                      // width: formWidth(Get.width),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 0.25,
                                              color: Colors.black12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          spacing: 15,
                                          runSpacing: 20,
                                          runAlignment:
                                              WrapAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Get.toNamed(
                                                      '/sppa/sppaDetail',
                                                      arguments: {
                                                        'sppaId': el.sppaId
                                                      });
                                                },
                                                icon: Icon(
                                                    Icons.document_scanner,
                                                    size: 50,
                                                    color: Get.theme.colorScheme
                                                        .primary)),
                                            Column(
                                              children: [
                                                TextBodySmall('ID Sppa'),
                                                TextBodyMedium(el.id!),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                TextBodySmall('ID Customer'),
                                                TextBodyMedium(el.customerId!),
                                              ],
                                            ),
                                            Column(children: [
                                              TextBodySmall(
                                                  'Nilai Pertanggungan'),
                                              TextBodyMedium(
                                                  'Rp. ${el.nilaiPertanggungan!}'),
                                            ]),
                                            Column(children: [
                                              TextBodySmall('Nilai Premi'),
                                              TextBodyMedium(
                                                  'Rp. ${el.nilaiPremi!}'),
                                            ]),
                                          ],
                                        ),
                                      )),
                                  SizedBox(height: 10)
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
