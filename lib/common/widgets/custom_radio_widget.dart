import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class CustomRadioWidget extends StatefulWidget {
  const CustomRadioWidget({super.key, required this.value, required this.selectedValue, required this.onChanged});
  final String value;
  final String selectedValue;
  final Function(String? value) onChanged;

  @override
  State<CustomRadioWidget> createState() => _CustomRadioWidgetState();
}

class _CustomRadioWidgetState extends State<CustomRadioWidget> {
  String value = 'Nam';
  @override
  Widget build(BuildContext context) {
    switch (widget.value) {
      case 'male':
        value = 'Nam';
      case 'female':
        value = 'Nữ';
      case 'other':
        value = 'Khác';
    }
    return Row(
      children: [
        Radio<String>(
          value: widget.value,
          groupValue: widget.selectedValue,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: widget.onChanged,
          activeColor: AppColors.orange300,
          visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
        ),

        Text(value, style: fontRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
      ],
    );
  }
}
