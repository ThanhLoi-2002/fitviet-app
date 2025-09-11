enum SubjectStatus {
  active,
  disabled,
}

extension SubjectStatusExtension on SubjectStatus {
  String get value => toString().split('.').last;
}
