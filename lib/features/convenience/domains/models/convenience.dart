import 'package:fitness_client/features/convenience/domains/enums/convenience_enum.dart';
import 'package:fitness_client/features/gym/domains/models/gym.dart';

class Convenience {
  String? id;
  String? name;
  ConvenienceType? type;
  String? logo;
  ConvenienceStatus? status;
  double? price;
  Gym? gym;

  Convenience({this.id, this.name, this.type, this.logo, this.status, this.price, this.gym});

  factory Convenience.fromJson(Map<String, dynamic> json) {
    return Convenience(
      id: json['_id'],
      name: json['name'],
      type: json['type'] != null ? ConvenienceType.values.firstWhere((e) => e.value == json['type']) : null,
      logo: json['logo'],
      status: json['status'] != null ? ConvenienceStatus.values.firstWhere((e) => e.value == json['status']) : null,
      price: json['price'],
      gym: json['gym'] != null ? Gym.fromJson(json['gym']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'type': type?.value, 'logo': logo, 'status': status?.value, 'price': price, 'gym': gym?.toJson()};
  }
}
