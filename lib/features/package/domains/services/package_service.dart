
import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/common/models/response_list_model.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/package/domains/models/package.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  PackageService({required this.sharedPreferences, required this.apiClient});

  Future<ResponseListModel<List<Package>>?> getAllPackage(String gymId) async {
    String uri = AppConstants.getAllPackageUri;

    ResponseModel response = await apiClient.getData(uri);
    if (response.isSuccess) {
      // return ResponseListModel<List<Package>>.fromJson(response.toJson(), (json) => );
    }
    return null;
  }
}
