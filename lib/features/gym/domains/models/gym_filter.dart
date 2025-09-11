class GymFilter {
  int? limit;
  String? sortBy;
  int? sortDirection;
  int? page;
  double? long;
  double? lat;
  String? subjects;
  String? basicConvenience;
  String? highClassConvenience;
  double? rating;
  double? fromPrice;
  double? toPrice;
  double? fromDistance;
  double? toDistance;
  String? search;

  // Constructor
  GymFilter({
    this.limit = 10,
    this.sortBy,
    this.sortDirection,
    this.page = 1,
    this.long,
    this.lat,
    this.subjects,
    this.basicConvenience,
    this.highClassConvenience,
    this.rating,
    this.fromPrice,
    this.toPrice,
    this.fromDistance,
    this.toDistance,
    this.search,
  });

  // Phương thức toJson
  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'sortBy': sortBy,
      'sortDirection': sortDirection,
      'page': page,
      'long': long,
      'lat': lat,
      'subjects': subjects,
      'basicConvenience': basicConvenience,
      'highClassConvenience': highClassConvenience,
      'rating': rating,
      'fromPrice': fromPrice,
      'toPrice': toPrice,
      'fromDistance': fromDistance,
      'toDistance': toDistance,
      'search': search,
    };
  }
}
