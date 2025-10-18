import 'package:get/get.dart';
import 'package:saamba_demo/pages/rates_page.dart';
import 'pages/login_page.dart';
import 'pages/main_nav_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';
import 'pages/splash_screen.dart';

class Routes {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const MAIN = '/main';
  static const PROFILE = '/profile';
  static const SETTINGS = '/settings';
  static const RATES = '/rates';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.SPLASH, page: () => const SplashScreen()),
    GetPage(name: Routes.LOGIN, page: () => LoginPage()),
    GetPage(name: Routes.MAIN, page: () => MainNavPage()),
    GetPage(name: Routes.PROFILE, page: () => ProfilePage()),
    GetPage(name: Routes.SETTINGS, page: () => SettingsPage()),
    GetPage(name: Routes.RATES, page: () => FXRatesPage()),
  ];
}
