import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'binding/home_binding.dart';
import 'package:insurance/util/app_routes.dart';
import 'bloc/login_controller.dart';
import 'bloc/registration_controller.dart';
import 'bloc/reset_controller.dart';
import 'bloc/session_controller.dart';
import 'bloc/theme_controller.dart';
import 'mainpages/drawer.dart';
import 'mainpages/unknown_route.dart';
import 'util/languages.dart';
import 'util/theme.dart';
import '../util/screen_size.dart' as screenSize;
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../util/theme.dart' as theme_color;



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(const InsuranceMart());
  Get.put(LoginController());

}

class InsuranceMart extends StatelessWidget {
  const InsuranceMart({super.key});


  @override
  Widget build(BuildContext context) {

    LoginController _loginController = Get.find();
    RegistrationController _registrationController = Get.put(RegistrationController());
    ResetController _resetController = Get.put(ResetController());
    SessionController _sessionController = Get.put(SessionController());
    ThemeController _themeController = Get.put(ThemeController());

    void _onSelected(BuildContext context, int item){
      switch(item){
        case 0:
          if(_themeController.themeSetting.value=='isLight'){
            Get.changeThemeMode(ThemeMode.dark);
            _themeController.setTheme("isDark");
          } else {
            Get.changeThemeMode(ThemeMode.light);
            _themeController.setTheme("isLight");
          }
          break;
        case 1:
          Get.changeThemeMode(ThemeMode.dark);
          _themeController.setTheme("isDark");
          break;
        case 2:
          _loginController.logout();
          break;
        case 3:
          _loginController.changeLanguage("en", "US");
          break;
        case 4:
          _loginController.changeLanguage("id", "ID");
          break;
        case 5:
          Get.defaultDialog(
            title: "",
            //middleText: "version 0.0.1",
            content: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,16),
                    child: Text("Pasar Asuransi", style: GoogleFonts.ptSans(fontSize: 18,  fontWeight: FontWeight.w400)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: Text("version 0.0.1", style: GoogleFonts.ptSans(fontSize: 14, fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
            radius: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(onPressed: () {
                  Get.back();
                },

                  child: Text("OK"),),
              ),
            ],
            barrierDismissible: false,
          );
          break;

      }
    }

    return GetMaterialApp(
      initialBinding: HomeBinding(),
      title: "InsuranceMart".tr,
      initialRoute: "/",
      unknownRoute: GetPage(name: '/notfound', page: () => const UnknownRoute()),
      defaultTransition: Transition.rightToLeft,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: ThemeMode.system,
      getPages: AppPages.routes,
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('id', 'ID'),
      translations: Languages(),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: SizedBox(
                height: 40,
                width: 40,
                child: SvgPicture.asset("assets/images/logo.svg"),
            ),
            actions: [


              GetX<LoginController>(
                  builder: (controller) {
                    if(controller.login.value.isTrue){
                      return const SizedBox(height:0, width: 0);
                    } else {

                        return TextButton(
                          //style: appBarTextButtonStyle(),
                          onPressed: (){
                            Get.toNamed("/registration");
                          },
                          child: Text('Registration'.tr, style: GoogleFonts.ptSans()),
                        );

                    }
                  }
              ),

              Obx(() {

                    if(_loginController.login.value.isTrue){
                      // when logged in, register first activity time
                      _sessionController.registerActivity();

                        return TextButton(
                          onPressed: (){
                            Get.toNamed("/dashboard");
                          },
                          child: Text('Dashboard', style: GoogleFonts.ptSans()),
                        );

                    } else {


                        return TextButton(
                          // style: appBarTextButtonStyle(),
                          onPressed: (){

                            Get.toNamed("/login");

                          },
                          child: Text("Login".tr, style: GoogleFonts.ptSans()),
                        );

                    }
                  }
              ),


              PopupMenuButton<int>(
                  onSelected: (item)=> _onSelected(context, item),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          children: [
                            const Icon(Icons.wb_sunny_outlined, color: Colors.grey),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(_themeController.themeSetting.value == 'isLight'?"Dark Theme":"Light Theme"),
                          ],
                        )),
                    const PopupMenuDivider(),
                    const PopupMenuItem<int>(
                        value: 3,
                        child: Row(
                          children: [
                            Icon(Icons.language, color: Colors.grey),
                            SizedBox(
                              width: 12,
                            ),
                            Text("English"),
                          ],
                        )),
                    const PopupMenuItem<int>(
                        value: 4,
                        child: Row(
                          children: [
                            Icon(Icons.translate, color: Colors.grey),
                            SizedBox(
                              width: 12,
                            ),
                            Text("Indonesia"),
                          ],
                        )),
                    const PopupMenuDivider(),
                    const PopupMenuItem<int>(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(Icons.logout, color: Colors.grey),
                            SizedBox(
                              width: 12,
                            ),
                            Text("Logout"),
                          ],
                        )),
                    const PopupMenuDivider(),
                    const PopupMenuItem<int>(
                        value: 5,
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.grey),
                            SizedBox(
                              width: 12,
                            ),
                            Text("Version"),
                          ],
                        )),
                  ]),
            ],
          ),

          drawer: appDrawer(context),

          body: Obx(() {
              return Column(
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





                ],
              );
            }
          ),

        ),
      ),
    );
  }

}


