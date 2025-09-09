class LoginBodyModel {
  String? emailOrPhone;
  String? password;

  LoginBodyModel({this.emailOrPhone, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emailOrPhone'] = emailOrPhone;
    data['username'] = emailOrPhone;
    data['password'] = password;
    return data;
  }
}
