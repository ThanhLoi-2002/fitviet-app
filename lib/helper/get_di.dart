import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDi {
  static Future<void> init() async {
    /// Core
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);
    Get.lazyPut(
      () => ApiClient(
        appBaseUrl: AppConstants.baseUrl,
        sharedPreferences: Get.find(),
      ),
    );
  }
}
