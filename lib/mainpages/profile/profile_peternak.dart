import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/customer_controller.dart';
import 'package:insurance/util/screen_size.dart';

class ProfilePeternak extends StatelessWidget {
  const ProfilePeternak({super.key});

  @override
  Widget build(BuildContext context) {
    final custController = Get.find<CustomerController>();

    return Scaffold(
      appBar: AppBar(title: Text('Profile Customer')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            width: formWidth(Get.width),
            child: Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 18),
                    Obx(
                      () {
                        custController.kelompokCtrl.text =
                            custController.theCustomer.value.kelompok!;
                        custController.noAnggotaCtrl.text =
                            custController.theCustomer.value.noAnggota!;
                        return Text('Kelompok Peternak',
                            style: Get.theme.textTheme.titleMedium!.copyWith(
                                color: Get.theme.colorScheme.secondary));
                      },
                    ),
                    const SizedBox(height: 18),
                    Wrap(
                        spacing: 25,
                        runSpacing: 20,
                        direction: Axis.horizontal,
                        children: [
                          Container(
                            width: 150,
                            child: TextFormField(
                              controller: custController.kelompokCtrl,
                              onChanged: (value) {},
                              onSaved: (value) {
                                custController.theCustomer.value.kelompok =
                                    value;
                              },
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  if (value.length > 3) {
                                    return null;
                                  } else {
                                    return "Pilih Kode Kelompok";
                                  }
                                } else {
                                  return "Pilih Kode Kelompok";
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                // icon: const Icon(Icons.person),
                                label: Text('Kelompok'.tr),
                                // hintText: 'Nama',
                                // helperText: 'Nama anda',
                                //counterText: '0 characters',
                                //border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            child: TextFormField(
                              controller: custController.noAnggotaCtrl,
                              onChanged: (value) {},
                              onSaved: (value) {
                                custController.theCustomer.value.noAnggota =
                                    value;
                              },
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  if (value.length > 3) {
                                    return null;
                                  } else {
                                    return "Masukkan nomor anggota";
                                  }
                                } else {
                                  return "Masukkan nomor anggota";
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                // icon: const Icon(Icons.person),
                                label: Text('No Anggota'.tr),
                                // hintText: 'Nama',
                                // helperText: 'Nama anda',
                                //counterText: '0 characters',
                                //border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ]),
                    const SizedBox(height: 18),
                    Obx(() => custController.listKandang.isEmpty
                        ? Column(
                            children: [
                              Text(
                                  'Belum ada kandang didaftarkan. Ketuk tanda + dibawah ini',
                                  style: Get.theme.textTheme.labelMedium!
                                      .copyWith(
                                          color:
                                              Get.theme.colorScheme.secondary)),
                              const SizedBox(height: 18),
                            ],
                          )
                        : Container()),
                    Center(
                      child: IconButton(
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            elevation: 10,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          Get.toNamed('/kandang/form', arguments: {'nama': ''});
                        },
                        icon: const Icon(Icons.add, size: 30),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Obx(() => custController.listKandang.isNotEmpty
                        ? Text('Data Kandang',
                            style: Get.theme.textTheme.titleMedium!.copyWith(
                                color: Get.theme.colorScheme.secondary))
                        : Container()),
                    const SizedBox(height: 18),
                    Obx(() {
                      if (custController.listKandang.isNotEmpty) {
                        return Wrap(
                            runSpacing: 15,
                            spacing: 15,
                            children: custController.listKandang
                                .map((e) => Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black12),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(e.namaKandang!),
                                            Text(e.jenis!),
                                            InkWell(
                                                onTap: () {
                                                  Get.toNamed('/kandang/form',
                                                      arguments: {
                                                        'nama': e.namaKandang
                                                      });
                                                },
                                                child: Icon(Icons.chevron_right,
                                                    size: 30,
                                                    color: Get.theme.colorScheme
                                                        .secondary))
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList());
                      } else {
                        return Container();
                      }
                    }),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('Batal',
                                style: Get.theme.textTheme.titleMedium!
                                    .copyWith(
                                        color:
                                            Get.theme.colorScheme.secondary))),
                        ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('Save',
                                style: Get.theme.textTheme.titleMedium!
                                    .copyWith(color: Colors.white))),
                      ],
                    ),
                    const SizedBox(height: 28),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
