class ChangePassword {
  String? token;
  String? newPassword;
  String? email;

  ChangePassword({this.email, this.newPassword, this.token});

  Map<String, String> toJson() {
    return {'token': token ?? "", 'email': email ?? "", 'newPassword': newPassword ?? ""};
  }
}
