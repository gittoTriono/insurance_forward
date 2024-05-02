import 'package:get/get.dart';
import 'package:insurance/mainpages/Sppa%20Recap/recap_sppa_detail.dart';
import 'package:insurance/mainpages/Sppa%20Recap/recap_sppa_view.dart';
import 'package:insurance/mainpages/Sppa/hitung_premi.dart';
import 'package:insurance/mainpages/Sppa/sppa_main.dart';
import 'package:insurance/mainpages/Sppa/sppa_perluasan.dart';
import 'package:insurance/mainpages/Sppa/ternak.dart';
import 'package:insurance/mainpages/Sppa/sppa_add_info.dart';
import 'package:insurance/mainpages/Sppa/sppa_batal.dart';
import 'package:insurance/mainpages/Sppa/sppa_detail.dart';
import 'package:insurance/mainpages/Sppa/sppa_submit.dart';
import 'package:insurance/mainpages/Sppa/ternak_form.dart';
import 'package:insurance/mainpages/Sppa/ternak_foto.dart';
import 'package:insurance/mainpages/dashboard.dart';
import 'package:insurance/mainpages/polis/polis_detail.dart';
import 'package:insurance/mainpages/polis/polis_main.dart';
import 'package:insurance/mainpages/polis/polis_view.dart';
import 'package:insurance/mainpages/product/produk_detail.dart';
import 'package:insurance/mainpages/profile/kandang_form.dart';
import 'package:insurance/mainpages/profile/profile_customer.dart';
import 'package:insurance/mainpages/profile/profile_peternak.dart';
import 'package:insurance/model/sppa_perluasan.dart';
import 'package:insurance/model/sppa_recap.dart';
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
    GetPage(name: '/login', page: () => const Login()),
    GetPage(name: '/registration', page: () => const Registration()),
    GetPage(name: '/reset', page: () => const ResetPassword()),
    GetPage(name: '/change/password', page: () => const ChangePassword()),
    GetPage(name: '/dashboard', page: () => const Dashboard()),
    GetPage(name: '/dashboard/registration', page: () => RegistrationForm()),
    GetPage(name: '/dashboard/ProdukDetail', page: () => ProdukDetail()),
    GetPage(name: '/profile', page: () => ProfileCustomer()),
    GetPage(name: '/profile/kandang', page: () => ProfilePeternak()),
    GetPage(name: '/kandang/form', page: () => FormKandang()),
    GetPage(name: '/sppa', page: () => const SppaView()),
    GetPage(name: '/sppa/sppaDetail', page: () => const SppaDetail()),
    GetPage(name: '/sppa/sppaDetail/hitungPremi', page: () => HitungPremi()),
    GetPage(name: '/sppa/main', page: () => SppaMaintenance()),
    GetPage(name: '/sppa/perluasan', page: () => SppaPerluasan()),
    GetPage(name: '/sppa/addInfo', page: () => SppaAddInfo()),
    GetPage(name: '/sppa/ternaklist', page: () => TernakSppa()),
    GetPage(name: '/sppa/ternakform', page: () => TernakForm()),
    GetPage(name: '/sppa/ternakfoto', page: () => TernakFoto()),
    GetPage(name: '/recapSppa', page: () => RecapSppaView()),
    GetPage(
        name: '/recapSppa/recapSppaDetail',
        page: () => const RecapSppaDetailView()),
    GetPage(name: '/polis/main', page: () => const PolisMaintenance()),
    GetPage(name: '/polis', page: () => PolisView()),
    GetPage(name: '/polis/polisDetail', page: () => const PolisDetail()),
    // GetPage(
    //     name: '/dashboard/sppaDetail/submit', page: () => const SppaSubmit()),
  ];
}
