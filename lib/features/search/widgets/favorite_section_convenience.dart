import 'package:fitness_client/features/convenience/controllers/convenience_controller.dart';
import 'package:fitness_client/features/gym/controllers/gym_controller.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class FavoriteSectionConvenience extends StatefulWidget {
  const FavoriteSectionConvenience({super.key, required this.convenienceController, required this.gymController, required this.maxDisplay});
  final ConvenienceController convenienceController;
  final GymController gymController;
  final int maxDisplay;

  @override
  State<FavoriteSectionConvenience> createState() => _FavoriteSectionConvenienceState();
}

class _FavoriteSectionConvenienceState extends State<FavoriteSectionConvenience> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sở thích cá nhân', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
            if (widget.convenienceController.favoriteConveniences.length > widget.maxDisplay)
              TextButton(
                onPressed: () {
                  // Hành động khi nhấn "Xem thêm"
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(_isExpanded ? 'Ẩn bớt' : "Xem thêm", style: fontRegular.copyWith()),
              ),
          ],
        ),
        SizedBox(height: 10),
        GridView.builder(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(), // Disable scrolling
          shrinkWrap: true, // Allow the grid to take only the necessary space
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            childAspectRatio: 3, // Adjust the aspect ratio as needed
            crossAxisSpacing: 5.0, // Space between columns
            mainAxisSpacing: 5.0, // Space between rows
          ),
          itemCount: widget.convenienceController.favoriteConveniences.length > widget.maxDisplay
              ? _isExpanded
                    ? widget.convenienceController.favoriteConveniences.length
                    : widget.maxDisplay
              : widget.convenienceController.favoriteConveniences.length, // Total number of items
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                List<String> favoriteConvenience = widget.gymController.gymFilter.favoriteConvenience;
                String value = widget.convenienceController.favoriteConveniences[index].id!;
                if (favoriteConvenience.contains(value)) {
                  favoriteConvenience.remove(value);
                } else {
                  favoriteConvenience.add(value);
                }
                widget.gymController.updateFilter(favoriteConvenience: favoriteConvenience);
              },
              child: Container(
                alignment: Alignment.center, // Căn giữa nội dung
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: widget.gymController.gymFilter.favoriteConvenience.contains(widget.convenienceController.favoriteConveniences[index].id!) ? AppColors.orange300 : Colors.grey[200], // Màu nền thay đổi khi được chọn
                ),
                child: Text(
                  widget.convenienceController.favoriteConveniences[index].name!,
                  style: TextStyle(
                    color: widget.gymController.gymFilter.favoriteConvenience.contains(widget.convenienceController.favoriteConveniences[index].id!) ? Colors.white : Colors.black, // Màu chữ thay đổi khi được chọn
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
