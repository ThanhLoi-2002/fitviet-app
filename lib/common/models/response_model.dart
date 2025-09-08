import 'package:fitness_client/common/models/pagination.dart';

class ResponseModel<T> {
  final bool isSuccess;
  final String? message;
  final T? data;
  final Pagination? metadata;
  ResponseModel({required this.isSuccess, this.message, this.data, this.metadata});
}
