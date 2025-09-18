import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/common/widgets/custom_snackbar.dart';
import 'package:fitness_client/features/profile/domains/models/change_password.dart';
import 'package:fitness_client/features/profile/domains/models/update_profile.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ProfileService({required this.sharedPreferences, required this.apiClient});

  Future<ResponseModel> getMyInfo() async {
    return await apiClient.getData(AppConstants.getMeUri);
  }

  Future<ResponseModel> updateProfile(UpdateProfile updateClient, XFile? data) async {
    return await apiClient.postMultipartData(AppConstants.updateProfileUri, updateClient.toJson(), [MultipartBody('avatar', data)]);
  }

  Future<ResponseModel> changePassword(ChangePassword changePassword) async {
    return await apiClient.postData(AppConstants.resetPasswordUri, changePassword.toJson());
  }

  Future<ResponseModel> forgotPassword(String email) async {
    return await apiClient.postData(AppConstants.forgotPasswordUri, {"email": email});
  }

  Future<XFile?> pickImageFromGallery() async {
    XFile? pickedFile;
    XFile? pickLogo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickLogo != null) {
      await pickLogo.length().then((value) {
        if (value > 1000000) {
          showCustomSnackBar('Vui lòng upload file có kích thước nhỏ hơn');
        } else {
          pickedFile = pickLogo;
        }
      });
    }
    return pickedFile;
  }
}
