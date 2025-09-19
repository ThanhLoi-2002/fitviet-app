// chỉ dùng khi lấy danh sách gym
class ListPaginationResponse<T> {
  List<T>? data;
  int? total;
  int? totalPage;
  List<int>? ratingList;

  ListPaginationResponse({this.data, this.total, this.totalPage, this.ratingList});

  // Phương thức từ JSON
  factory ListPaginationResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ListPaginationResponse<T>(
      data: json['data'] != null ? (json['data'] as List).map((item) => fromJsonT(item)).toList() : null,
      total: json['total'], // Lấy tổng số mục
      totalPage: json['totalPage'], // Lấy tổng số trang
      ratingList: json['ratingList'] != null ? (json['ratingList'] as List).map((item) => item as int).toList() : null,
    );
  }
}
