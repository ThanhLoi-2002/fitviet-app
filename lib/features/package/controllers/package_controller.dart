import 'package:fitness_client/features/package/domains/models/package.dart';
import 'package:fitness_client/features/package/domains/services/package_service.dart';
import 'package:get/get.dart';

class PackageController extends GetxController implements GetxService {
  final PackageService packageService;
  PackageController({required this.packageService});

  List<Package> _packages = [];
  List<Package> get packages => _packages;

  bool isFirstFetch = true;

  Future<void> getAllPackage(String gymId) async {
    // _packages = await packageService.getAllPackage(gymId);
    update();
  }
}
