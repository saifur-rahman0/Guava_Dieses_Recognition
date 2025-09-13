part of 'app_pages.dart'; // This will be the part of app_pages.dart

abstract class Routes {
  Routes._(); // Private constructor to prevent instantiation
  static const HOME = _Paths.HOME;
}

abstract class _Paths {
  _Paths._(); // Private constructor to prevent instantiation
  static const HOME = '/home';
}
