import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/package/domains/models/package.dart';
import 'package:fitness_client/features/package/domains/services/package_service.dart';
import 'package:get/get.dart';

class PackageController extends GetxController implements GetxService {
  final PackageService packageService;
  PackageController({required this.packageService});

  List<Package> _packages = [];
  List<Package> get packages => _packages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Package? _package;
  Package? get package => _package;

  bool _isOutOfItem = false;
  bool get isOutOfItem => _isOutOfItem;

  int page = 0;

  Future<void> getAllPackage(String gymId) async {
    if (_isLoading || _isOutOfItem) return;
    _isLoading = true;
    page += 1;

    ResponseModel? response = await packageService.getAllPackage(gymId, page);
    if (response != null && response.isSuccess) {
      List<Package> list = List<Package>.from(response.data!.map((x) => Package.fromJson(x))).toList();
      _packages.addAll(list);

      int totalPage = response.metadata!.totalPages;
      if (page == totalPage) _isOutOfItem = true;
    } else {
      _isOutOfItem = true; // Không còn dữ liệu để tải
    }
    _isLoading = false;
    update();
  }

  Future<void> getPackageById(String id) async {
    _isLoading = true;

    ResponseModel? response = await packageService.getPackageById(id);
    if (response != null && response.isSuccess) {
      _package = Package.fromJson(response.data!);
    }

    _isLoading = false;
    update();
  }

  void reset() {
    page = 0;
    _isOutOfItem = false;
    _packages = [];
    _package = null;
    update();
  }
}
