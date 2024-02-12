import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insurance/adminpages/admin_dashboard.dart';

import '../bloc/login_controller.dart';
import '../bloc/session_controller.dart';
import '../bloc/theme_controller.dart';
import '../util/theme.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {

    LoginController loginController = Get.find();
    SessionController sessionController = Get.find();
    ThemeController themeController = Get.find();
    sessionController.registerActivity();

    return MaterialApp(
      title: 'Dashboard'.tr,
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: themeController.themeSetting.value=='isLight'? ThemeMode.light: ThemeMode.dark,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Dashboard'.tr),
          ),
          body: Column(
            children: [

              Wrap(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),

                    child: loginController.imageData.value.available==true?ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.memory(loginController.imageData.value.img, width: 100, height: 100,)))
                    : CircleAvatar(
                        backgroundColor: Get.theme.colorScheme.background,
                        child: SizedBox(
                            width: 100,
                            height: 100,
                            //child: Image.asset(themeController.themeSetting.value=='isLight'?"assets/images/logo_inv.png":"assets/images/logo.png"))),
                            child: Icon(Icons.person_2_rounded, size: 66, color: themeController.themeSetting.value=='isLight'?Colors.black87:Colors.white60),),),
                  ),
                  Container(
                    height: 100,
                    margin: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('name', style: Get.textTheme.labelSmall),
                            Text(loginController.check.value.userData.name),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('username', style: Get.textTheme.labelSmall),
                            Text(loginController.check.value.userData.userId),
                          ],
                        ),


                      ],
                    ),
                  ),
                ],
              ),

              Obx((){
                  if (loginController.check.value.roles.contains("ROLE_SUPER") || loginController.check.value.roles.contains("ROLE_ADMIN")){
                    return Center(child: AdminDashboard());
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}
