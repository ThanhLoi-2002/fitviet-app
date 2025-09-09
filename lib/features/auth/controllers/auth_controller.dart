import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/auth/domains/models/login_body_model.dart';
import 'package:fitness_client/features/auth/domains/models/signup_body_model.dart';
import 'package:fitness_client/features/auth/domains/models/social_log_in_body.dart';
import 'package:fitness_client/features/auth/domains/services/auth_service.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController implements GetxService {
  final AuthService authService;
  AuthController({required this.authService});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isActiveRememberMe = false;
  bool get isActiveRememberMe => _isActiveRememberMe;

  Future<bool> clearSharedData() async {
    return await authService.clearSharedData();
  }

  Future<ResponseModel> registration(SignUpBodyModel signUpBody) async {
    _isLoading = true;
    update();
    ResponseModel responseModel = await authService.registration(signUpBody);
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(LoginBodyModel loginBodyModel) async {
    _isLoading = true;
    update();
    ResponseModel responseModel = await authService.login(loginBodyModel);
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> loginWithSocialMedia(SocialLogInBody socialLogInBody) async {
    _isLoading = true;
    update();
    ResponseModel responseModel = await authService.loginWithSocialMedia(socialLogInBody);
    // _getUserAndCartData(responseModel);
    _isLoading = false;
    update();
    return responseModel;
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  void saveUserAccount(String emailOrPhone, String password) {
    authService.saveUserAccount(emailOrPhone, password);
  }

  Future<bool> clearUserAccount() async {
    return authService.clearUserAccount();
  }

  String getUserEmailOrPhone() {
    return authService.getUserEmailOrPhone();
  }

  String getUserPassword() {
    return authService.getUserPassword();
  }

  String getUserToken() {
    return authService.getUserToken();
  }

  bool isLoggedIn() {
    return authService.isLoggedIn();
  }

  Future<void> socialLogout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    await FacebookAuth.instance.logOut();
  }
}
