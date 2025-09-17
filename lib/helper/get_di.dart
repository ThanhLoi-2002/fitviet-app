import 'package:fitness_client/api/api_client.dart';
import 'package:fitness_client/features/address/controllers/address_controller.dart';
import 'package:fitness_client/features/address/domains/services/address_service.dart';
import 'package:fitness_client/features/auth/controllers/auth_controller.dart';
import 'package:fitness_client/features/auth/domains/services/auth_service.dart';
import 'package:fitness_client/features/banner/controllers/banner_controller.dart';
import 'package:fitness_client/features/banner/domains/services/banner_service.dart';
import 'package:fitness_client/features/convenience/controllers/convenience_controller.dart';
import 'package:fitness_client/features/convenience/domains/services/convenience_service.dart';
import 'package:fitness_client/features/gym/controllers/gym_controller.dart';
import 'package:fitness_client/features/gym/domains/services/gym_service.dart';
import 'package:fitness_client/features/package/controllers/package_controller.dart';
import 'package:fitness_client/features/package/domains/services/package_service.dart';
import 'package:fitness_client/features/profile/controllers/profile_controller.dart';
import 'package:fitness_client/features/profile/services/profile_service.dart';
import 'package:fitness_client/features/rating/controllers/rating_controller.dart';
import 'package:fitness_client/features/rating/domains/services/rating_service.dart';
import 'package:fitness_client/features/subject/controllers/subject_controller.dart';
import 'package:fitness_client/features/subject/domains/services/subject_service.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDi {
  static Future<void> init() async {
    /// Core
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);
    Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

    /// Service
    AuthService authService = AuthService(apiClient: Get.find(), sharedPreferences: Get.find());
    Get.lazyPut(() => authService);

    GymService gymService = GymService(apiClient: Get.find(), sharedPreferences: Get.find());
    Get.lazyPut(() => gymService);

    BannerService bannerService = BannerService(apiClient: Get.find(), sharedPreferences: Get.find());
    Get.lazyPut(() => bannerService);

    RatingService ratingService = RatingService(apiClient: Get.find(), sharedPreferences: Get.find());
    Get.lazyPut(() => ratingService);

    AddressService addressService = AddressService(apiClient: Get.find(), sharedPreferences: Get.find());
    Get.lazyPut(() => addressService);

    ProfileService profileService = ProfileService(apiClient: Get.find(), sharedPreferences: Get.find());
    Get.lazyPut(() => profileService);

    ConvenienceService convenienceService = ConvenienceService(apiClient: Get.find(), sharedPreferences: Get.find());
    Get.lazyPut(() => convenienceService);

    SubjectService subjectService = SubjectService(apiClient: Get.find(), sharedPreferences: Get.find());
    Get.lazyPut(() => subjectService);

    PackageService packageService = PackageService(apiClient: Get.find(), sharedPreferences: Get.find());
    Get.lazyPut(() => packageService);

    /// Controller
    Get.lazyPut(() => AuthController(authService: Get.find()));
    Get.lazyPut(() => ProfileController(profileService: Get.find()));
    Get.lazyPut(() => RatingController(ratingService: Get.find()));
    Get.lazyPut(() => AddressController(addressService: Get.find()));
    Get.lazyPut(() => BannerController(bannerService: Get.find()));
    Get.lazyPut(() => GymController(gymService: Get.find(), addressService: Get.find()));
    Get.lazyPut(() => ConvenienceController(convenienceService: Get.find()));
    Get.lazyPut(() => SubjectController(subjectService: Get.find()));
    Get.lazyPut(() => PackageController(packageService: Get.find()));
  }
}
