import 'package:fitness_client/features/convenience/domains/models/convenience.dart';
import 'package:fitness_client/features/gym/domains/enums/gym_enum.dart';
import 'package:fitness_client/features/merchant/domains/models/merchant.dart';
import 'package:fitness_client/features/package/domains/models/package.dart';
import 'package:fitness_client/features/subject/domains/models/subject.dart';

class Gym {
  String? id;
  String? name;
  String? slug;
  String? code;
  Package? cheapestPackage;
  String? rawName;
  String? description;
  String? address;
  GymSegment? segment;
  OpeningTime? openingTime;
  List<String>? images;
  List<double>? location;
  double? long;
  double? lat;
  bool? isLiked;
  bool? isApproved;
  double? rating;
  double? totalRatingPoint;
  int? ratingCount;
  List<Subject>? subjects;
  Merchant? merchant;
  List<Convenience>? basicConvenience; // Cập nhật đây
  List<Convenience>? favoriteConvenience; // Cập nhật đây
  List<Convenience>? highClassConvenience; // Cập nhật đây
  List<Convenience>? safeConvenience; // Cập nhật đây
  String? rules;
  String? medicalAndSafe;
  GymStatus? status;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;

  Gym({
    this.id,
    this.name,
    this.slug,
    this.code,
    this.cheapestPackage,
    this.rawName,
    this.description,
    this.address,
    this.segment,
    this.openingTime,
    this.images,
    this.location,
    this.long,
    this.lat,
    this.isLiked,
    this.isApproved,
    this.rating,
    this.totalRatingPoint,
    this.ratingCount,
    this.subjects,
    this.merchant,
    this.basicConvenience, // Cập nhật đây
    this.favoriteConvenience, // Cập nhật đây
    this.highClassConvenience, // Cập nhật đây
    this.safeConvenience, // Cập nhật đây
    this.rules,
    this.medicalAndSafe,
    this.status,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  factory Gym.fromJson(Map<String, dynamic> json) {
    return Gym(
      id: json['_id'],
      name: json['name'] ?? "",
      slug: json['slug'] ?? "",
      code: json['code'] ?? "",
      cheapestPackage: json['cheapestPackage'] != null ? Package.fromJson(json['cheapestPackage']) : null,
      rawName: json['rawName'] ?? "",
      description: json['description'] ?? "",
      address: json['address'] ?? "",
      segment: json['segment'] != null ? GymSegment.values.firstWhere((e) => e.value == json['segment']) : null,
      openingTime: json['openingTime'] != null ? OpeningTime.fromJson(json['openingTime']) : null,
      images: List<String>.from(json['images'] ?? []),
      location: List<double>.from(json['location'] ?? [0.0,0.0]),
      long: json['long']?.toDouble() ?? 0,
      lat: json['lat']?.toDouble() ?? 0,
      isLiked: json['isLiked'] ?? false,
      isApproved: json['isApproved'],
      rating: json['rating']?.toDouble(),
      totalRatingPoint: json['totalRatingPoint']?.toDouble(),
      ratingCount: json['ratingCount']?.toInt(),
      subjects: json['subjects'] != null ? List<Subject>.from(json['subjects'].map((x) => Subject.fromJson(x))) : [],
      merchant: json['merchant'] != null ? Merchant.fromJson(json['merchant']) : null,
      basicConvenience: json['basicConvenience'] != null ? List<Convenience>.from(json['basicConvenience'].map((x) => Convenience.fromJson(x))) : [], // Cập nhật đây
      favoriteConvenience: json['favoriteConvenience'] != null ? List<Convenience>.from(json['favoriteConvenience'].map((x) => Convenience.fromJson(x))) : [], // Cập nhật đây
      highClassConvenience: json['highClassConvenience'] != null ? List<Convenience>.from(json['highClassConvenience'].map((x) => Convenience.fromJson(x))) : [], // Cập nhật đây
      safeConvenience: json['safeConvenience'] != null ? List<Convenience>.from(json['safeConvenience'].map((x) => Convenience.fromJson(x))) : [], // Cập nhật đây
      rules: json['rules'],
      medicalAndSafe: json['medicalAndSafe'],
      status: json['status'] != null ? GymStatus.values.firstWhere((e) => e.value == json['status']) : null,
      message: json['message'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'code': code,
      'cheapestPackage': cheapestPackage?.toJson(),
      'rawName': rawName,
      'description': description,
      'address': address,
      'segment': segment?.value,
      'openingTime': openingTime?.toJson(),
      'images': images,
      'location': location,
      'long': long,
      'lat': lat,
      'isLiked': isLiked,
      'isApproved': isApproved,
      'rating': rating,
      'totalRatingPoint': totalRatingPoint,
      'ratingCount': ratingCount,
      'subjects': subjects != null ? List<dynamic>.from(subjects!.map((x) => x.toJson())) : [],
      'merchant': merchant?.toJson(),
      'basicConvenience': basicConvenience != null ? List<dynamic>.from(basicConvenience!.map((x) => x.toJson())) : [], // Cập nhật đây
      'favoriteConvenience': favoriteConvenience != null ? List<dynamic>.from(favoriteConvenience!.map((x) => x.toJson())) : [], // Cập nhật đây
      'highClassConvenience': highClassConvenience != null ? List<dynamic>.from(highClassConvenience!.map((x) => x.toJson())) : [], // Cập nhật đây
      'safeConvenience': safeConvenience != null ? List<dynamic>.from(safeConvenience!.map((x) => x.toJson())) : [], // Cập nhật đây
      'rules': rules,
      'medicalAndSafe': medicalAndSafe,
      'status': status?.value,
      'message': message,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class OpeningTime {
  double? from;
  double? to;

  OpeningTime({this.from, this.to});

  factory OpeningTime.fromJson(Map<String, dynamic> json) {
    return OpeningTime(from: json['from']?.toDouble(), to: json['to']?.toDouble());
  }

  Map<String, dynamic> toJson() {
    return {'from': from, 'to': to};
  }
}
