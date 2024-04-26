import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/customer_controller.dart';
import 'package:insurance/util/screen_size.dart';

class FormKandang extends StatelessWidget {
  const FormKandang({super.key});

  @override
  Widget build(BuildContext context) {
    final kandangName = Get.arguments['nama'];
    final custController = Get.find<CustomerController>();

    if (kandangName != '') {
      custController.theKandang = custController.listKandang
          .firstWhere((element) => element.namaKandang == kandangName);
      print('kandang sudah keisi ${custController.theKandang.namaKandang}');
      custController.kdgNamaCtrl.text = custController.theKandang.namaKandang!;
      custController.kdgJenisCtrl.text = custController.theKandang.jenis!;
      custController.kdgLuasCtrl.text =
          custController.theKandang.luas.toString();
      custController.kdgKpstCtrl.text =
          custController.theKandang.kapasitas.toString();
      custController.kdgKtrgnCtrl.text = custController.theKandang.fasilitas!;
      // kdgFoto1Ctrl = custController.theKandang.;
      // kdgFoto2Ctrl = custController.theKandang.;
      custController.kdgJalanCtrl.text = custController.theKandang.jalan!;
      custController.kdgRtCtrl.text = custController.theKandang.rt!;
      custController.kdgRwCtrl.text = custController.theKandang.rw!;
      custController.kdgKelurahanCtrl.text =
          custController.theKandang.kelurahan!;
      custController.kdgKecamatanCtrl.text =
          custController.theKandang.kecamatan!;
      custController.kdgKabupatenCtrl.text =
          custController.theKandang.kabupaten!;
      custController.kdgKotaCtrl.text = custController.theKandang.kota!;
      custController.kdgKodePosCtrl.text = custController.theKandang.kodePos!;
      print(
          'kota: ${custController.kdgKotaCtrl.text} kodePos: ${custController.kdgKodePosCtrl.text}');
    }

    return Scaffold(
        appBar: AppBar(title: Text('Profile Kandang')),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
              width: formWidth(Get.width),
              child: Form(
                  key: custController.kandangFormKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Wrap(spacing: 25, runSpacing: 20, children: [
                            TextFormField(
                              enabled: kandangName == '' ? true : false,
                              controller: custController.kdgNamaCtrl,
                              onChanged: (value) {},
                              onSaved: (value) {},
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  custController.kdgNamaCtrl.text = value;
                                  custController.theKandang.namaKandang = value;

                                  return null;
                                } else {
                                  return "Wajib diisi";
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.fence),
                                //icon: Icon(Icons.email),
                                label: Text('Nama Kandang'),
                                //hintText: 'Email',
                                //helperText: 'contoh: nama@mailserver.com',
                                //counterText: '0 characters',
                                //border: OutlineInputBorder(),
                              ),
                            ),
                            TextFormField(
                              controller: custController.kdgJenisCtrl,
                              onChanged: (value) {},
                              onSaved: (value) {},
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  custController.kdgJenisCtrl.text = value;
                                  custController.theKandang.jenis = value;

                                  return null;
                                } else {
                                  return "Pilih jenis kandang yang sesuai";
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.check),
                                // icon: Icon(Icons.phone_android_sharp),
                                label: Text('Jenis Kandang'),
                                //hintText: 'Nomor HP',
                                //helperText: 'Nomor HP anda',
                                //counterText: '0 characters',
                                //border: OutlineInputBorder(),
                              ),
                            ),
                            Container(
                              width: 150,
                              child: TextFormField(
                                controller: custController.kdgLuasCtrl,
                                onChanged: (value) {},
                                onSaved: (value) {},
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    custController.kdgLuasCtrl.text = value;
                                    custController.theKandang.luas =
                                        double.parse(value);

                                    return null;
                                  } else {
                                    return "Ini luas kandang (m2)";
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.phone_android_sharp),
                                  // icon: Icon(Icons.phone_android_sharp),
                                  label: Text('Luas Kandang'),
                                  //hintText: 'Nomor HP',
                                  //helperText: 'Nomor HP anda',
                                  //counterText: '0 characters',
                                  //border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Container(
                              width: 150,
                              child: TextFormField(
                                controller: custController.kdgKpstCtrl,
                                onChanged: (value) {},
                                onSaved: (value) {},
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    custController.kdgKpstCtrl.text = value;
                                    custController.theKandang.kapasitas =
                                        int.parse(value);

                                    return null;
                                  } else {
                                    return "Ini kapasitas kandang (ekor)";
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.phone_android_sharp),
                                  // icon: Icon(Icons.phone_android_sharp),
                                  label: Text('Kapasitas'),
                                  //hintText: 'Nomor HP',
                                  //helperText: 'Nomor HP anda',
                                  //counterText: '0 characters',
                                  //border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: custController.kdgKtrgnCtrl,
                              onChanged: (value) {},
                              onSaved: (value) {},
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  custController.kdgKtrgnCtrl.text = value;
                                  custController.theKandang.fasilitas = value;
                                  return null;
                                } else {
                                  return "Keterangan tambahan";
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.note),
                                // icon: Icon(Icons.phone_android_sharp),
                                label: Text('Keterangan Tambahan'),
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(height: 18),
                        Text('Alamat Kandang',
                            style: Get.theme.textTheme.titleMedium!.copyWith(
                                color: Get.theme.colorScheme.secondary)),
                        const SizedBox(height: 18),
                        Wrap(
                          spacing: 25,
                          runSpacing: 20,
                          direction: Axis.horizontal,
                          children: [
                            TextFormField(
                              controller: custController.kdgJalanCtrl,
                              maxLines: 2,
                              onChanged: (value) {},
                              onSaved: (value) {},
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  if (value.length > 3) {
                                    return null;
                                  } else {
                                    return "Masukkan nama jalan dan nomor";
                                  }
                                } else {
                                  return "Masukkan nama jalan dan nomor";
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.home),
                                // icon: const Icon(Icons.person),
                                label: Text('Jalan'.tr),
                                // hintText: 'Nama',
                                // helperText: 'Nama anda',
                                //counterText: '0 characters',
                                //border: OutlineInputBorder(),
                              ),
                            ),
                            Container(
                              width: 100,
                              child: TextFormField(
                                controller: custController.kdgRtCtrl,
                                onChanged: (value) {},
                                onSaved: (value) {},
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.length > 3) {
                                      return null;
                                    } else {
                                      return "Masukkan RT";
                                    }
                                  } else {
                                    return "Masukkan RT";
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  // prefixIcon: const Icon(Icons.person),

                                  label: Text('RT'.tr),
                                  // hintText: 'Nama',
                                  // helperText: 'Nama anda',
                                  //counterText: '0 characters',
                                  //border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              child: TextFormField(
                                controller: custController.kdgRwCtrl,
                                onChanged: (value) {},
                                onSaved: (value) {},
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.length > 3) {
                                      return null;
                                    } else {
                                      return "Masukkan RW";
                                    }
                                  } else {
                                    return "Masukkan RW";
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  //prefixIcon: const Icon(Icons.person),
                                  label: Text('RW'.tr),
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
                                controller: custController.kdgKelurahanCtrl,
                                onChanged: (value) {},
                                onSaved: (value) {},
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.length > 3) {
                                      return null;
                                    } else {
                                      return "Masukkan Kelurahan";
                                    }
                                  } else {
                                    return "Masukkan Kelurahan";
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  //prefixIcon: const Icon(Icons.person),
                                  label: Text('Kelurahan'.tr),
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
                                controller: custController.kdgKecamatanCtrl,
                                onChanged: (value) {},
                                onSaved: (value) {},
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.length > 3) {
                                      return null;
                                    } else {
                                      return "Masukkan Kecamatan";
                                    }
                                  } else {
                                    return "Masukkan Kecamatan";
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  // prefixIcon: const Icon(Icons.person),
                                  label: Text('Kecamatan'.tr),
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
                                controller: custController.kdgKabupatenCtrl,
                                onChanged: (value) {},
                                onSaved: (value) {},
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.length > 3) {
                                      return null;
                                    } else {
                                      return "Masukkan Kabupaten";
                                    }
                                  } else {
                                    return "Masukkan Kabupaten";
                                  }
                                },
                                // keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  // prefixIcon: const Icon(Icons.person),
                                  label: Text('Kabupaten'.tr),
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
                                controller: custController.kdgKotaCtrl,
                                onChanged: (value) {},
                                onSaved: (value) {},
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.length > 3) {
                                      return null;
                                    } else {
                                      return "Masukkan Kota";
                                    }
                                  } else {
                                    return "Masukkan Kota";
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  //prefixIcon: const Icon(Icons.person),
                                  label: Text('Kota'.tr),
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
                                controller: custController.kdgKodePosCtrl,
                                onChanged: (value) {},
                                onSaved: (value) {},
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.length > 3) {
                                      return null;
                                    } else {
                                      return "Masukkan kode pos";
                                    }
                                  } else {
                                    return "Masukkan Kode pos";
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.local_post_office),
                                  // icon: const Icon(Icons.person),
                                  label: Text('Kode Pos'.tr),
                                  // hintText: 'Nama',
                                  // helperText: 'Nama anda',
                                  //counterText: '0 characters',
                                  //border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text('Foto Kandang',
                            style: Get.theme.textTheme.titleMedium!.copyWith(
                                color: Get.theme.colorScheme.secondary)),
                        const SizedBox(height: 18),
                        Wrap(
                            spacing: 25,
                            runSpacing: 20,
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                width: 150,
                                child: TextFormField(
                                  onChanged: (value) {},
                                  onSaved: (value) {},
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      if (value.length > 3) {
                                        return null;
                                      } else {
                                        return "Foto 1";
                                      }
                                    } else {
                                      return "Foto 1";
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.photo_camera),
                                    // icon: const Icon(Icons.person),
                                    label: Text('Foto 1'.tr),
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
                                  onChanged: (value) {},
                                  onSaved: (value) {},
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      if (value.length > 3) {
                                        return null;
                                      } else {
                                        return "Foto 2";
                                      }
                                    } else {
                                      return "Foto 2";
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.photo_camera),
                                    // icon: const Icon(Icons.person),
                                    label: Text('Foto 2'.tr),
                                    // hintText: 'Nama',
                                    // helperText: 'Nama anda',
                                    //counterText: '0 characters',
                                    //border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 38),
                            ]),
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
                                            color: Get
                                                .theme.colorScheme.secondary))),
                            ElevatedButton(
                                onPressed: () {
                                  if (kandangName == '') {
                                    print('save kandang');
                                    custController.saveKandangSapi();
                                    Get.back();
                                  } else {
                                    print('save kandang');
                                    custController.updateKandangSapi();
                                    Get.back();
                                  }
                                },
                                child: Text('Save',
                                    style: Get.theme.textTheme.titleMedium!
                                        .copyWith(color: Colors.white))),
                          ],
                        ),
                        const SizedBox(height: 28),
                      ])),
            ),
          ),
        ));
  }
}
