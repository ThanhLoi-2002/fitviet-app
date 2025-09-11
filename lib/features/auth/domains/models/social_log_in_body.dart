class SocialLoginBodyModel {
  String? accessToken;
  String? loginType;

  SocialLoginBodyModel({this.accessToken, this.loginType});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['deviceToken'] = accessToken;
    return data;
  }
}
