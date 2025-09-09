import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/helper/route_helper.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotLoggedInScreen extends StatelessWidget {
  const NotLoggedInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: context.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.login_outlined, size: MediaQuery.of(context).size.height * 0.2),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        
              Text(
                'Bạn chưa đăng nhập',
                style: fontBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        
              Text(
                'Vui lòng đăng nhập để tiếp tục'.tr,
                style: fontRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        
              SizedBox(
                width: 200,
                child: CustomButton(
                  color: AppColors.orange300,
                  buttonText: 'Đăng nhập',
                  height: 40,
                  onPressed: () {
                    Get.toNamed(RouteHelper.signIn);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
