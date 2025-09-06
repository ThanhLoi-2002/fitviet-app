import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/helper/route_helper.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/images.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetScreen extends StatelessWidget {
  final Widget? child;
  const NoInternetScreen({super.key, this.child});

  Future<void> checkInternet() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());

    if (!connectivityResult.contains(ConnectivityResult.none)) {
      try {
        Get.off(child);
      } catch (e) {
        Get.offAllNamed(RouteHelper.initial);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.height * 0.025),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Images.noInternet, width: 400, height: 400),
          Text(
            "${'Oops!'} ${'Không có kết nối mạng'}",
            style: fontBold.copyWith(
              fontSize: 20,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Text(
            'Vui lòng kiểm tra lại kết nối',
            textAlign: TextAlign.center,
            style: fontRegular.copyWith(color: Theme.of(context).disabledColor),
          ),
          const SizedBox(height: 40),

          CustomButton(
            buttonText: 'Thử lại',
            color: AppColors.orange300,
            onPressed: checkInternet,
          ),
        ],
      ),
    );
  }
}
