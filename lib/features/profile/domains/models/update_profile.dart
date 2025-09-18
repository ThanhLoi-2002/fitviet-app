class UpdateProfile {
  String? name;
  String? email;
  String? phone;
  DateTime? dateOfBirth;
  double? weight;
  double? height;
  String? gender;

  UpdateProfile({
    this.name,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.weight,
    this.height,
    this.gender,
  });

  // Convert to JSON
  Map<String, String> toJson() {
    return {
      'name': name ?? "",
      'email': email ?? "",
      'phone': phone ?? "",
      'dateOfBirth': dateOfBirth?.toIso8601String() ?? "",
      'weight': weight.toString(),
      'height': height.toString(),
      'gender': gender ?? "",
    };
  }
}
