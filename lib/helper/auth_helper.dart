import 'package:fitness_client/features/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthHelper {
  static bool isLoggedIn() {
    return Get.find<AuthController>().isLoggedIn();
  }
}
