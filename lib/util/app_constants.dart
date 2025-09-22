class AppConstants {
  static const String appName = 'FitNet';
  static const double appVersion = 1.0;
  static const String fontFamily = 'Roboto';

  static const String baseUrl = 'http://10.0.2.2:3004';
  static const String imgDefault = 'https://tse3.mm.bing.net/th/id/OIP.09mzllR7Fq9-7LREOJNbggHaE7?pid=Api&P=0&h=220';

  static const String registerUri = '/api/auth/signUp';
  static const String loginUri = '/api/auth/signIn';
  static const String loginGoogleUri = '/api/auth/signInWithGoogle';
  static const String loginFacebookUri = '/api/auth/signInWithFacebook';
  static const String getMeUri = '/api/client/me';
  static const String getAllBannerUri = '/api/banner/all';
  static const String getAllGymUri = '/api/gym/all';
  static const String getGymByIdUri = '/api/gym';
  static const String getAllConvenienceUri = '/api/convenience/client';
  static const String getAllSubjectUri = '/api/subject';
  static const String getAllRatingUri = '/api/ratingDetail';
  static const String createRatingUri = '/api/ratingDetail/create';
  static const String updateRatingUri = '/api/ratingDetail/update';
  static const String getRatingDetailUri = '/api/ratingDetail/check-rated';
  static const String getAllPackageUri = '/api/package/all';
  static const String getPackageByIdUri = '/api/package';
  static const String updateProfileUri = '/api/client/updateMyProfile';
  static const String resetPasswordUri = '/api/client/reset-password';
  static const String forgotPasswordUri = '/api/client/forgot-password';
  static const String checkInUri = '/api/checkin';
  static const String getClientPackageUri = '/api/client-packages/client';

  /// Shared Key
  static const String token = 'token';
  static const String userPassword = 'user_password';
  static const String userPhone = 'user__phone';
  static const String userLongitude = 'user_longitude';
  static const String userLatitude = 'user_latitude';
}
