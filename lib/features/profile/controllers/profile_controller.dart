import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/profile/domains/models/client.dart';
import 'package:fitness_client/features/profile/services/profile_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileService profileService;
  ProfileController({required this.profileService});

  Client? _client;
  Client? get client => _client;

  Future<void> getMyInfo() async {
    ResponseModel response = await profileService.getMyInfo();
    if (response.isSuccess) {
      _client = Client.fromJson(response.data);
    }
    update();
  }

  void clearUserInfo() {
    _client = null;
    update();
  }
}
