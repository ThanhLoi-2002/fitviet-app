import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class TextRowWidget extends StatelessWidget {
  const TextRowWidget({super.key, required this.textLeft, required this.textRight, this.size, this.textLeftcolor, this.textRightColor});
  final String textLeft;
  final String textRight;
  final double? size;
  final Color? textLeftcolor;
  final Color? textRightColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textLeft,
          style: fontRegular.copyWith(fontSize: size ?? 16, color: textLeftcolor ?? Colors.grey[700]),
        ),
        Text(
          textRight,
          style: fontRegular.copyWith(fontSize: size ?? 16, color: textRightColor ?? Colors.grey[900], fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
