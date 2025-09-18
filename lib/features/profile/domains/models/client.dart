class Client {
  String? id;
  String? username;
  String? name;
  ClientGender? gender;
  String? userCode;
  DateTime? dateOfBirth;
  String? rawName;
  String? email;
  double? weight;
  double? height;
  String? phone;
  int? latestCodeTime;
  bool? emailVerified;
  String? avatar;
  ClientStatus? status;
  Role? role;
  List<dynamic>? voucher;
  String? googleId;
  String? resetToken;
  String? gym;

  Client({
    this.id,
    this.username,
    this.name,
    this.gender,
    this.userCode,
    this.dateOfBirth,
    this.rawName,
    this.email,
    this.weight,
    this.height,
    this.phone,
    this.latestCodeTime,
    this.emailVerified,
    this.avatar,
    this.status,
    this.role,
    this.voucher,
    this.googleId,
    this.resetToken,
    this.gym,
  });

  Client.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'] ?? "";
    name = json['name'] ?? "";
    gender = json['gender'] != null ? ClientGender.values.firstWhere((g) => g.value == json['gender']) : null;
    userCode = json['userCode'];
    dateOfBirth = json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null;
    rawName = json['rawName'] ?? "";
    email = json['email'] ?? "";
    weight = json['weight']?.toDouble();
    height = json['height']?.toDouble();
    phone = json['phone'] ?? "";
    latestCodeTime = json['latestCodeTime'];
    emailVerified = json['emailVerified'];
    avatar = json['avatar'] ?? "";
    status = json['status'] != null ? ClientStatus.values.firstWhere((s) => s.value == json['status']) : null;
    role = json['role'] != null ? Role.values.firstWhere((r) => r.value == json['role']) : null;
    voucher = json['voucher'] ?? [];
    googleId = json['googleId'];
    resetToken = json['resetToken'];
    gym = json['gym'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['gender'] = gender?.value;
    data['userCode'] = userCode;
    data['dateOfBirth'] = dateOfBirth?.toIso8601String();
    data['rawName'] = rawName;
    data['email'] = email;
    data['weight'] = weight;
    data['height'] = height;
    data['phone'] = phone;
    data['latestCodeTime'] = latestCodeTime;
    data['emailVerified'] = emailVerified;
    data['avatar'] = avatar;
    data['status'] = status?.value;
    data['role'] = role?.value;
    data['voucher'] = voucher;
    data['googleId'] = googleId;
    data['resetToken'] = resetToken;
    data['gym'] = gym;
    return data;
  }
}

enum ClientGender { male, female, other }

extension ClientGenderExtension on ClientGender {
  String get value {
    switch (this) {
      case ClientGender.male:
        return 'male';
      case ClientGender.female:
        return 'female';
      case ClientGender.other:
        return 'other';
    }
  }
}

enum ClientStatus { active, inactive, disabled, pending }

extension ClientStatusExtension on ClientStatus {
  String get value {
    switch (this) {
      case ClientStatus.active:
        return 'active';
      case ClientStatus.inactive:
        return 'inactive';
      case ClientStatus.disabled:
        return 'disabled';
      case ClientStatus.pending:
        return 'pending';
    }
  }
}

enum Role { all, client, admin, merchant, sysAdmin, staff }

extension RoleExtension on Role {
  String get value {
    switch (this) {
      case Role.all:
        return 'all';
      case Role.client:
        return 'client';
      case Role.admin:
        return 'admin';
      case Role.merchant:
        return 'merchant';
      case Role.sysAdmin:
        return 'sys-admin';
      case Role.staff:
        return 'staff';
    }
  }
}
