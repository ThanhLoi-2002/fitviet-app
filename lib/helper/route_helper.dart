import 'package:fitness_client/common/widgets/no_internet_screen.dart';
import 'package:fitness_client/features/auth/screens/sign_in_screen.dart';
import 'package:fitness_client/features/auth/screens/sign_up_screen.dart';
import 'package:fitness_client/features/class/screens/class_today_screen.dart';
import 'package:fitness_client/features/dashboard/screens/dashboard_screen.dart';
import 'package:fitness_client/features/gym/screens/gym_detail_screen.dart';
import 'package:fitness_client/features/package/screens/package_detail_screen.dart';
import 'package:fitness_client/features/package/screens/package_screen.dart';
import 'package:fitness_client/features/payment/screens/payment_success_screen.dart';
import 'package:fitness_client/features/profile/screens/change_password_screen.dart';
import 'package:fitness_client/features/profile/screens/update_profile_screen.dart';
import 'package:fitness_client/features/rating/screens/rating_screen.dart';
import 'package:fitness_client/features/search/screens/search_screen.dart';
import 'package:fitness_client/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/payment/screens/payment_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String search = '/search';
  static const String noInternet = '/no-internet';
  static const String gymDetail = '/gym-detail';
  static const String rating = '/rating';
  static const String package = '/package';
  static const String packageDetail = '/package-detail';
  static const String payment = '/payment';
  static const String paymentSuccess = '/payment-success';
  static const String updateProfile = '/update-profile';
  static const String changePassword = '/change-password';
    static const String classToday = '/class-today';

  static String getGymDetailRoute(String gymId) => '$gymDetail?id=$gymId';
  static String getRatingRoute(String gymId) => '$rating?gymId=$gymId';
  static String getPackageDetailRoute(String packageId) => '$packageDetail?packageId=$packageId';
  static String getChangePasswordRoute(bool fromPasswordChange, String? email) => '$changePassword?email=$email&fromPasswordChange=$fromPasswordChange';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => getRoute(DashboardScreen(pageIndex: 0))),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: noInternet, page: () => NoInternetScreen()),
    GetPage(name: signIn, page: () => getRoute(SignInScreen())),
    GetPage(name: signUp, page: () => getRoute(SignUpScreen())),
    GetPage(name: search, page: () => getRoute(SearchScreen())),
    GetPage(name: package, page: () => getRoute(PackageScreen())),
    GetPage(name: payment, page: () => getRoute(PaymentScreen())),
    GetPage(name: paymentSuccess, page: () => getRoute(PaymentSuccessScreen())),
    GetPage(name: updateProfile, page: () => getRoute(UpdateProfileScreen())),
    GetPage(name: classToday, page: () => getRoute(ClassTodayScreen())),
    GetPage(
      name: changePassword,
      page: () => getRoute(ChangePasswordScreen(fromPasswordChange: Get.parameters['fromPasswordChange'] == 'true', email: Get.parameters['email'])),
    ),
    GetPage(
      name: gymDetail,
      page: () => getRoute(GymDetailScreen(gymId: Get.parameters['id']!)),
    ),
    GetPage(
      name: rating,
      page: () => getRoute(RatingScreen(gymId: Get.parameters['gymId']!)),
    ),
    GetPage(
      name: packageDetail,
      page: () => getRoute(PackageDetailScreen(id: Get.parameters['packageId']!)),
    ),
  ];

  static Widget getRoute(Widget navigateTo, {bool byPuss = false}) {
    // double? minimumVersion = 0;
    // if(GetPlatform.isAndroid) {
    //   minimumVersion = Get.find<SplashController>().configModel!.appMinimumVersionAndroid;
    // }else if(GetPlatform.isIOS) {
    //   minimumVersion = Get.find<SplashController>().configModel!.appMinimumVersionIos;
    // }
    // return (AppConstants.appVersion < minimumVersion! && !GetPlatform.isWeb)  ? const UpdateScreen(isUpdate: true)
    //     : Get.find<SplashController>().configModel!.maintenanceMode! ? const UpdateScreen(isUpdate: false)
    //     : navigateTo;
    return navigateTo;
  }
}
