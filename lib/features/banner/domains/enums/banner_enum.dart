enum BannerStatus {
  active,
  disabled,
}

extension BannerStatusExtension on BannerStatus {
  String get value => toString().split('.').last;
}
