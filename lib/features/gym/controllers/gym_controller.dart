import 'package:fitness_client/common/models/list_pagination_response.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/address/controllers/address_controller.dart';
import 'package:fitness_client/features/gym/domains/models/gym.dart';
import 'package:fitness_client/features/gym/domains/models/gym_filter.dart';
import 'package:fitness_client/features/gym/domains/services/gym_service.dart';
import 'package:get/get.dart';

class GymController extends GetxController implements GetxService {
  final GymService gymService;
  GymController({required this.gymService});

  List<Gym>? _gyms;
  List<Gym>? get gyms => _gyms;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Gym? _gym;
  Gym? get gym => _gym;

  GymFilter _gymFilter = GymFilter(
    basicConvenience: [],
    highClassConvenience: [],
    subjects: [],
    rating: 0,
    toDistance: 100,
    fromDistance: 0,
    fromPrice: 0,
    toPrice: 0,
    favoriteConvenience: [],
    safeConvenience: [],
  );
  GymFilter get gymFilter => _gymFilter;

  bool _isOutOfItem = false;
  bool get isOutOfItem => _isOutOfItem;

  Future<void> getAll() async {
    if (_isLoading || _isOutOfItem) return;
    _isLoading = true;
    _gymFilter.page = _gymFilter.page! + 1;
    // update();

    ResponseModel<ListPaginationResponse<Gym>>? result = await gymService.getAllGymByFilter(_gymFilter);
    if (result != null && result.isSuccess) {
      if (_gyms == null) {
        _gyms = result.data!.data!;
      } else {
        _gyms!.addAll(result.data!.data!);
      }

      int totalPage = result.data!.totalPage!;
      if (_gymFilter.page == totalPage) _isOutOfItem = true;
    } else {
      _isOutOfItem = true; // Không còn dữ liệu để tải
    }
    _isLoading = false;

    update();
  }

  Future<void> getGymById(String id) async {
    _gym = await gymService.getGymById(id);
    update();
  }

  void resetGymNull() {
    _gym = null;
    update();
  }

  Future<void> tabChanged(int index) async {
    resetFilter();
    if (index == 1) {
      // tìm theo gần vị trí
      _gymFilter.long = Get.find<AddressController>().getLongitude();
      _gymFilter.lat = Get.find<AddressController>().getLatitude();
    }

    getAll();
  }

  void updateFilter({
    String? search,
    double? long,
    double? lat,
    String? sortBy,
    int? sortDirection,
    List<String>? subjects,
    List<String>? basicConvenience,
    List<String>? favoriteConvenience,
    List<String>? highClassConvenience,
    List<String>? safeConvenience,
    double? rating,
    // double? fromPrice,
    double? toPrice,
    // double? fromDistance,
    double? toDistance,
    bool? isOutOfItem,
  }) {
    _gymFilter.search = search;
    if (basicConvenience != null) {
      _gymFilter.basicConvenience = basicConvenience;
    }

    if (favoriteConvenience != null) {
      _gymFilter.favoriteConvenience = favoriteConvenience;
    }

    if (safeConvenience != null) {
      _gymFilter.safeConvenience = safeConvenience;
    }

    if (highClassConvenience != null) {
      _gymFilter.highClassConvenience = highClassConvenience;
    }

    if (subjects != null) {
      _gymFilter.subjects = subjects;
    }

    if (rating != null) {
      _gymFilter.rating = rating;
    }

    if (toPrice != null) {
      _gymFilter.toPrice = toPrice;
    }

    if (toDistance != null) {
      _gymFilter.toDistance = toDistance;
      _gymFilter.long = Get.find<AddressController>().getLongitude();
      _gymFilter.lat = Get.find<AddressController>().getLatitude();
    }

    if (isOutOfItem != null) {
      _isOutOfItem = isOutOfItem;
    }
    update();
  }

  void resetFilter({bool isResetAll = true}) {
    _gyms = [];
    if (isResetAll) {
      _gymFilter = GymFilter(
        basicConvenience: [],
        highClassConvenience: [],
        subjects: [],
        rating: 0,
        toDistance: 100,
        fromDistance: 0,
        fromPrice: 0,
        toPrice: 0,
        favoriteConvenience: [],
        safeConvenience: [],
      );
    } else {
      _gymFilter.page = 0;
    }

    _isOutOfItem = false;
    update();
  }

  // dùng cho nút reset
  void initFilter() {
    _gymFilter = GymFilter(
      basicConvenience: [],
      highClassConvenience: [],
      subjects: [],
      rating: 0,
      toDistance: 100,
      fromDistance: 0,
      fromPrice: 0,
      toPrice: 0,
      favoriteConvenience: [],
      safeConvenience: [],
    );
    update();
  }
}
