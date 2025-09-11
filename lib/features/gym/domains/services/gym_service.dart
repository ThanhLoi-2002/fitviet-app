import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/common/models/list_pagination_response.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/gym/domains/models/gym.dart';
import 'package:fitness_client/features/gym/domains/models/gym_filter.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GymService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  GymService({required this.sharedPreferences, required this.apiClient});

  Future<ResponseModel<ListPaginationResponse<Gym>>?> getAllGymByFilter(GymFilter filter) async {
    String query = '?';
    filter.toJson().forEach((key, value) {
      if (value != null) {
        query += '$key=$value&';
      }
    });
    String uri = AppConstants.getAllGymUri + query;

    ResponseModel response = await apiClient.getData(uri);
    if (response.isSuccess) {
      return ResponseModel<ListPaginationResponse<Gym>>.fromJson1(response.toJson(), (json) => ListPaginationResponse.fromJson(json, (json) => Gym.fromJson(json)));
    }
    return null;
  }
}
