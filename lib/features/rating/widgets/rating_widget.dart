import 'package:fitness_client/common/widgets/avatar_header_widget.dart';
import 'package:fitness_client/features/rating/domains/models/rating.dart';
import 'package:fitness_client/helper/date_converter.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, this.width, this.height, required this.rating, this.maxLines});
  final double? width;
  final double? height;
  final Rating rating;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 220,
      height: height ?? 160,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarHeaderWidget(
            imageUrl: rating.client!.avatar!,
            textTop: Text(rating.client!.name!, style: fontMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
            textBottom: Text(DateConverter.formatDate(rating.createdAt!), style: fontRegular.copyWith(color: Colors.grey)),
            avatarSize: 50,
            textSpacing: 4,
          ),
          SizedBox(height: 8),
          Text(rating.content!, maxLines: maxLines ?? 3, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
