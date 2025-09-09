import 'package:fitness_client/util/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSliderWidget extends StatefulWidget {
  const CustomSliderWidget({super.key, required this.max, required this.min, required this.price, required this.onChanged, required this.label});
  final double max;
  final double min;
  final double price;
  final String label;
  final Function(double newValue) onChanged;

  @override
  State<CustomSliderWidget> createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Slider(value: widget.price, min: widget.min, max: widget.max, activeColor: AppColors.orange400, divisions: 10, label: widget.label, onChanged: widget.onChanged);
  }
}
