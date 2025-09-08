import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/auth/domains/models/signup_body_model.dart';
import 'package:fitness_client/features/auth/domains/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthService authService;
  AuthController({required this.authService});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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
}
