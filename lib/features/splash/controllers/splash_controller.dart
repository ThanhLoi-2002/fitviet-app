import 'package:fitness_client/features/splash/domains/services/splash_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController implements GetxService {
  final SplashService splashService;
  SplashController({required this.splashService});

  DateTime get currentTime => DateTime.now();
}