import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key, required this.content, required this.date});
  final String content;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Căn chỉnh theo chiều dọc
      children: [
        CircleAvatar(backgroundColor: Colors.grey[300]),
        SizedBox(width: Dimensions.paddingSizeSmall), // Khoảng cách giữa avatar và nội dung
        Expanded(
          // Để nội dung chiếm không gian còn lại
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                style: fontMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.grey[800]),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Text(date, style: fontRegular.copyWith(color: Colors.grey[600])),
              SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
