class PaginationResponse {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  PaginationResponse({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory PaginationResponse.fromJson(Map<String, dynamic> json) {
    return PaginationResponse(total: json['total'] ?? 0, page: json['page'] ?? 1, limit: json['limit'] ?? 10, totalPages: json['totalPages'] ?? 1);
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'page': page,
      'limit': limit,
      'totalPages': totalPages,
    };
  }
}
