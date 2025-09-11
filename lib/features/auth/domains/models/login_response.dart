import 'package:fitness_client/features/profile/domains/models/client.dart';

class LoginResponse {
  Client? client;
  String? accessToken;
  LoginResponse({this.accessToken, this.client});
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(client: json['client'] != null ? Client.fromJson(json['client']) : Client.fromJson(json['person']), accessToken: json['accessToken']);
  }
}
