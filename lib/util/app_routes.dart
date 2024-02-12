import 'package:get/get.dart';
import '../adminpages/user_registration.dart';
import '../mainpages/dashboard.dart';
import '../mainpages/change_password.dart';
import '../mainpages/reset_password.dart';
import '../mainpages/registration.dart';
import '../binding/home_binding.dart';
import '../main.dart';
import '../mainpages/login.dart';


class AppPages {

  static final routes = [
    GetPage(name: '/', page: () => const InsuranceMart(), binding: HomeBinding(),),
    GetPage(name: '/login', page: ()=> const Login()),
    GetPage(name: '/registration', page: ()=> const Registration()),
    GetPage(name: '/reset', page: ()=> const ResetPassword()),
    GetPage(name: '/change/password', page: ()=> const ChangePassword()),
    GetPage(name: '/dashboard', page: ()=> const Dashboard()),
    GetPage(name: '/dashboard/registration', page: ()=> RegistrationForm()),
  ];

}