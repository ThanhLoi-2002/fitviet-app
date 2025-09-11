import 'package:fitness_client/features/merchant/domains/enums/marchant_enum.dart';
import 'package:fitness_client/features/profile/domains/models/client.dart';

class Merchant {
  String? id;
  String? name;
  String? rawName;
  String? email;
  String? phone;
  String? avatar;
  String? userName;
  MerchantStatus? status;
  Role? role;
  String? idNumber;
  String? dateOfIssue;
  String? address;
  String? accountBank;
  String? nameBank;
  String? bankBranch;
  String? frontID;
  String? backID;
  double? percent;
  String? note;

  Merchant({
    this.id,
    this.name,
    this.rawName,
    this.email,
    this.phone,
    this.avatar,
    this.userName,
    this.status,
    this.role,
    this.idNumber,
    this.dateOfIssue,
    this.address,
    this.accountBank,
    this.nameBank,
    this.bankBranch,
    this.frontID,
    this.backID,
    this.percent,
    this.note,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      id: json['_id'],
      name: json['name'],
      rawName: json['rawName'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      userName: json['userName'],
      status: json['status'] != null ? MerchantStatus.values.firstWhere((e) => e.value == json['status']) : null,
      role: json['role'] != null ? Role.values.firstWhere((e) => e.value == json['role']) : null,
      idNumber: json['idNumber'],
      dateOfIssue: json['dateOfIssue'],
      address: json['address'],
      accountBank: json['accountBank'],
      nameBank: json['nameBank'],
      bankBranch: json['bankBranch'],
      frontID: json['frontID'],
      backID: json['backID'],
      percent: json['percent'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rawName': rawName,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'userName': userName,
      'status': status?.value,
      'role': role?.value,
      'idNumber': idNumber,
      'dateOfIssue': dateOfIssue,
      'address': address,
      'accountBank': accountBank,
      'nameBank': nameBank,
      'bankBranch': bankBranch,
      'frontID': frontID,
      'backID': backID,
      'percent': percent,
      'note': note,
    };
  }
}
