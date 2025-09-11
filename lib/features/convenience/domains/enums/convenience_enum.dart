enum ConvenienceStatus {
  active,
  inactive,
}

extension ConvenienceStatusExtension on ConvenienceStatus {
  String get value => toString().split('.').last;
}

enum ConvenienceType {
  basic,
  favorite,
  safe,
  highClass,
}

extension ConvenienceTypeExtension on ConvenienceType {
  String get value => toString().split('.').last;
}
