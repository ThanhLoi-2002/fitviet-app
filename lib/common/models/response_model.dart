import 'package:fitness_client/common/models/pagination.dart';

class ResponseModel<T> {
  final int statusCode;
  final String message;
  final T data;
  final Pagination? metadata;
  ResponseModel(this.statusCode, this.message, this.data, this.metadata);
}
