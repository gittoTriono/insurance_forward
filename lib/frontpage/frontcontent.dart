import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/info_data.dart';

class FrontContent extends StatelessWidget {
  const FrontContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
  }
}

Widget uiContent() {
  return Container();
}

Widget imageBannerAndText(InfoData infoData) {
  List<String> titleColors = infoData.titleColor.split(",");
  List<String> contentColors = infoData.contentColor.split(",");

  return Container(
    width: Get.width,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Image.network(infoData.pictureUrl),
        Align(
          alignment: infoData.style == 'left'
              ? Alignment.centerLeft
              : infoData.style == 'right'
                  ? Alignment.centerRight
                  : Alignment.center,
          child: Column(
            children: [
              Text(
                "Title",
                style: Get.theme.textTheme.bodyMedium!.copyWith(
                  color: Color.fromARGB(
                    int.parse(titleColors[0]),
                    int.parse(titleColors[1]),
                    int.parse(titleColors[2]),
                    int.parse(titleColors[3]),
                  ),
                ),
              ),
              Text(
                "Subtitle",
                style: Get.theme.textTheme.bodyMedium!.copyWith(
                  color: Color.fromARGB(
                    int.parse(contentColors[0]),
                    int.parse(contentColors[1]),
                    int.parse(contentColors[2]),
                    int.parse(contentColors[3]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget colorBannerAndText(InfoData infoData) {
  List<String> bgColors = infoData.bgColor.split(",");
  List<String> titleColors = infoData.titleColor.split(",");
  List<String> contentColors = infoData.contentColor.split(",");

  return Container(
    color: Color.fromARGB(int.parse(bgColors[0]), int.parse(bgColors[1]),
        int.parse(bgColors[2]), int.parse(bgColors[3])),
    width: Get.width,
    height: Get.height * 0.25,
    child: Column(
      children: [
        Text(
          "Title",
          style: Get.theme.textTheme.bodyMedium!.copyWith(
            color: Color.fromARGB(
              int.parse(titleColors[0]),
              int.parse(titleColors[1]),
              int.parse(titleColors[2]),
              int.parse(titleColors[3]),
            ),
          ),
        ),
        Text(
          "Subtitle",
          style: Get.theme.textTheme.bodyMedium!.copyWith(
            color: Color.fromARGB(
              int.parse(contentColors[0]),
              int.parse(contentColors[1]),
              int.parse(contentColors[2]),
              int.parse(contentColors[3]),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget cardWrapper(List<InfoData> cards) {
  return Container();
}

Widget card(InfoData infoData) {
  return Card(
    child: Container(),
  );
}
