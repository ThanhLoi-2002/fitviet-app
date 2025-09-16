// ignore_for_file: prefer_final_fields

import 'package:fitness_client/common/models/response_list_model.dart';
import 'package:fitness_client/features/convenience/domains/enums/convenience_enum.dart';
import 'package:fitness_client/features/convenience/domains/models/convenience.dart';
import 'package:fitness_client/features/convenience/domains/services/convenience_service.dart';
import 'package:get/get.dart';

class ConvenienceController extends GetxController implements GetxService {
  final ConvenienceService convenienceService;
  ConvenienceController({required this.convenienceService});

  List<Convenience> _basicConveniences = [];
  List<Convenience> get basicConveniences => _basicConveniences;

  List<Convenience> _favoriteConveniences = [];
  List<Convenience> get favoriteConveniences => _favoriteConveniences;

  List<Convenience> _safeConveniences = [];
  List<Convenience> get safeConveniences => _safeConveniences;

  List<Convenience> _highClassConveniences = [];
  List<Convenience> get highClassConveniences => _highClassConveniences;

  Future<void> getAllConvenience(String type) async {
    ResponseListModel<Convenience>? result = await convenienceService.getAllConvenience(type);
    if (result != null && result.isSuccess) {
      if (type == ConvenienceType.basic.value) {
        _basicConveniences.addAll(result.data!);
      }
      if (type == ConvenienceType.favorite.value) {
        _favoriteConveniences.addAll(result.data!);
      }
      if (type == ConvenienceType.safe.value) {
        _safeConveniences.addAll(result.data!);
      }
      if (type == ConvenienceType.highClass.value) {
        _highClassConveniences.addAll(result.data!);
      }
    }

    update();
  }
}
