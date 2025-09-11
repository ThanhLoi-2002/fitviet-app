import 'dart:convert';

import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/banner/domains/models/banner_model.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BannerService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  BannerService({required this.sharedPreferences, required this.apiClient});

  Future<List<BannerModel>> getAllBanner(bool isFirstFetch) async {
    List<BannerModel> banners = [];
    String uri = AppConstants.getAllBannerUri;

    if (isFirstFetch) {
      ResponseModel response = await apiClient.getData(uri);
      if (response.isSuccess) {
        banners = (response.data['data'] as List).map((banner) => BannerModel.fromJson(banner)).toList();
        await sharedPreferences.setString(uri, jsonEncode(banners));
      }
    } else {
      String? cachedData = sharedPreferences.getString(uri);
      if (cachedData != null) {
        List<dynamic> jsonList = jsonDecode(cachedData);
        banners = jsonList.map((json) => BannerModel.fromJson(json)).toList();
      }
    }
    return banners;
  }
}
