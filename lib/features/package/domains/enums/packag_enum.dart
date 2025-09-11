enum PackageTimePeriodType {
  session,
  month,
  year,
}

extension PackageTimePeriodTypeExtension on PackageTimePeriodType {
  String get value => toString().split('.').last;
}

enum PackageStatus {
  active,
  disabled,
}

extension PackageStatusExtension on PackageStatus {
  String get value => toString().split('.').last;
}

enum PackageType {
  selfTraining,
  guidedTraining,
}

extension PackageTypeExtension on PackageType {
  String get value => toString().split('.').last;
}
