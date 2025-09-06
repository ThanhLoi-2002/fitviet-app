import 'package:fitness_client/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SplashService({required this.apiClient, required this.sharedPreferences});

}