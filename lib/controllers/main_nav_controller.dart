// lib/controllers/main_nav_controller.dart
import 'package:get/get.dart';

class MainNavController extends GetxController {
  final selectedIndex = 0.obs;

  void setIndex(int idx) => selectedIndex.value = idx;
}
