import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bloc/theme_controller.dart';
import '../../util/theme.dart' as theme_color;

class TextBodySmall extends StatelessWidget {
  final String text;
  const TextBodySmall(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController _themeController = Get.find();
    return Text(text,
        style: Get.textTheme.bodySmall!.copyWith(
          color: _themeController.themeSetting.value == 'isLight'
              ? theme_color.textColorLight[2]
              : theme_color.textColorDark[2],
        ));
  }
}

class TextBodyMedium extends StatelessWidget {
  final String text;
  const TextBodyMedium(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController _themeController = Get.find();
    return Text(
      text,
      style: Get.textTheme.bodyMedium!.copyWith(
        color: _themeController.themeSetting.value == 'isLight'
            ? theme_color.textColorLight[2]
            : theme_color.textColorDark[2],
      ),
      textAlign: TextAlign.start,
    );
  }
}

class TextHeaderLarge extends StatelessWidget {
  final String text;
  const TextHeaderLarge(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController _themeController = Get.find();

    return Text(text,
        style: Get.textTheme.headlineLarge!.copyWith(
          color: _themeController.themeSetting.value == 'isLight'
              ? theme_color.textColorLight[2]
              : theme_color.textColorDark[2],
        ));
  }
}

class TextHeaderMedium extends StatelessWidget {
  final String text;
  TextAlign? alignment = TextAlign.start;
  TextHeaderMedium(this.text, {this.alignment, super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController _themeController = Get.find();

    return Text(
      text,
      style: Get.textTheme.headlineMedium!.copyWith(
        color: _themeController.themeSetting.value == 'isLight'
            ? theme_color.textColorLight[2]
            : theme_color.textColorDark[2],
      ),
      textAlign: alignment,
    );
  }
}

class TextHeaderSmall extends StatelessWidget {
  final String text;
  TextAlign? alignment = TextAlign.start;
  TextHeaderSmall(this.text, {this.alignment, super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController _themeController = Get.find();

    return Text(
      text,
      style: Get.textTheme.headlineSmall!.copyWith(
        color: _themeController.themeSetting.value == 'isLight'
            ? theme_color.textColorLight[2]
            : theme_color.textColorDark[2],
      ),
      textAlign: alignment,
    );
  }
}

class TextTitleMedium extends StatelessWidget {
  final String text;
  TextAlign? alignment = TextAlign.start;
  TextTitleMedium(this.text, {this.alignment, super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController _themeController = Get.find();

    return Text(
      text,
      style: Get.textTheme.titleMedium!.copyWith(
        color: _themeController.themeSetting.value == 'isLight'
            ? theme_color.textColorLight[1]
            : theme_color.textColorDark[1],
      ),
      textAlign: alignment,
    );
  }
}

class ProdukLogo extends StatelessWidget {
  final String logoURI;
  final double width;
  const ProdukLogo({required this.logoURI, required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width + 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3) // changes position of shadow
                )
          ],
        ),
        child: Image.asset(logoURI, fit: BoxFit.fitWidth, width: width));
  }
}
