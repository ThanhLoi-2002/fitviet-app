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
  List<String>? conveniences;
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
      name: json['name'],
      description: json['description'],
      price: json['price']?.toDouble(),
      timePeriodType: json['timePeriodType'] != null ? PackageTimePeriodType.values.firstWhere((e) => e.value == json['timePeriodType']) : null,
      totalSessions: json['totalSessions']?.toDouble(),
      duration: json['duration'],
      status: json['status'] != null ? PackageStatus.values.firstWhere((e) => e.value == json['status']) : null,
      images: List<String>.from(json['images']),
      promotionalPrice: json['promotionalPrice'],
      type: json['type'] != null ? PackageType.values.firstWhere((e) => e.value == json['type']) : null,
      conveniences: List<String>.from(json['conveniences']),
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
