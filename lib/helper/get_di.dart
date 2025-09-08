import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/features/auth/controllers/auth_controller.dart';
import 'package:fitness_client/features/auth/domains/services/auth_service.dart';
import 'package:fitness_client/features/auth/repositories/auth_repository.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDi {
  static Future<void> init() async {
    /// Core
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);
    Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

    /// Repository
    AuthRepository authRepository = AuthRepository(apiClient: Get.find(), sharedPreferences: Get.find());
    Get.lazyPut(() => authRepository);

    /// Service
    AuthService authServiceInterface = AuthService(authRepository: Get.find());
    Get.lazyPut(() => authServiceInterface);

    /// Controller
    Get.lazyPut(() => AuthController(authService: Get.find()));
  }
}
