import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/features/auth/controllers/auth_controller.dart';
import 'package:fitness_client/features/auth/domains/services/auth_service.dart';
import 'package:fitness_client/features/profile/controllers/profile_controller.dart';
import 'package:fitness_client/features/profile/services/profile_service.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDi {
  static Future<void> init() async {
    /// Core
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);
    Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

    /// Service
    AuthService authService = AuthService(apiClient: Get.find(), sharedPreferences: Get.find());
    Get.lazyPut(() => authService);

    ProfileService profileService = ProfileService(apiClient: Get.find(), sharedPreferences: Get.find());
    Get.lazyPut(() => profileService);

    /// Controller
    Get.lazyPut(() => AuthController(authService: Get.find()));
    Get.lazyPut(() => ProfileController(profileService: Get.find()));
  }
}
