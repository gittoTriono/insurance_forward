import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TernakFoto extends StatelessWidget {
  const TernakFoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ternak - Foto Foto')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Container(
              height: 120,
              width: 80,
              color: Colors.lightBlue,
              child: Center(child: Text('Foto Muka'))),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                height: 80,
                width: 120,
                color: Colors.lightGreen,
                child: Center(child: Text('Foto Kiri'))),
            Container(
                height: 80,
                width: 120,
                color: Colors.grey[100],
                child: Center(child: Text('Foto Ear Tag'))),
            Container(
                height: 80,
                width: 120,
                color: Colors.lightGreen,
                child: Center(child: Text('Foto Kanan'))),
          ]),
          SizedBox(height: 20),
          Container(
              height: 120,
              width: 80,
              color: Colors.grey,
              child: Center(child: Text('Foto Surat Dokter'))),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.lightBlueAccent,
                ),
                width: Get.context!.width * 0.80,
                height: 40,
                child: Center(
                    child: Text('Selesai ',
                        style: Get.theme.textTheme.bodyMedium!
                            .copyWith(color: Get.theme.colorScheme.onPrimary))),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
