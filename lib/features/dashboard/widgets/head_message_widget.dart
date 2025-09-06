import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:flutter/material.dart';

class HeaderMessageWidget extends StatelessWidget {
  const HeaderMessageWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        spacing: Dimensions.paddingSizeDefault,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.lightPeach),
            child: Center(
              child: Text('1', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
