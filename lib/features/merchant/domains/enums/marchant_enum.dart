enum MerchantStatus {
   active,
  disabled,
  inactive,
}

extension MerchantStatusExtension on MerchantStatus {
  String get value => toString().split('.').last;
}
