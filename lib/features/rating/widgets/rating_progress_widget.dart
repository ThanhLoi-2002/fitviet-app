import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingProgressWidget extends StatelessWidget {
  const RatingProgressWidget({super.key, required this.value, required this.text});

  final double value;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(text, style: fontRegular)),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: context.width * 0.8,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: Colors.grey[300],
              borderRadius: BorderRadius.circular(7),
              valueColor: AlwaysStoppedAnimation(AppColors.orange300),
            ),
          ),
        ),
      ],
    );
  }
}
