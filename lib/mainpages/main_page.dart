import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../bloc/login_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../util/screen_size.dart' as screenSize;
import '../../util/style.dart';
import '../../util/theme.dart' as theme_color;
import '../../bloc/theme_controller.dart';


Widget mainPage(double _width, double _height){

  ThemeController _themeController = Get.find();

  double envWidth = Get.width;
  double _widthElement = envWidth<420?envWidth/2:envWidth>=420&&envWidth<680?envWidth/3:envWidth>=680&&envWidth<1200?envWidth/4: envWidth>=1200&&envWidth<1600?envWidth/5:envWidth/6;


  return SizedBox(
    height: _height,
    width: _width,
    child:  SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(
            height: Get.height*0.67,
            child: Column(
              children: [

                Text("main page", style: Get.textTheme.displayLarge!.copyWith(
                  color:  _themeController.themeSetting.value=='isLight'?theme_color.textColorLight[0]:theme_color.textColorDark[0],
                ),),
                Text("Display", style: Get.textTheme.displayMedium!.copyWith(
                  color:  _themeController.themeSetting.value=='isLight'?theme_color.textColorLight[0]:theme_color.textColorDark[0],
                )),
                Text("Title", style: Get.textTheme.titleLarge!.copyWith(
                  color:  _themeController.themeSetting.value=='isLight'?theme_color.textColorLight[1]:theme_color.textColorDark[1],
                )),
                Text("Body", style: Get.textTheme.bodyLarge!.copyWith(
                  color:  _themeController.themeSetting.value=='isLight'?theme_color.textColorLight[2]:theme_color.textColorDark[2],
                )),
                Text("Label", style: Get.textTheme.labelLarge!.copyWith(
                  color:  _themeController.themeSetting.value=='isLight'?theme_color.textColorLight[3]:theme_color.textColorDark[3],
                )),

                ElevatedButton(
                    onPressed: (){}, child: Text("Button", style: Get.textTheme.labelLarge!.copyWith(
                    color: Get.theme.colorScheme.onPrimary,
                ))),

              ],
            ),
          ),







          const SizedBox(height: 16, width: 0,),

        ],
      ),
    ),
  );
}



Widget dataElement(String title, String data, String position, double width, int titleLines, int headLines) {

  return Container(
    width: width,
    margin: const EdgeInsets.fromLTRB(1, 1, 0, 0),
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.grey.shade50,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(3),
    ),
    child: Column(
      crossAxisAlignment: position=='start'?CrossAxisAlignment.start:position=='center'?CrossAxisAlignment.center:CrossAxisAlignment.end,
      children: [
        AutoSizeText(title,
            maxLines: titleLines,
            maxFontSize: 12,
            style: GoogleFonts.ptSans(color: Colors.blue.shade300)),
        AutoSizeText(data,
            maxLines: headLines,
            maxFontSize: 14,
            style: GoogleFonts.publicSans(color: Colors.grey.shade700)),
      ],
    ),
  );

}







