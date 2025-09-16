class GymFilter {
  int? limit;
  String? sortBy;
  int? sortDirection;
  int? page;
  double? long;
  double? lat;
  List<String> subjects;
  List<String> basicConvenience;
  List<String> highClassConvenience;
  List<String> favoriteConvenience;
  List<String> safeConvenience;
  double rating;
  double fromPrice;
  double toPrice;
  double fromDistance;
  double toDistance;
  String? search;

  // Constructor
  GymFilter({
    this.limit = 10,
    this.sortBy,
    this.sortDirection,
    this.page = 0,
    this.long,
    this.lat,
    required this.subjects,
    required this.basicConvenience,
    required this.highClassConvenience,
    required this.favoriteConvenience,
    required this.safeConvenience,
    required this.rating,
    required this.fromPrice,
    required this.toPrice,
    required this.fromDistance,
    required this.toDistance,
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
      'subjects': subjects.join(','),
      'basicConvenience': basicConvenience.join(','),
      'highClassConvenience': highClassConvenience.join(','),
      'safeConvenience': safeConvenience.join(','),
      'favoriteConvenience': favoriteConvenience.join(','),
      'rating': rating,
      'fromPrice': fromPrice,
      'toPrice': toPrice,
      'fromDistance': fromDistance * 1000,
      'toDistance': toDistance * 1000,
      'search': search,
    };
  }
}
