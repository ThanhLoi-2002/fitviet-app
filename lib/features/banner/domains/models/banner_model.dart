import 'package:fitness_client/features/banner/domains/enums/banner_enum.dart';
import 'package:fitness_client/features/gym/domains/models/gym.dart';

class BannerModel {
  String? id;
  String? url;
  String? logo;
  BannerStatus? status;
  Gym? gym;

  BannerModel({this.id, this.url, this.logo, this.status, this.gym});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id'],
      url: json['url'],
      logo: json['logo'],
      status: json['status'] != null ? BannerStatus.values.firstWhere((e) => e.value == json['status']) : null,
      gym: json['gym'] != null ? Gym.fromJson(json['gym']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'url': url, 'logo': logo, 'status': status?.value, 'gym': gym?.toJson()};
  }
}
