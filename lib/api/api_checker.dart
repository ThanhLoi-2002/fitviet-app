import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/common/widgets/custom_snackbar.dart';
import 'package:fitness_client/features/auth/controllers/auth_controller.dart';
import 'package:fitness_client/helper/route_helper.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(ResponseModel response, {bool getXSnackBar = false}) {
    if (response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData().then((value) {
        Get.offAllNamed(RouteHelper.signIn);
      });
    } else {
      showCustomSnackBar(response.message, getXSnackBar: getXSnackBar);
    }
  }
}
