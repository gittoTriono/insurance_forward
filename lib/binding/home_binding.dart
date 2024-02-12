import 'package:get/get.dart';
import '../bloc/login_controller.dart';

class HomeBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }

}