import 'package:fitness_client/features/package/domains/models/package.dart';
import 'package:fitness_client/features/profile/domains/models/client.dart';
import 'package:fitness_client/features/gym/domains/models/gym.dart';

class ClientPackage {
  String? id;
  Client? user;
  Gym? gym;
  Package? package;
  DateTime? startDate;
  int? totalCheckins;

  ClientPackage({this.id, this.user, this.gym, this.package, this.startDate, this.totalCheckins});

  factory ClientPackage.fromJson(Map<String, dynamic> json) {
    return ClientPackage(
      id: json['_id'] as String?,
      user: json['user'] != null ? Client.fromJson(json['user']) : null,
      package: json['package'] != null ? Package.fromJson(json['package']) : null,
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      totalCheckins: json['totalCheckins'] as int?,
      gym: json['gym'] != null ? Gym.fromJson(json['gym']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'user': user?.toJson(), 'package': package?.toJson(), 'startDate': startDate?.toIso8601String(), 'totalCheckins': totalCheckins, 'gym': gym?.toJson()};
  }
}
