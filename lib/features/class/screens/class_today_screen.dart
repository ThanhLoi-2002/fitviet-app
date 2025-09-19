import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/custom_image_widget.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassTodayScreen extends StatefulWidget {
  const ClassTodayScreen({super.key});

  @override
  State<ClassTodayScreen> createState() => _ClassTodayScreenState();
}

class _ClassTodayScreenState extends State<ClassTodayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lớp hôm nay', style: fontMedium.copyWith(fontSize: 20)), centerTitle: true),
      body: Container(
        height: context.height,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hôm nay 21/12/2020', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w400)),
              SizedBox(height: 16),
              ClassCardWidget(className: 'Zumba', slot: '10/20', time: '16:30'),
              ClassCardWidget(className: 'Boxing', slot: '5/20', time: '16:00'),
              SizedBox(height: 16),
              Text('Thứ Ba 21/12/2020', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              SizedBox(height: 16),
              ClassCardWidget(className: 'Boxing', slot: '15/15', time: '16:00'),
            ],
          ),
        ),
      ),
    );
  }
}

class ClassCardWidget extends StatelessWidget {
  final String className;
  final String slot;
  final String time;

  const ClassCardWidget({super.key, required this.className, required this.slot, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 20,
        children: [
          CustomImageWidget(imageUrl: AppConstants.imgDefault, borderRadius: 8, width: 120, height: 120),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(className, style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
                      Text(slot, style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w400)),
                    ],
                  ),

                  SizedBox(height: 4),
                  Text(time, style: fontRegular.copyWith(color: Colors.grey[700])),
                  CustomButton(onPressed: () {}, color: AppColors.orange300,radius: 8, buttonText: 'Đăng ký',  height: 40, isBold: false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
