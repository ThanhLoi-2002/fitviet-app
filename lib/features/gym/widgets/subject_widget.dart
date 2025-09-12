import 'package:fitness_client/common/widgets/custom_image_widget.dart';
import 'package:fitness_client/features/subject/domains/models/subject.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class SubjectWidget extends StatelessWidget {
  const SubjectWidget({super.key, required this.subject, required this.onTap});
  final Subject subject;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(12),
        width: 90,
        height: 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          spacing: 10,
          children: [
            CustomImageWidget(imageUrl: subject.logo!, width: 24, height: 24),
            Text(subject.name!, style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
