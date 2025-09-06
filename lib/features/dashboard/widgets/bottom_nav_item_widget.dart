import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:flutter/material.dart';

class BottomNavItemWidget extends StatelessWidget {
  final String icon;
  final Function? onTap;
  final bool isSelected;
  const BottomNavItemWidget({super.key, this.onTap, this.isSelected = false, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap != null ? () => onTap!() : null,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: 25, width: 25, color: isSelected ? AppColors.orange300 : Theme.of(context).textTheme.bodyMedium!.color!),

            SizedBox(height: Dimensions.paddingSizeExtraSmall),

            Container(height: 3, decoration: BoxDecoration(color: isSelected ? AppColors.orange300 : null)),
          ],
        ),
      ),
    );
  }
}
