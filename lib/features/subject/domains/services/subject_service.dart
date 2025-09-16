import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/common/models/list_pagination_response.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/subject/domains/models/subject.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubjectService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SubjectService({required this.sharedPreferences, required this.apiClient});

  Future<ResponseModel<ListPaginationResponse<Subject>>?> getAllSubject() async {
    String uri = '${AppConstants.getAllSubjectUri}?limit=1000';

    ResponseModel response = await apiClient.getData(uri);
    if (response.isSuccess) {
      return ResponseModel<ListPaginationResponse<Subject>>.fromJson1(response.toJson(), (json) => ListPaginationResponse.fromJson(json, (json)=> Subject.fromJson(json)));
    }
    return null;
  }
}
