import 'package:fitness_client/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  RatingService({required this.sharedPreferences, required this.apiClient});
  
  
}
