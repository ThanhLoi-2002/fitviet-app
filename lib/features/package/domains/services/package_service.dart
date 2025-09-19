import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  PackageService({required this.sharedPreferences, required this.apiClient});

  Future<ResponseModel?> getAllPackage(String gymId, int page) async {
    String uri = '${AppConstants.getAllPackageUri}/$gymId?page=$page&limit=10';
    return await apiClient.getData(uri);
  }

  Future<ResponseModel?> getPackageById(String id) async {
    String uri = '${AppConstants.getPackageByIdUri}/$id';

    return await apiClient.getData(uri);
  }
}
