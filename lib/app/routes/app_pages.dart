import 'package:get/get.dart';

import '../modules/home/home_binding.dart'; // Will be created
import '../modules/home/home_view.dart';     // Will be created

part 'app_routes.dart'; // Defines the Routes and _Paths classes

class AppPages {
  AppPages._(); // Private constructor to prevent instantiation

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
