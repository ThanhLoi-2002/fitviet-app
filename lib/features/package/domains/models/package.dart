import 'package:fitness_client/features/convenience/domains/models/convenience.dart';
import 'package:fitness_client/features/package/domains/enums/packag_enum.dart';

class Package {
  String? id;
  String? name;
  String? description;
  double? price;
  PackageTimePeriodType? timePeriodType;
  double? totalSessions;
  int? duration;
  PackageStatus? status;
  List<String>? images;
  double? promotionalPrice;
  PackageType? type;
  List<Convenience>? conveniences;
  String? gym;

  Package({
    this.id,
    this.name,
    this.description,
    this.price,
    this.timePeriodType,
    this.totalSessions,
    this.duration,
    this.status,
    this.images,
    this.promotionalPrice,
    this.type,
    this.conveniences,
    this.gym,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['_id'],
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      price: json['price']?.toDouble() ?? 0,
      timePeriodType: json['timePeriodType'] != null ? PackageTimePeriodType.values.firstWhere((e) => e.value == json['timePeriodType']) : null,
      totalSessions: json['totalSessions']?.toDouble() ?? 0,
      duration: json['duration'] ?? 0,
      status: json['status'] != null ? PackageStatus.values.firstWhere((e) => e.value == json['status']) : null,
      images: List<String>.from(json['images'] ?? []) ,
      promotionalPrice: json['promotionalPrice']?.toDouble() ?? 0,
      type: json['type'] != null ? PackageType.values.firstWhere((e) => e.value == json['type']) : null,
      conveniences: (json['conveniences'] != null && json['conveniences'] is Map<String, dynamic>) ? List<Convenience>.from(json['conveniences'].map((x) => Convenience.fromJson(x))) : [],
      gym: json['gym'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'timePeriodType': timePeriodType?.value,
      'totalSessions': totalSessions,
      'duration': duration,
      'status': status?.value,
      'images': images,
      'promotionalPrice': promotionalPrice,
      'type': type?.value,
      'conveniences': conveniences,
      'gym': gym,
    };
  }
}
