import 'package:fitness_client/helper/route_helper.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/images.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkInternet();

    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed(RouteHelper.initial);
    });
  }

  void checkInternet() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    bool isConnected =
        connectivityResult.contains(ConnectivityResult.wifi) || connectivityResult.contains(ConnectivityResult.mobile);

    if (!isConnected) {
      Get.offAllNamed(RouteHelper.noInternet);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.orange300, Color.fromRGBO(219, 83, 0, 1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(left: 25, top: 248, child: Image.asset(Images.cirle0)),
          Positioned(right: context.width * 0.1, top: 115, child: Image.asset(Images.cirle1)),
          Positioned(right: 0, top: 288, child: Image.asset(Images.halfCircle)),
          // Center logo
          Positioned(
            top: 144,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Images.logo, fit: BoxFit.cover),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                Text(AppConstants.appName.toUpperCase(), style: fontMedium.copyWith(fontSize: 28, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
