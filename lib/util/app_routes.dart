import 'package:get/get.dart';
import 'package:insurance/mainpages/Sppa/sppa_main.dart';
import 'package:insurance/mainpages/Sppa/ternak.dart';
import 'package:insurance/mainpages/Sppa/sppa_add_info.dart';
import 'package:insurance/mainpages/Sppa/sppa_batal.dart';
import 'package:insurance/mainpages/Sppa/sppa_detail.dart';
import 'package:insurance/mainpages/Sppa/sppa_submit.dart';
import 'package:insurance/mainpages/Sppa/ternak_form.dart';
import 'package:insurance/mainpages/Sppa/ternak_foto.dart';
import 'package:insurance/mainpages/dashboard.dart';
import 'package:insurance/mainpages/produk_detail.dart';
import '../adminpages/user_registration.dart';
import '../mainpages/Sppa/sppa_view.dart';
import '../mainpages/change_password.dart';
import '../mainpages/reset_password.dart';
import '../mainpages/registration.dart';
import '../binding/home_binding.dart';
import '../main.dart';
import '../mainpages/login.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/',
      page: () => const InsuranceMart(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => const Dashboard(),
    ),
    GetPage(name: '/login', page: () => const Login()),
    GetPage(name: '/registration', page: () => const Registration()),
    GetPage(name: '/reset', page: () => const ResetPassword()),
    GetPage(name: '/change/password', page: () => const ChangePassword()),
    GetPage(name: '/dashboard/registration', page: () => RegistrationForm()),
    GetPage(name: '/dashboard/ProdukDetail', page: () => ProdukDetail()),
    GetPage(name: '/sppa', page: () => const SppaView()),
    GetPage(name: '/sppa/sppaDetail', page: () => const SppaDetail()),
    GetPage(name: '/sppa/main', page: () => SppaMaintenance()),
    GetPage(name: '/sppa/addInfo', page: () => SppaAddInfo()),
    GetPage(name: '/sppa/ternaklist', page: () => TernakSppa()),
    GetPage(name: '/sppa/ternakform', page: () => TernakForm()),
    GetPage(name: '/sppa/ternakfoto', page: () => TernakFoto()),
    // GetPage(
    //     name: '/dashboard/sppaDetail/edit/addInfo',
    //     page: () => const SppaEditAddInfo()),
    // GetPage(
    //     name: '/dashboard/sppaDetail/edit/ternak',
    //     page: () => const SppaEditTernak()),
    // GetPage(
    //     name: '/dashboard/sppaDetail/edit/ternak/form',
    //     page: () => const SppaEditTernakForm()),
    // GetPage(
    //     name: '/dashboard/sppaDetail/edit/ternak/foto',
    //     page: () => const SppaEditTernakFoto()),
    // GetPage(name: '/dashboard/sppaDetail/batal', page: () => const SppaBatal()),
    // GetPage(
    //     name: '/dashboard/sppaDetail/submit', page: () => const SppaSubmit()),
  ];
}
