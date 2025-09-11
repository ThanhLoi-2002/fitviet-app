import 'package:fitness_client/features/rating/domains/models/rating.dart';
import 'package:fitness_client/features/rating/domains/services/rating_service.dart';
import 'package:get/get.dart';

class RatingController extends GetxController implements GetxService {
  final RatingService ratingService;
  RatingController({required this.ratingService});

  List<Rating>? _ratings;
  List<Rating>? get ratings => _ratings;
}
