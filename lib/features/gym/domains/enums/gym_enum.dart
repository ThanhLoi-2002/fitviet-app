enum GymStatus {
  pending,
  active,
  locked,
  rejected,
  disabled,
}

extension GymStatusExtension on GymStatus {
  String get value => toString().split('.').last;
}

enum GymSegment {
  vip,
  center,
  studio,
  private,
  bbox,
}
extension GymSegmentExtension on GymSegment {
  String get value => toString().split('.').last;
}
