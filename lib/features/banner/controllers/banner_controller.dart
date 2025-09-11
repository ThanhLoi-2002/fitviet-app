import 'package:fitness_client/features/banner/domains/models/banner_model.dart';
import 'package:fitness_client/features/banner/domains/services/banner_service.dart';
import 'package:get/get.dart';

class BannerController extends GetxController implements GetxService {
  final BannerService bannerService;
  BannerController({required this.bannerService});

  List<BannerModel> _banners = [];
  List<BannerModel> get banners => _banners;

  bool isFirstFetch = true;

  Future<void> getAllBanner() async {
    _banners = await bannerService.getAllBanner(isFirstFetch);
    if (isFirstFetch) isFirstFetch = false;
    update();
  }
}
