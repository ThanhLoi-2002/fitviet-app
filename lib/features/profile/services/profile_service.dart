import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ProfileService({required this.sharedPreferences, required this.apiClient});

  Future<ResponseModel> getMyInfo() async {
    return await apiClient.getData(AppConstants.getMeUri);
  }
}
