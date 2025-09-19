import 'package:fitness_client/common/widgets/custom_image_widget.dart';
import 'package:fitness_client/features/package/domains/models/package.dart';
import 'package:fitness_client/features/package/widgets/price_widget.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class PackageItemWidget extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Package package;

  const PackageItemWidget({super.key, required this.isSelected, required this.onTap, required this.package});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          children: [
            CustomImageWidget(imageUrl: package.images!.isNotEmpty ? package.images![0] : "", width: 90, height: 100),
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.orange300.withOpacity(0.05) : Colors.grey[100],
                  border: Border.all(color: isSelected ? AppColors.orange300.withOpacity(0.4) : Colors.grey[300]!),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(package.name!, style: fontRegular.copyWith(color: Colors.grey[700], fontSize: 16)),
                          PriceWidget(originalPrice: package.price!, promotionalPrice: package.promotionalPrice!),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
