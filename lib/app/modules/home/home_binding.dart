import 'package:get/get.dart';
import 'home_controller.dart'; // Will be created

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
