import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:insurance/bloc/dashboard_controller.dart';
// import 'package:insurance/bloc/dashboard_controller.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/widgets/custom_textfield.dart';
import 'binding/home_binding.dart';
import 'package:insurance/util/app_routes.dart';
import 'bloc/login_controller.dart';
import 'bloc/produk_controller.dart';
import 'bloc/produk_kategori_controller.dart';
import 'bloc/registration_controller.dart';
import 'bloc/reset_controller.dart';
import 'bloc/session_controller.dart';
import 'bloc/theme_controller.dart';
import 'mainpages/drawer.dart';
import 'mainpages/unknown_route.dart';
import 'util/languages.dart';
import 'util/theme.dart';
// import '../util/screen_size.dart' as screenSize;
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../util/theme.dart' as theme_color;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  Get.put(ProdukKategoriController());
  Get.put(ProdukController());
  runApp(const InsuranceMart());
  Get.put(LoginController());
}

class InsuranceMart extends StatelessWidget {
  const InsuranceMart({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    RegistrationController _registrationController =
        Get.put(RegistrationController());
    ResetController _resetController = Get.put(ResetController());
    SessionController _sessionController = Get.put(SessionController());
    ThemeController _themeController = Get.put(ThemeController());
    //
    ProdukKategoriController thisProdukKatController = Get.find();
    ProdukController thisProdukController = Get.find();

    //

    void _onSelected(BuildContext context, int item) {
      switch (item) {
        case 0:
          if (_themeController.themeSetting.value == 'isLight') {
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
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: Text("Pasar Asuransi",
                        style: GoogleFonts.ptSans(
                            fontSize: 18, fontWeight: FontWeight.w400)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: Text("version 0.0.1",
                        style: GoogleFonts.ptSans(
                            fontSize: 14, fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
            radius: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("OK"),
                ),
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
      unknownRoute:
          GetPage(name: '/notfound', page: () => const UnknownRoute()),
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
              GetX<LoginController>(builder: (controller) {
                if (controller.login.value.isTrue) {
                  return const SizedBox(height: 0, width: 0);
                } else {
                  return TextButton(
                    //style: appBarTextButtonStyle(),
                    onPressed: () {
                      Get.toNamed("/registration");
                    },
                    child: Text('Registration'.tr, style: GoogleFonts.ptSans()),
                  );
                }
              }),
              Obx(() {
                if (_loginController.login.value.isTrue) {
                  // when logged in, register first activity time
                  _sessionController.registerActivity();

                  return TextButton(
                    onPressed: () {
                      Get.toNamed("/dashboard");
                    },
                    child: Text('Dashboard', style: GoogleFonts.ptSans()),
                  );
                } else {
                  return TextButton(
                    // style: appBarTextButtonStyle(),
                    onPressed: () {
                      Get.toNamed("/login");
                    },
                    child: Text("Login".tr, style: GoogleFonts.ptSans()),
                  );
                }
              }),
              PopupMenuButton<int>(
                  onSelected: (item) => _onSelected(context, item),
                  itemBuilder: (context) => [
                        PopupMenuItem<int>(
                            value: 0,
                            child: Row(
                              children: [
                                const Icon(Icons.wb_sunny_outlined,
                                    color: Colors.grey),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(_themeController.themeSetting.value ==
                                        'isLight'
                                    ? "Dark Theme"
                                    : "Light Theme"),
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Text(
                  //   "main page 1",
                  //   style: Get.textTheme.displayLarge!.copyWith(
                  //     color: _themeController.themeSetting.value == 'isLight'
                  //         ? theme_color.textColorLight[0]
                  //         : theme_color.textColorDark[0],
                  //   ),
                  // ),
                  // Text("Display 1",
                  //     style: Get.textTheme.displayMedium!.copyWith(
                  //       color: _themeController.themeSetting.value == 'isLight'
                  //           ? theme_color.textColorLight[0]
                  //           : theme_color.textColorDark[0],
                  //     )),
                  // Text("Title",
                  //     style: Get.textTheme.titleLarge!.copyWith(
                  //       color: _themeController.themeSetting.value == 'isLight'
                  //           ? theme_color.textColorLight[1]
                  //           : theme_color.textColorDark[1],
                  //     )),
                  // Text("Body",
                  //     style: Get.textTheme.bodyLarge!.copyWith(
                  //       color: _themeController.themeSetting.value == 'isLight'
                  //           ? theme_color.textColorLight[2]
                  //           : theme_color.textColorDark[2],
                  //     )),
                  const SizedBox(height: 10),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          // border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.circular(15)),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                alignment: WrapAlignment.start,
                                children: [
                                  Image.asset('assets/images/istpro_logo.jpg',
                                      fit: BoxFit.fitHeight, height: 40),
                                  Image.asset('assets/images/saspri_logo.jpg',
                                      fit: BoxFit.fitHeight, height: 60),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: const TextSpan(
                                          text:
                                              'Selamat Datang di portal Asuransi ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Saspri Pro.',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                          height: 10, color: Colors.white),
                                      RichText(
                                        text: const TextSpan(
                                            text: 'IstPro dan SASPRI ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      'Memudahkan Perlindungan Usaha dan Ternak Anda. ',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.black)),
                                            ]),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          Obx(
                            () => Wrap(
                                spacing: 15,
                                children:
                                    thisProdukKatController.listProdukKategori
                                        .asMap()
                                        .entries
                                        .map(
                                          (element) => InkWell(
                                            onTap: () {
                                              thisProdukKatController
                                                  .selected.value = element.key;
                                              // print(thisProdukKatController
                                              //     .listProdukKategori[element.key]
                                              //     .kategoriCode);
                                              // print(thisProdukKatController
                                              //     .listProdukKategori[element.key]
                                              //     .subKategoriCode);
                                              thisProdukKatController
                                                      .kategoriSelected.value =
                                                  thisProdukKatController
                                                      .listProdukKategori[
                                                          element.key]
                                                      .kategoriCode;
                                              thisProdukKatController
                                                      .subKategoriSelected
                                                      .value =
                                                  thisProdukKatController
                                                      .listProdukKategori[
                                                          element.key]
                                                      .subKategoriCode;
                                              thisProdukController
                                                  .listSelectedProdukAsuransi
                                                  .value = [];
                                              thisProdukController
                                                  .getProdukAsuransiSelectedKategori();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                // ignore: unrelated_type_equality_checks
                                                color: thisProdukKatController
                                                            .selected.value ==
                                                        element.key
                                                    ? Colors.lightBlue
                                                    : Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: const Offset(0,
                                                          3) // changes position of shadow
                                                      ),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    element.value.iconFilename,
                                                    fit: BoxFit.fitHeight,
                                                    height: 45,
                                                  ),
                                                  Text(
                                                      '${element.value.kategoriDeskripsi}')
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList()),
                          ),
                          const SizedBox(height: 20),
                          // const Text('Produk'),
                          const SizedBox(height: 10),
                          Obx(
                            () => Wrap(
                                spacing: 15,
                                children: thisProdukController
                                    .listSelectedProdukAsuransi
                                    .asMap()
                                    .entries
                                    .map((e) => InkWell(
                                          onTap: () {
                                            thisProdukController
                                                .selected.value = e.value;
                                            Get.toNamed(
                                                '/dashboard/ProdukDetail');
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            width: 100,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 0.5)),
                                            child: Column(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                        e.value.logoUri!,
                                                        width: 80,
                                                        fit: BoxFit.fitWidth),
                                                    Text(e.value.productName!),
                                                    Obx(() {
                                                      if (_loginController
                                                          .login.value.isTrue) {
                                                        return OutlinedButton(
                                                            onPressed: () {
                                                              final sppaController =
                                                                  Get.put(
                                                                      SppaHeaderController());

                                                              sppaController
                                                                  .isNewSppa
                                                                  .value = true;
                                                              sppaController
                                                                      .sppaHeader
                                                                      .value
                                                                      .customerId =
                                                                  _loginController
                                                                      .check
                                                                      .value
                                                                      .userData
                                                                      .name;
                                                              sppaController
                                                                      .sppaHeader
                                                                      .value
                                                                      .produkCode =
                                                                  e.value
                                                                      .productCode;
                                                              sppaController
                                                                      .sppaHeader
                                                                      .value
                                                                      .produkName =
                                                                  e.value
                                                                      .productName;

                                                              Get.toNamed(
                                                                  '/sppa/main');
                                                            },
                                                            child:
                                                                TextBodySmall(
                                                                    'Beli'));
                                                      } else {
                                                        return Container();
                                                      }
                                                    }
                                                        //Text(e.value.codeAsuransi!),
                                                        ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                    .toList()),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  Visibility(
                    visible: !_loginController.login.value.isTrue,
                    child: ElevatedButton(
                      onPressed: () {
                        // Get.put(DashboardController());
                        //print('Put DashboardController di depan');

                        _loginController.check.value.roles = 'ROLE_CUSTOMER';
                        _loginController.check.value.userData.name =
                            'SASPRI12-05';
                        Get.toNamed('/dashboard');
                      },
                      child: Text('Dashboard Customer',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 15),

                  Visibility(
                    visible: !_loginController.login.value.isTrue,
                    child: ElevatedButton(
                      onPressed: () {
                        // Get.put(DashboardController());
                        // print('Put DashboardController di depan');
                        _loginController.check.value.roles = 'ROLE_SALES';
                        _loginController.check.value.userData.name = 'SASPRI12';
                        Get.toNamed('/dashboard');
                      },
                      child: Text('Dashboard SASPRI',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Visibility(
                    visible: !_loginController.login.value.isTrue,
                    child: ElevatedButton(
                      onPressed: () {
                        // Get.put(DashboardController());
                        // print('Put DashboardController di depan');
                        _loginController.check.value.roles = 'ROLE_MARKETING';
                        _loginController.check.value.userData.name =
                            'SASPRINAS';
                        Get.toNamed('/dashboard');
                      },
                      child: Text('Dashboard SASPRINAS',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Visibility(
                    visible: !_loginController.login.value.isTrue,
                    child: ElevatedButton(
                      onPressed: () {
                        // Get.put(DashboardController());
                        // print('Put DashboardController di depan');
                        _loginController.check.value.roles = 'ROLE_BROKER';
                        _loginController.check.value.userData.name = '1';
                        Get.toNamed('/dashboard');
                      },
                      child: Text('Dashboard ISTPRO',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),

                  const SizedBox(height: 15),
                  Image.asset('assets/images/why_istpro.png', fit: BoxFit.fill),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.black,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text('Hubungi Kami',
                                  textAlign: TextAlign.center,
                                  style: Get.textTheme.bodyMedium!.copyWith(
                                    color:
                                        _themeController.themeSetting.value ==
                                                'isLight'
                                            ? theme_color.textColorLight[2]
                                            : theme_color.textColorDark[2],
                                  )),
                            ),
                            Expanded(
                                flex: 1,
                                child: Text('More Information',
                                    textAlign: TextAlign.center,
                                    style: Get.textTheme.bodySmall!.copyWith(
                                      color:
                                          _themeController.themeSetting.value ==
                                                  'isLight'
                                              ? theme_color.textColorLight[2]
                                              : theme_color.textColorDark[2],
                                    ))),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'IstPro',
                                    style: Get.textTheme.bodySmall!.copyWith(
                                      color:
                                          _themeController.themeSetting.value ==
                                                  'isLight'
                                              ? theme_color.textColorLight[2]
                                              : theme_color.textColorDark[2],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Alamat : ',
                                    style: Get.textTheme.bodySmall!.copyWith(
                                      color:
                                          _themeController.themeSetting.value ==
                                                  'isLight'
                                              ? theme_color.textColorLight[2]
                                              : theme_color.textColorDark[2],
                                    ),
                                  ),
                                  Text(
                                    'Telephone/WA :',
                                    style: Get.textTheme.bodySmall!.copyWith(
                                      color:
                                          _themeController.themeSetting.value ==
                                                  'isLight'
                                              ? theme_color.textColorLight[2]
                                              : theme_color.textColorDark[2],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SASPRI',
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                      color:
                                          _themeController.themeSetting.value ==
                                                  'isLight'
                                              ? theme_color.textColorLight[2]
                                              : theme_color.textColorDark[2],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Alamat : ',
                                    style: Get.textTheme.bodySmall!.copyWith(
                                      color:
                                          _themeController.themeSetting.value ==
                                                  'isLight'
                                              ? theme_color.textColorLight[2]
                                              : theme_color.textColorDark[2],
                                    ),
                                  ),
                                  Text(
                                    'Telephone/WA :',
                                    style: Get.textTheme.bodySmall!.copyWith(
                                      color:
                                          _themeController.themeSetting.value ==
                                                  'isLight'
                                              ? theme_color.textColorLight[2]
                                              : theme_color.textColorDark[2],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Proses Pemesanan',
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                      color:
                                          _themeController.themeSetting.value ==
                                                  'isLight'
                                              ? theme_color.textColorLight[2]
                                              : theme_color.textColorDark[2],
                                    ),
                                  ),
                                  Text(
                                    'Proses Klaim',
                                    style: Get.textTheme.bodySmall!.copyWith(
                                      color:
                                          _themeController.themeSetting.value ==
                                                  'isLight'
                                              ? theme_color.textColorLight[2]
                                              : theme_color.textColorDark[2],
                                    ),
                                  ),
                                  Text(
                                    'Mitra Kami',
                                    style: Get.textTheme.bodySmall!.copyWith(
                                      color:
                                          _themeController.themeSetting.value ==
                                                  'isLight'
                                              ? theme_color.textColorLight[2]
                                              : theme_color.textColorDark[2],
                                    ),
                                  ),
                                  Text(
                                    'Produk Mitra Kami',
                                    style: Get.textTheme.bodySmall!.copyWith(
                                      color:
                                          _themeController.themeSetting.value ==
                                                  'isLight'
                                              ? theme_color.textColorLight[2]
                                              : theme_color.textColorDark[2],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // TextButton(
                        //     onPressed: () {
                        //       Get.toNamed(Routes.information);
                        //     },
                        //     child: const Text('To Information')),
                      ],
                    ),
                  ),

                  Text("Functions",
                      style: Get.textTheme.labelLarge!.copyWith(
                        color: _themeController.themeSetting.value == 'isLight'
                            ? theme_color.textColorLight[3]
                            : theme_color.textColorDark[3],
                      )),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
