import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthService({required this.sharedPreferences, required this.apiClient});

  Future<bool> clearSharedData() async {
    apiClient.token = null;
    sharedPreferences.remove(AppConstants.token);
    return true;
  }
}
