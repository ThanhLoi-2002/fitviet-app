import 'package:fitness_client/features/auth/domains/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthService authService;
  AuthController({required this.authService});

  Future<bool> clearSharedData() async {
    return await authService.clearSharedData();
  }
}
