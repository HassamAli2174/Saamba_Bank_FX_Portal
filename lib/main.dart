import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saamba_demo/app_routing.dart';
import 'package:saamba_demo/binding/initial_binding.dart';
import 'package:saamba_demo/controllers/main_nav_controller.dart';
// import 'package:saamba_demo/pages/login_page.dart';
// import 'package:saamba_demo/pages/main_nav_page.dart';
import 'controllers/auth_controller.dart';
import 'controllers/fx_controller.dart';

void main() {
  Get.put(AuthController(), permanent: true);
  Get.put(FXController(), permanent: true);
  Get.put(MainNavController(), permanent: true);
  runApp(SambaFXApp());
}

class SambaFXApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Samba FX Portal',
      theme: ThemeData(
        primaryColor: const Color(0xFF0D47A1),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D47A1)),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D47A1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
      initialBinding: InitialBinding(),
      initialRoute: Routes.SPLASH,
      // getPages: [
      //   GetPage(name: Routes.LOGIN, page: () => LoginPage()),
      //   GetPage(name: Routes.HOME, page: () => MainNavPage()),
      // ],
      getPages: AppPages.pages,
    );
  }
}
