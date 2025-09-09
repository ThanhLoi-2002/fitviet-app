import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
  final IconData icon;
  final String? title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final Function? onNoPressed;
  const ConfirmationDialog({super.key, required this.icon, this.title, required this.description, required this.onYesPressed, this.isLogOut = false, this.onNoPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        width: 500,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Icon(icon, size: 50, color: AppColors.orange300),
              ),

              title != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                      child: Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: fontMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
                      ),
                    )
                  : const SizedBox(),

              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Text(
                  description,
                  style: fontMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      color: Colors.green,
                      onPressed: () => isLogOut
                          ? onYesPressed()
                          : onNoPressed != null
                          ? onNoPressed!()
                          : Get.back(),
                      buttonText: isLogOut ? 'Có' : 'Không',
                      radius: Dimensions.radiusSmall,
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeLarge),

                  Expanded(
                    child: CustomButton(color: Colors.red, buttonText: isLogOut ? 'Không' : 'Có', onPressed: () => isLogOut ? Get.back() : onYesPressed(), radius: Dimensions.radiusSmall, height: 40),
                  ),
                ],
              ),

              // GetBuilder<OrderController>(builder: (orderController) {
              //   return !orderController.isLoading ? Row(children: [
              //     Expanded(child: TextButton(
              //       onPressed: () => isLogOut ? onYesPressed() : onNoPressed != null ? onNoPressed!() : Get.back(),
              //       style: TextButton.styleFrom(
              //         backgroundColor: Theme.of(context).disabledColor.withValues(alpha: 0.3), minimumSize: const Size(Dimensions.webMaxWidth, 50), padding: EdgeInsets.zero,
              //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
              //       ),
              //       child: Text(
              //         isLogOut ? 'Có' : 'Không', textAlign: TextAlign.center,
              //         style: fontBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
              //       ),
              //     )),
              //     const SizedBox(width: Dimensions.paddingSizeLarge),

              //     Expanded(child: CustomButton(
              //       buttonText: isLogOut ? 'Không' : 'Có',
              //       onPressed: () => isLogOut ? Get.back() : onYesPressed(),
              //       radius: Dimensions.radiusSmall, height: 50,
              //     )),
              //   ]) : const Center(child: CircularProgressIndicator());
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
