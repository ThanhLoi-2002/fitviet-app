import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/common/models/response_list_model.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/convenience/domains/models/convenience.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConvenienceService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ConvenienceService({required this.sharedPreferences, required this.apiClient});

  Future<ResponseListModel<Convenience>?> getAllConvenience(String type) async {
    String uri = '${AppConstants.getAllConvenienceUri}?type=$type';

    ResponseModel response = await apiClient.getData(uri);
    if (response.isSuccess) {
      // List<Convenience> list = List<Convenience>.from(response.data);
      return ResponseListModel<Convenience>.fromJson(response.toJson(), List<Convenience>.from(response.data.map((x) => Convenience.fromJson(x))));
    }
    return null;
  }
}
