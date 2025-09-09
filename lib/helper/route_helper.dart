import 'package:fitness_client/common/widgets/no_internet_screen.dart';
import 'package:fitness_client/features/auth/screens/sign_in_screen.dart';
import 'package:fitness_client/features/auth/screens/sign_up_screen.dart';
import 'package:fitness_client/features/dashboard/screens/dashboard_screen.dart';
import 'package:fitness_client/features/search/screens/search_screen.dart';
import 'package:fitness_client/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
    static const String search = '/search';
  static const String noInternet = '/no-internet';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => getRoute(DashboardScreen(pageIndex: 0))),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: noInternet, page: () => NoInternetScreen()),
    GetPage(name: signIn, page: () => getRoute(SignInScreen())),
    GetPage(name: signUp, page: () => getRoute(SignUpScreen())),
    GetPage(name: search, page: () => getRoute(SearchScreen())),
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
