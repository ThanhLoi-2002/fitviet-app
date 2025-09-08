import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/auth/domains/models/signup_body_model.dart';
import 'package:fitness_client/features/auth/repositories/auth_repository.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class AuthService {
  final AuthRepository authRepository;
  AuthService({required this.authRepository});

  Future<bool> clearSharedData() async {
    return await authRepository.clearSharedData();
  }

  Future<ResponseModel> registration(SignUpBodyModel signUpBody) async {
    Response response = await authRepository.registration(signUpBody);
    return ResponseModel(isSuccess: response.statusCode == 200, message: response.statusText);
  }
}
