import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/features/auth/domains/models/signup_body_model.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepository({required this.sharedPreferences, required this.apiClient});

  Future<bool> clearSharedData() async {
    apiClient.token = null;
    sharedPreferences.remove(AppConstants.token);
    return true;
  }

  Future<Response> registration(SignUpBodyModel signUpBody) async {
    return await apiClient.postData(AppConstants.registerUri, signUpBody.toJson(), handleError: false);
  }

}
