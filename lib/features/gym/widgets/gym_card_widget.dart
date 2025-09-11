import 'package:fitness_client/common/widgets/custom_image_widget.dart';
import 'package:fitness_client/features/gym/domains/models/gym.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GymCardWidget extends StatelessWidget {
  const GymCardWidget({super.key, required this.gym});
  final Gym gym;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.4, // Điều chỉnh kích thước
      height: 160, // Sử dụng MediaQuery để lấy kích thước
      alignment: Alignment.center, // Căn giữa nội dung
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageWidget(borderRadius: Dimensions.fontSizeOverSmall, imageUrl: gym.images![0], fit: BoxFit.cover, height: 100, width: double.infinity),
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
                if (gym.cheapestPackage != null)
                  Row(
                    children: [
                      Text(gym.cheapestPackage!.price.toString(), style: fontMedium),
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
