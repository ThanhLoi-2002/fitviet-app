import 'package:fitness_client/common/widgets/custom_image_widget.dart';
import 'package:fitness_client/features/gym/domains/models/gym.dart';
import 'package:fitness_client/helper/price_converter.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GymCardWidget extends StatelessWidget {
  const GymCardWidget({super.key, required this.gym});
  final Gym gym;

  @override
  Widget build(BuildContext context) {
    String image = gym.images!.isNotEmpty ? gym.images![0] : '';
    return Container(
      width: context.width * 0.45, // Điều chỉnh kích thước
      height: 160,
      alignment: Alignment.center, // Căn giữa nội dung
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageWidget(borderRadius: Dimensions.fontSizeOverSmall, imageUrl: image, fit: BoxFit.cover, height: 100, width: double.infinity),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    Expanded(
                      child: Text(gym.name!, style: fontRegular, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    Text(gym.rating.toString(), style: TextStyle(color: Colors.black)),
                  ],
                ),
                if (gym.cheapestPackage != null && gym.cheapestPackage!.price != null)
                  Row(
                    children: [
                      Text(PriceConverter.formatCurrency(gym.cheapestPackage!.price!), style: fontMedium),
                      Text('/tháng', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
