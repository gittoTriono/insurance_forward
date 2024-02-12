import '../bloc/login_controller.dart';
import '../bloc/reset_controller.dart';
import '../bloc/theme_controller.dart';
import '../util/theme.dart' as theme_color;
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Drawer appDrawer(BuildContext context){

  LoginController loginController = Get.find();
  ResetController resetController = Get.find();
  ThemeController themeController = Get.find();

  return Drawer(
    child: Obx(() {
        return Container(
          color: Get.theme.colorScheme.secondary,
          child: ListView(
            children: [
              const SizedBox(height: 24, width: 0,),

              GetX<LoginController>(
                  builder: (controller) {

                    if(controller.imageData.value.available==true && controller.login.value.isTrue){
                      return Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),

                          child: ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.memory(controller.imageData.value.img, width: 100, height: 100,))),
                          ),
                      );

                    } else {
                      return Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),

                          child: CircleAvatar(
                            backgroundColor: Get.theme.colorScheme.background,
                              child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset(themeController.themeSetting.value=='isLight'?"assets/images/logo_inv.png":"assets/images/logo.png"))),

                        ),
                      );
                    }
                  }
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Divider(
                  color: Get.theme.colorScheme.onSurfaceVariant,
                ),
              ),


              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                onTap: (){
                  if(loginController.login.value.isTrue) {
                    Get.toNamed("/avatar");
                  }
                },
                leading: Icon(Icons.image, color: loginController.login.value.isTrue?Get.theme.colorScheme.onPrimaryContainer:Get.theme.colorScheme.onTertiaryContainer,),
                title: Text("profile_picture".tr, style: Get.textTheme.bodySmall!.copyWith(
                    color: loginController.login.value.isTrue?Get.theme.colorScheme.onPrimaryContainer:Get.theme.colorScheme.onTertiaryContainer
                )),
              ),

              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                onTap: (){
                  if(loginController.login.value.isTrue) {
                    Get.back();
                  }
                },
                  leading: Icon(Icons.shuffle, color: loginController.login.value.isTrue?Get.theme.colorScheme.onPrimaryContainer:Get.theme.colorScheme.onTertiaryContainer,),
                  title: Text("Change_password".tr, style: Get.textTheme.bodySmall!.copyWith(
                      color: loginController.login.value.isTrue?Get.theme.colorScheme.onPrimaryContainer:Get.theme.colorScheme.onTertiaryContainer
                  ))
                ),

            ],
          ),
        );
      }
    ),
  );

}

