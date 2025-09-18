import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBgWidget extends StatelessWidget {
  final Widget circularImage;
  final Widget mainWidget;
  final bool backButton;
  const ProfileBgWidget({super.key, required this.mainWidget, required this.circularImage, required this.backButton});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 1170, height: 230,
              color: AppColors.orange300,
            ),

            Positioned(
              top: 100,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  width: 1170,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge)),
                    color: Theme.of(context).cardColor,
                  ),
                ),
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).padding.top + 15,
              left: 0,
              right: 0,
              child: Text(
                'Hồ sơ',
                textAlign: TextAlign.center,
                style: fontMedium.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w600, color: Theme.of(context).cardColor),
              ),
            ),

            backButton
                ? Positioned(
                    top: MediaQuery.of(context).padding.top,
                    left: 10,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).cardColor, size: 20),
                      onPressed: () => Get.back(),
                    ),
                  )
                : const SizedBox(),

            Positioned(top: 120, left: 0, right: 0, child: circularImage),
          ],
        ),

        Expanded(child: mainWidget),
      ],
    );
  }
}
