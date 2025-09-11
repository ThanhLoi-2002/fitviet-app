import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/auth/domains/models/login_body.dart';
import 'package:fitness_client/features/auth/domains/models/login_response.dart';
import 'package:fitness_client/features/auth/domains/models/signup_body.dart';
import 'package:fitness_client/features/auth/domains/models/social_log_in_body.dart';
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

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.registerUri, signUpBody.toJson());
  }

  Future<ResponseModel> login(LoginBody loginBody) async {
    ResponseModel response = await apiClient.postData(AppConstants.loginUri, loginBody.toJson());
    if (response.isSuccess) {
      response.data = LoginResponse.fromJson(response.data);
      saveUserToken(response.data.accessToken);
    }
    return response;
  }

  Future<ResponseModel> loginWithSocialMedia(SocialLoginBodyModel socialLogInModel) async {
    ResponseModel response;
    if (socialLogInModel.loginType == 'google') {
      response = await apiClient.postData(AppConstants.loginGoogleUri, socialLogInModel.toJson());
    } else {
      response = await apiClient.postData(AppConstants.loginFacebookUri, socialLogInModel.toJson());
    }

    if (response.isSuccess) {
      response.data = LoginResponse.fromJson(response.data);
      saveUserToken(response.data.accessToken);
    }
    return response;
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  Future<void> saveUserAccount(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.userPassword, password);
      await sharedPreferences.setString(AppConstants.userPhone, number);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> clearUserAccount() async {
    await sharedPreferences.remove(AppConstants.userPassword);
    return await sharedPreferences.remove(AppConstants.userPhone);
  }

  String getUserToken() {
    String token = sharedPreferences.getString(AppConstants.token) ?? "";
    apiClient.token = token;
    apiClient.updateHeader(token);
    return token;
  }

  String getUserPhone() {
    return sharedPreferences.getString(AppConstants.userPhone) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.userPassword) ?? "";
  }
}
