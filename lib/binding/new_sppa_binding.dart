import 'package:get/get.dart';
import 'package:insurance/bloc/sppa_controller.dart';
import 'package:insurance/bloc/ternak_controller.dart';

class SppaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SppaHeaderController());
    Get.lazyPut(() => TernakController());
  }
}
