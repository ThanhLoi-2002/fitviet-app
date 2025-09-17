import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/common/models/list_pagination_response.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/rating/domains/models/rating.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  RatingService({required this.sharedPreferences, required this.apiClient});

  Future<ResponseModel<ListPaginationResponse<Rating>>?> getAllRatingByGymId({required String gymId, required int limit, required int page}) async {
    String query = '?gymId=$gymId&limit=$limit&page=$page';
    String uri = AppConstants.getAllRatingUri + query;

    ResponseModel response = await apiClient.getData(uri);
    if (response.isSuccess) {
      return ResponseModel<ListPaginationResponse<Rating>>.fromJson1(response.toJson(), (json) => ListPaginationResponse.fromJson(json, (json) => Rating.fromJson(json)));
    }
    return null;
  }

  Future<ResponseModel<Rating>?> getRatingDetailByGymId({required String gymId}) async {
    String uri = '${AppConstants.getRatingDetailUri}/$gymId';

    ResponseModel response = await apiClient.getData(uri);
    if (response.isSuccess) {
      return ResponseModel<Rating>.fromJson1(response.toJson(), (json) => Rating.fromJson(json));
    }
    return null;
  }

  Future<bool> writeRating({required int rating, required String content, required String gymId}) async {
    String uri = AppConstants.createRatingUri;
    Map<String, dynamic> body = {"rating": rating, "content": content, "gymId": gymId};

    ResponseModel response = await apiClient.postData(uri, body);
    return response.isSuccess;
  }

  Future<bool> updateRating({required int rating, required String content, required String id}) async {
    String uri = AppConstants.updateRatingUri;
    Map<String, dynamic> body = {"rating": rating, "content": content, "id": id};

    ResponseModel response = await apiClient.postData(uri, body);
    return response.isSuccess;
  }
}
