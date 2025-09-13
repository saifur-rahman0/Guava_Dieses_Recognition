import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/splash/splash_binding.dart'; // Import SplashBinding
import '../modules/splash/splash_view.dart';   // Import SplashView

part 'app_routes.dart';

class AppPages {
  AppPages._(); // Private constructor to prevent instantiation

  static const INITIAL = Routes.SPLASH; // Update initial route to Splash

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
