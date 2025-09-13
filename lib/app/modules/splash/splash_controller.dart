import 'package:get/get.dart';
import '../../routes/app_pages.dart'; // For AppPages.INITIAL which will be home after splash

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Wait for a few seconds on the splash screen
    await Future.delayed(const Duration(seconds: 3));
    // Navigate to the Home screen, replacing the splash screen in the stack
    Get.offNamed(Routes.HOME);
  }
}
