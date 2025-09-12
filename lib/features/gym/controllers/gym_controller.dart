import 'package:fitness_client/common/models/list_pagination_response.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/gym/domains/models/gym.dart';
import 'package:fitness_client/features/gym/domains/models/gym_filter.dart';
import 'package:fitness_client/features/gym/domains/services/gym_service.dart';
import 'package:get/get.dart';

class GymController extends GetxController implements GetxService {
  final GymService gymService;
  GymController({required this.gymService});

  List<Gym>? _gyms;
  List<Gym>? get gyms => _gyms;

  Gym? _gym;
  Gym? get gym => _gym;

  GymFilter gymFilter = GymFilter();
  // int currentPage = 1;
  int totalPage = 0;

  Future<void> getAll() async {
    ResponseModel<ListPaginationResponse<Gym>>? result = await gymService.getAllGymByFilter(gymFilter);
    if (result != null && result.isSuccess) {
      if (_gyms == null) {
        _gyms = result.data!.data!;
      } else {
        _gyms!.addAll(result.data!.data!);
      }
    }

    update();
  }

  Future<void> getGymById(String id) async {
    _gym = await gymService.getGymById(id);
    update();
  }

  Future<void> tabChanged(String value) async {
    
    update();
  }
}
