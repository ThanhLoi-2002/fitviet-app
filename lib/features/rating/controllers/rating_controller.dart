import 'package:fitness_client/common/models/list_pagination_response.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/rating/domains/models/rating.dart';
import 'package:fitness_client/features/rating/domains/services/rating_service.dart';
import 'package:get/get.dart';

class RatingController extends GetxController implements GetxService {
  final RatingService ratingService;
  RatingController({required this.ratingService});

  List<Rating>? _ratings;
  List<Rating>? get ratings => _ratings;

  Rating? _rating;
  Rating? get rating => _rating;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<int>? _ratingList;
  List<int>? get ratingList => _ratingList;

  bool _isOutOfItem = false;
  bool get isOutOfItem => _isOutOfItem;

  int page = 0;

  Future<void> getAll({required String gymId, required int limit}) async {
    if (_isLoading || _isOutOfItem) return;
    _isLoading = true;
    page += 1;

    ResponseModel<ListPaginationResponse<Rating>>? result = await ratingService.getAllRatingByGymId(gymId: gymId, limit: limit, page: page);
    if (result != null && result.isSuccess) {
      if (_ratings == null) {
        _ratings = result.data!.data!;
      } else {
        _ratings!.addAll(result.data!.data!);
      }

      int totalPage = result.data!.totalPage!;
      if (page == totalPage) _isOutOfItem = true;

      _ratingList = result.data!.ratingList!;
    } else {
      _isOutOfItem = true; // Không còn dữ liệu để tải
    }
    _isLoading = false;

    update();
  }

  Future<void> getRatingDetailByGymId({required String gymId}) async {
    ResponseModel<Rating>? result = await ratingService.getRatingDetailByGymId(gymId: gymId);
    if (result != null && result.isSuccess && result.data != null) {
      _rating = result.data;
    } else {
      _rating = null;
    }
    update();
  }

  Future<bool> writeRating({required int rating, required String content, required String gymId}) async {
    _isLoading = true;
    update();

    bool isSuccess = await ratingService.writeRating(gymId: gymId, content: content, rating: rating);
    _isLoading = false;

    update();
    return isSuccess;
  }

  Future<bool> updateRating({required int rating, required String content}) async {
    _isLoading = true;
    update();

    bool isSuccess = await ratingService.updateRating(id: _rating!.id!, content: content, rating: rating);
    if (isSuccess) {
      _rating!.content = content;
      _rating!.rating = rating.toDouble();
    }
    _isLoading = false;

    update();
    return isSuccess;
  }

  void reset() {
    _ratings = [];
    page = 0;
    _isOutOfItem = false;
    _rating = null;
    update();
  }
}
