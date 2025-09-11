class LoginBody {
  String? phone;
  String? password;

  LoginBody({this.phone, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['username'] = phone;
    data['password'] = password;
    return data;
  }
}
