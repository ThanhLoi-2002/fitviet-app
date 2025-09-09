import 'package:fitness_client/features/profile/models/client_model.dart';

class SignUpBodyModel {
  String? phone;
  String? email;
  String? password;
  String? passwordConfirm;
  String? name;

  SignUpBodyModel({this.phone, this.email, this.password, this.name, this.passwordConfirm});

  SignUpBodyModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'email': email,
      'password': password,
      'passwordConfirm': passwordConfirm,
      'clientName': name,
      'dateOfBirth': DateTime(1970,1,1).millisecondsSinceEpoch,
      'gender': ClientGender.other.value,
    };
  }
}
