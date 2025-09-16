import 'package:fitness_client/features/gym/controllers/gym_controller.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class RatingSectionWidget extends StatefulWidget {
  const RatingSectionWidget({super.key, required this.gymController});
  final GymController gymController;

  @override
  State<RatingSectionWidget> createState() => _RatingSectionWidgetState();
}

class _RatingSectionWidgetState extends State<RatingSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Đánh giá', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
        Column(
          children: List.generate(5, (index) {
            int star = 5 - index;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('Từ $star sao', style: TextStyle(fontSize: 15, color: star == widget.gymController.gymFilter.rating ? Colors.grey[900] : Colors.grey[700])),
                ),
                Radio<double>(
                  activeColor: AppColors.orange300,
                  value: 5 - index.toDouble(),
                  groupValue: widget.gymController.gymFilter.rating,
                  onChanged: (double? value) {
                      widget.gymController.updateFilter(rating: value!);
                  },
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
