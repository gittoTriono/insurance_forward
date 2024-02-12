import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import '../util/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Widget appBarTextButton(String buttonText, String routeName){

  return TextButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states){
            if (states.contains(MaterialState.focused)) {
              return Colors.yellow;
            }
            if (states.contains(MaterialState.hovered)) {
              return kColor3;
            }
            if (states.contains(MaterialState.pressed)) {
              return kColor3;
            }
            return kColor3;
          }
      ),

      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states){
            if (states.contains(MaterialState.focused)) {
              return kSecondaryColor;
            }
            if (states.contains(MaterialState.hovered)) {
              return kPrimaryDarkColor;
            }
            if (states.contains(MaterialState.pressed)) {
              return kPrimaryLightColor;
            }
            return kPrimaryColor;
          }
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return kColor3;
            }
            if (states.contains(MaterialState.focused)) {
              return kColor3;
            }
            return kColor3; // Defer to the widget's default.
          }),
      textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return const TextStyle(fontWeight: FontWeight.w500);
            }
            if (states.contains(MaterialState.pressed)) {
              return const TextStyle(fontWeight: FontWeight.w700);
            }
            return const TextStyle(fontWeight: FontWeight.w400);
          }),

    ),
    onPressed: () {
      Get.toNamed(routeName);
    },
    child: Text(buttonText, style: TextStyle(fontFamily: fontFamily1)),
  );

}

Widget textButton(String buttonText, String routeName){

  return TextButton(
    style: ButtonStyle(

      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states){
            if (states.contains(MaterialState.focused)) {
              return kColor3;
            }
            if (states.contains(MaterialState.hovered)) {
              return kColor3;
            }
            if (states.contains(MaterialState.pressed)) {
              return kColor3;
            }
            return kColor3;
          }
      ),

      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states){
            if (states.contains(MaterialState.focused)) {
              return kSecondaryColor;
            }
            if (states.contains(MaterialState.hovered)) {
              return kPrimaryDarkColor;
            }
            if (states.contains(MaterialState.pressed)) {
              return kPrimaryLightColor;
            }
            return kPrimaryColor;
          }
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return kColor3;
            }
            if (states.contains(MaterialState.focused)) {
              return kColor3;
            }
            return kColor3; // Defer to the widget's default.
          }),
      textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return const TextStyle(fontWeight: FontWeight.w500);
            }
            if (states.contains(MaterialState.pressed)) {
              return const TextStyle(fontWeight: FontWeight.w700);
            }
            return const TextStyle(fontWeight: FontWeight.w400);
          }),

    ),
    onPressed: () {
      Get.toNamed(routeName);
    },
    child: AutoSizeText(buttonText, maxFontSize: 12, maxLines: 1, style: TextStyle(fontFamily: fontFamily1)),
  );

}

Widget drawerTextButton(Icon icon, String buttonText, String routeName){

  return TextButton(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states){
            if (states.contains(MaterialState.focused)) {
              return Colors.grey[900];
            }
            if (states.contains(MaterialState.hovered)) {
              return Colors.grey[700];
            }
            if (states.contains(MaterialState.pressed)) {
              return Colors.grey[800];
            }
            return Colors.grey[600];
          }
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.grey[300];
            }
            if (states.contains(MaterialState.focused)) {
              return Colors.grey[500];
            }
            return null; // Defer to the widget's default.
          }),
      textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return const TextStyle(fontWeight: FontWeight.w700);
            }
            if (states.contains(MaterialState.pressed)) {
              return const TextStyle(fontWeight: FontWeight.w900);
            }
            return const TextStyle(fontWeight: FontWeight.w500);
          }),

    ),
    onPressed: () {
      //Get.back();
      Get.toNamed(routeName);
    },
    child: Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
              padding: const EdgeInsets.all(8),
              child: icon),
        ),

        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(buttonText))),
      ],
    ),
  );

}

ButtonStyle drawerTextButtonStyle(){

  return ButtonStyle(
    foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states){
          if (states.contains(MaterialState.focused)) {
            return Colors.grey[900];
          }
          if (states.contains(MaterialState.hovered)) {
            return Colors.grey[700];
          }
          if (states.contains(MaterialState.pressed)) {
            return Colors.grey[800];
          }
          return Colors.grey[600];
        }
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.grey[300];
          }
          if (states.contains(MaterialState.focused)) {
            return Colors.grey[500];
          }
          return null; // Defer to the widget's default.
        }),
    textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return const TextStyle(fontWeight: FontWeight.w700);
          }
          if (states.contains(MaterialState.pressed)) {
            return const TextStyle(fontWeight: FontWeight.w900);
          }
          return const TextStyle(fontWeight: FontWeight.w500);
        }),

    );

}



ButtonStyle buttonStyle(){

  return ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states){
          if (states.contains(MaterialState.focused)) {
            return Colors.yellow;
          }
          if (states.contains(MaterialState.hovered)) {
            return kColor3;
          }
          if (states.contains(MaterialState.pressed)) {
            return kColor3;
          }
          return kColor3;
        }
    ),

    foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states){
          if (states.contains(MaterialState.focused)) {
            return kSecondaryColor;
          }
          if (states.contains(MaterialState.hovered)) {
            return kPrimaryDarkColor;
          }
          if (states.contains(MaterialState.pressed)) {
            return kPrimaryLightColor;
          }
          return kPrimaryColor;
        }
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return kColor3;
          }
          if (states.contains(MaterialState.focused)) {
            return kColor3;
          }
          return kColor3; // Defer to the widget's default.
        }),
    textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return const TextStyle(fontWeight: FontWeight.w500);
          }
          if (states.contains(MaterialState.pressed)) {
            return const TextStyle(fontWeight: FontWeight.w700);
          }
          return const TextStyle(fontWeight: FontWeight.w400);
        }),

  );

}