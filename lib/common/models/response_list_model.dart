import 'package:fitness_client/common/models/pagination_response.dart';

class ResponseListModel<T> {
  bool isSuccess;
  int statusCode;
  String? message;
  List<T>? data;
  PaginationResponse? metadata;
  ResponseListModel({this.isSuccess = false, this.message, this.data, this.metadata, this.statusCode = 0});

  //Áp dụng khi response.data có trả kèm pagegination
  factory ResponseListModel.fromJson(Map<String, dynamic> json, List<T> fromJsonT) {
    // Xử lý message có thể là chuỗi hoặc mảng
    String? message;
    if (json['message'] is String) {
      message = json['message'];
    } else if (json['message'] is List) {
      message = (json['message'] as List).join(', '); // Nối các thông điệp thành chuỗi
    }

    return ResponseListModel<T>(
      isSuccess: (json['statusCode'] >= 200 && json['statusCode'] <= 300) ? true : false,
      statusCode: json['statusCode'] ?? 0,
      message: message,
      data: fromJsonT, // Chuyển đổi dữ liệu
      metadata: json['metadata'] != null ? PaginationResponse.fromJson(json['metadata']) : null,
    );
  }
}
