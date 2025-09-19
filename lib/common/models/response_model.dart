import 'package:fitness_client/common/models/pagination_response.dart';

class ResponseModel<T> {
  bool isSuccess;
  int statusCode;
  String? message;
  T? data;
  PaginationResponse? metadata;
  ResponseModel({this.isSuccess = false, this.message, this.data, this.metadata, this.statusCode = 0});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    // Xử lý message có thể là chuỗi hoặc mảng
    String? message;
    if (json['message'] is String) {
      message = json['message'];
    } else if (json['message'] is List) {
      message = (json['message'] as List).join(', '); // Nối các thông điệp thành chuỗi
    }

    return ResponseModel<T>(
      isSuccess: (json['statusCode'] >= 200 && json['statusCode'] <= 300) ? true : false,
      statusCode: json['statusCode'] ?? 0,
      message: message,
      data: json['data'] as T,
      metadata: json['metadata'] != null ? PaginationResponse.fromJson(json['metadata']) : null,
    );
  }

//Áp dụng khi response.data có trả kèm pagegination
  factory ResponseModel.fromJson1(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    // Xử lý message có thể là chuỗi hoặc mảng
    String? message;
    if (json['message'] is String) {
      message = json['message'];
    } else if (json['message'] is List) {
      message = (json['message'] as List).join(', '); // Nối các thông điệp thành chuỗi
    }

    return ResponseModel<T>(
      isSuccess: (json['statusCode'] >= 200 && json['statusCode'] <= 300) ? true : false,
      statusCode: json['statusCode'] ?? 0,
      message: message,
      data: fromJsonT(json['data']), // Chuyển đổi dữ liệu
      metadata: json['metadata'] != null ? PaginationResponse.fromJson(json['metadata']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'statusCode': statusCode,
      'message': message,
      'data': data,
      'metadata': metadata?.toJson(), // Giả sử PaginationResponse cũng có phương thức toJson
    };
  }

}
