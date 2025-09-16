import 'package:fitness_client/features/gym/controllers/gym_controller.dart';
import 'package:fitness_client/features/subject/controllers/subject_controller.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class SubjectSectionWidget extends StatefulWidget {
  const SubjectSectionWidget({super.key, required this.subjectController, required this.maxDisplay, required this.gymController});
  final SubjectController subjectController;
  final GymController gymController;
  final int maxDisplay;

  @override
  State<SubjectSectionWidget> createState() => _SubjectSectionWidgetState();
}

class _SubjectSectionWidgetState extends State<SubjectSectionWidget> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Bộ môn', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
            if (widget.subjectController.subjects.length > widget.maxDisplay)
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
          itemCount: widget.subjectController.subjects.length > widget.maxDisplay
              ? _isExpanded
                    ? widget.subjectController.subjects.length
                    : widget.maxDisplay
              : widget.subjectController.subjects.length, // Total number of items
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                List<String> subjects = widget.gymController.gymFilter.subjects;
                String value = widget.subjectController.subjects[index].id!;
                if (subjects.contains(value)) {
                  subjects.remove(value);
                } else {
                  subjects.add(value);
                }
                widget.gymController.updateFilter(subjects: subjects);
              },
              child: Container(
                alignment: Alignment.center, // Căn giữa nội dung
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: widget.gymController.gymFilter.subjects.contains(widget.subjectController.subjects[index].id) ? AppColors.orange300 : Colors.grey[200], // Màu nền thay đổi khi được chọn
                ),
                child: Text(
                  widget.subjectController.subjects[index].name!,
                  style: TextStyle(
                    color: widget.gymController.gymFilter.subjects.contains(widget.subjectController.subjects[index].id) ? Colors.white : Colors.black, // Màu chữ thay đổi khi được chọn
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
