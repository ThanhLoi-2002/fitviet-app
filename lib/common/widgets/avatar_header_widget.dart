import 'package:fitness_client/common/widgets/custom_image_widget.dart';
import 'package:flutter/material.dart';

class AvatarHeaderWidget extends StatelessWidget {
  const AvatarHeaderWidget({super.key, required this.imageUrl, required this.textTop, required this.textBottom, this.avatarSize, this.textSpacing});
  final String imageUrl;
  final double? avatarSize;
  final Text textTop;
  final Widget textBottom;
  final double? textSpacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey[400]!, // Màu viền
              width: 2, // Độ dày viền
            ),
          ),
          child: ClipOval(
            child: CustomImageWidget(imageUrl: imageUrl, height: avatarSize ?? 70, width: avatarSize ?? 70, fit: BoxFit.cover),
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [textTop, SizedBox(height: textSpacing ?? 8), textBottom]),
      ],
    );
  }
}
