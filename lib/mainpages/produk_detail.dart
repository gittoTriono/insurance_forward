import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/produk_controller.dart';
import '../model/products.dart';
import '../widgets/custom_main_page_text_button.dart';
import '../widgets/custom_textfield.dart';

class ProdukDetail extends StatelessWidget {
  const ProdukDetail({super.key});

  @override
  Widget build(BuildContext context) {
    ProdukController _produkCtrl = Get.find();
    ProdukAsuransi produk = _produkCtrl.selected.value;

    RxBool _benefitVis = true.obs;
    RxBool _klaimVis = false.obs;
    RxBool _snkVis = false.obs;
    bool newSPPAButtonVisible = true;
    final List<String> _content = ['Benefit', 'Klaim', 'S & K'];
    RxString curSelection = 'Benefit'.obs;

    void setVisibility() {
      switch (curSelection.value) {
        case 'Benefit':
          _benefitVis.value = true;
          _klaimVis.value = false;
          _snkVis.value = false;
          break;
        case 'Klaim':
          _benefitVis.value = false;
          _klaimVis.value = true;
          _snkVis.value = false;
          break;
        case 'S & K':
          _benefitVis.value = false;
          _klaimVis.value = false;
          _snkVis.value = true;
          break;
      }
    }

    Widget displayProduct(String tentang) {
//'Benefit'
      switch (tentang) {
        case 'Benefit':
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  produk.manfaatShort!.map((e) => TextBodySmall(e)).toList());

        case 'Kecuali':
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: produk.pengecualianShort!
                  .map((e) => TextBodySmall(e))
                  .toList());

        case 'Klaim':
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: produk.klaimDescription!
                  .map((e) => TextBodySmall(e))
                  .toList());

        case 'snk':
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  produk.tncDescription!.map((e) => TextBodySmall(e)).toList());

        default:
          return const Text('');
      }
    }

    void cekNewSppaBtnVisibility() {
      // switch (theUser.usrType) {
      //   case 'Consumer':
      //     newSPPAButtonVisible = true;
      //     break;
      //   default:
      newSPPAButtonVisible = true;
      //     break;
    }

    return Scaffold(
      appBar: AppBar(
        title: TextHeaderSmall('Produk Detail : ${produk.productCode}'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              ProdukLogo(logoURI: produk.logoUri!, width: 100),
              SizedBox(height: 10),
              TextHeaderMedium('${produk.productName}',
                  alignment: TextAlign.center),
              TextHeaderMedium('Asuransi : ${produk.codeAsuransi}',
                  alignment: TextAlign.center),
            ],
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextHeaderSmall(
                  'Rate : ${(produk.ratePremi! * 100).toStringAsFixed(2)} %',
                  alignment: TextAlign.start),
              TextHeaderSmall('Tenor : ${produk.tenor.toString()} bulan',
                  alignment: TextAlign.start),
            ],
          ),
          SizedBox(height: 10),
          Divider(height: 20, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _content
                .map(
                  (a) => GestureDetector(
                    onTap: () {
                      curSelection.value = a;
                      setVisibility();
                    },
                    child: Obx(
                      () => Container(
                        width: 80,
                        decoration: BoxDecoration(
                            color: curSelection.value == a
                                ? Colors.lightBlue[100]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(a, textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 20),
          Obx(() => Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Visibility(
                      visible: _benefitVis.value,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            border:
                                Border.all(width: 0.5, color: Colors.lightBlue),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            TextBodyMedium('Benefit'),
                            const SizedBox(height: 15),
                            displayProduct('Benefit'),
                            const SizedBox(
                              height: 10,
                            ),
                            TextBodyMedium('Tidak Termasuk'),
                            const SizedBox(height: 10),
                            displayProduct('Kecuali'),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: _klaimVis.value,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              border: Border.all(
                                  width: 0.5, color: Colors.lightBlue),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              TextBodyMedium(
                                'Klaim',
                              ),
                              const SizedBox(height: 10),
                              displayProduct('Klaim'),
                              const SizedBox(height: 15),
                            ],
                          ),
                        )),
                    Visibility(
                      visible: _snkVis.value,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            border:
                                Border.all(width: 0.5, color: Colors.lightBlue),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            TextBodyMedium(
                              'S & K',
                            ),
                            const SizedBox(height: 15),
                            displayProduct('snk'),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Visibility(
                visible: newSPPAButtonVisible,
                child: appBarTextButton('SPPA Baru', '/dashboard/newsppa')),
          ),
        ]),
      ),
    );
  }
}
