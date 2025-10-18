import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/fx_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<FXController>(() => FXController(), fenix: true);
  }
}
