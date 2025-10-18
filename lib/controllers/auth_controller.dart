import 'package:get/get.dart';
import 'package:saamba_demo/app_routing.dart';

class AuthController extends GetxController {
  final isLoggedIn = false.obs;
  // Hardcoded credentials per user request
  final String _username = 'Hassam';
  final String _password = 'Hassam@123';

  var isLogged = false.obs;
  var currentUser = RxnString();

  bool login(String username, String password) {
    // Simple hardcoded check
    if (username == _username && password == _password) {
      currentUser.value = username;
      isLogged.value = true;
      // navigate to home
      Get.offAllNamed(Routes.MAIN);
      return true;
    }
    return false;
  }

  void logout() {
    isLoggedIn.value = false;
    Get.offAllNamed(Routes.LOGIN);
  }
}
