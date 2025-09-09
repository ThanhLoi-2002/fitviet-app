import 'package:fitness_client/common/models/pagination.dart';

class ResponseModel<T> {
  bool isSuccess;
  int statusCode;
  String? message;
  T? data;
  Pagination? metadata;
  ResponseModel({required this.isSuccess, this.message, this.data, this.metadata, required this.statusCode});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    // Xử lý message có thể là chuỗi hoặc mảng
    String? message;
    if (json['message'] is String) {
      message = json['message'];
    } else if (json['message'] is List) {
      message = (json['message'] as List).join(', '); // Nối các thông điệp thành chuỗi
    }

    return ResponseModel<T>(
      isSuccess: (json['statusCode'] >=200 && json['statusCode'] <= 300) ? true : false,
      statusCode: json['statusCode'] ?? 0,
      message: message,
      data: json['data'],
      metadata: json['metadata'] != null ? Pagination.fromJson(json['metadata']) : null,
    );
  }
}
