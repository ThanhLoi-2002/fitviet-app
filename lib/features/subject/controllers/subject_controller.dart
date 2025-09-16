import 'package:fitness_client/common/models/list_pagination_response.dart';
import 'package:fitness_client/common/models/response_model.dart';
import 'package:fitness_client/features/subject/domains/models/subject.dart';
import 'package:fitness_client/features/subject/domains/services/subject_service.dart';
import 'package:get/get.dart';

class SubjectController extends GetxController implements GetxService {
  final SubjectService subjectService;
  SubjectController({required this.subjectService});

  List<Subject> _subjects = [];
  List<Subject> get subjects => _subjects;

  Future<void> getAllsubject() async {
    ResponseModel<ListPaginationResponse<Subject>>? result = await subjectService.getAllSubject();
    if (result != null && result.isSuccess) {
      _subjects.addAll(result.data!.data!);
    }

    update();
  }
}
