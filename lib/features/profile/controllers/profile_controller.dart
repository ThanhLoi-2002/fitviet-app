import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/profile/domains/models/change_password.dart';
import 'package:fitness_client/features/profile/domains/models/client.dart';
import 'package:fitness_client/features/profile/domains/models/update_profile.dart';
import 'package:fitness_client/features/profile/domains/services/profile_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileService profileService;
  ProfileController({required this.profileService});

  Client? _client;
  Client? get client => _client;

  XFile? _pickedFile = null;
  XFile? get pickedFile => _pickedFile;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getMyInfo() async {
    ResponseModel response = await profileService.getMyInfo();
    if (response.isSuccess) {
      _client = Client.fromJson(response.data);
    }
    update();
  }

  Future<ResponseModel> updateProfile(UpdateProfile updateClient) async {
    _isLoading = true;
    update();

    ResponseModel response = await profileService.updateProfile(updateClient, _pickedFile);
    if (response.isSuccess) {
      _client = Client.fromJson(response.data);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<ResponseModel> changePassword(ChangePassword changePassword) async {
    _isLoading = true;
    update();
    ResponseModel responseModel = await profileService.changePassword(changePassword);
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> forgotPassword(String email) async {
    _isLoading = true;
    update();
    ResponseModel responseModel = await profileService.forgotPassword(email);
    _isLoading = false;
    update();
    return responseModel;
  }

  void pickImage() async {
    _pickedFile = await profileService.pickImageFromGallery();
    update();
  }

  void clearUserInfo() {
    _client = null;
    update();
  }
}
