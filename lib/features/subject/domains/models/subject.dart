import 'package:fitness_client/features/subject/domains/enums/subject_enum.dart';

class Subject {
  String? id;
  String? name;
  String? logo;
  SubjectStatus? status;

  Subject({this.id, this.name, this.logo, this.status});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(id: json['_id'], name: json['name'], logo: json['logo'], status: json['status'] != null ? SubjectStatus.values.firstWhere((e) => e.value == json['status']) : null);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'logo': logo, 'status': status?.value};
  }
}
