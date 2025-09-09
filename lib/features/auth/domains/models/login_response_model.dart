import 'package:fitness_client/features/profile/models/client_model.dart';

class LoginResponseModel {
  ClientModel? client;
  String? accessToken;
  LoginResponseModel({this.accessToken, this.client});
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(client: json['client'] != null ? ClientModel.fromJson(json['client']) : ClientModel.fromJson(json['person']), accessToken: json['accessToken']);
  }
}
