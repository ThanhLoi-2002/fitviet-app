import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/custom_slider_widget.dart';
import 'package:fitness_client/features/convenience/controllers/convenience_controller.dart';
import 'package:fitness_client/features/gym/controllers/gym_controller.dart';
import 'package:fitness_client/features/search/widgets/action_button_widget.dart';
import 'package:fitness_client/features/search/widgets/basic_convenience_section_widget.dart';
import 'package:fitness_client/features/search/widgets/favorite_section_convenience.dart';
import 'package:fitness_client/features/search/widgets/high_class_section_convenience_widget.dart';
import 'package:fitness_client/features/search/widgets/rating_section.dart';
import 'package:fitness_client/features/search/widgets/safe_convenience_section_widget.dart';
import 'package:fitness_client/features/search/widgets/subject_section_widget.dart';
import 'package:fitness_client/features/subject/controllers/subject_controller.dart';
import 'package:fitness_client/helper/price_converter.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDrawerWidget extends StatefulWidget {
  const FilterDrawerWidget({super.key});

  @override
  State<FilterDrawerWidget> createState() => _FilterDrawerWidgetState();
}

class _FilterDrawerWidgetState extends State<FilterDrawerWidget> {
  // String selectedLocation = '134 Tân Phú, P1, Quận...';
  double price = 3000000; // Giá tiền
  List<bool> selectedGoodReviews = [false, false, false, false, false];

  // Đánh giá tốt
  List<String> goodReviews = ['Vệ sinh tăng cường', 'Thiết bị hiện đại', 'Vị trí tốt', 'Trải nghiệm thú vị', 'Không gian tuyệt vời'];

  // Sở thích cá nhân
  List<String> personalPreferences = ['Riêng tư', 'Thân thiện', 'Ánh sáng', 'Cây xanh', 'Liên kết CLB', 'Có bảo lưu'];
  List<bool> selectedPreferences = [false, false, false, false, false, false];

  int maxDisplay = 6;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConvenienceController>(
      builder: (convenienceController) {
        return GetBuilder<GymController>(
          builder: (gymController) {
            return GetBuilder<SubjectController>(
              builder: (subjectController) {
                return Drawer(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ActionButtonWidget(),
                          SizedBox(height: 20),

                          // Vị trí
                          // Text('Vị trí của bạn', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                          // SizedBox(height: 10),
                          // CustomDropdownButton(
                          //   value: selectedLocation,
                          //   items: <String>['134 Tân Phú, P1, Quận...', 'Địa điểm 2', 'Địa điểm 3'].map<DropdownMenuItem<String>>((String value) {
                          //     return DropdownMenuItem<String>(value: value, child: Text(value));
                          //   }).toList(),
                          //   onChanged: (String? newValue) {
                          //     setState(() {
                          //       selectedLocation = newValue!;
                          //     });
                          //   },
                          // ),
                          // SizedBox(height: 20),

                          // Bộ môn
                          SubjectSectionWidget(subjectController: subjectController, maxDisplay: maxDisplay, gymController: gymController),
                          SizedBox(height: 20),

                          // Đánh giá
                          RatingSectionWidget(gymController: gymController),
                          SizedBox(height: 20),

                          // Giá tiền
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Giá tiền', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                              Text(PriceConverter.formatCurrency(gymController.gymFilter.toPrice), style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          CustomSliderWidget(
                            max: 100000000,
                            min: 0,
                            value: gymController.gymFilter.toPrice,
                            label: PriceConverter.formatCurrency(gymController.gymFilter.toPrice),
                            onChanged: (double newValue) {
                              gymController.updateFilter(toPrice: newValue);
                            },
                          ),

                          SizedBox(height: 20),

                          // Phạm vi
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Phạm vi', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                              Text('${gymController.gymFilter.toDistance.toInt()}Km', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          CustomSliderWidget(
                            max: 100,
                            min: 0,
                            value: gymController.gymFilter.toDistance,
                            label: '${gymController.gymFilter.toDistance.toInt()}Km',
                            onChanged: (double newValue) {
                              gymController.updateFilter(toDistance: newValue);
                            },
                          ),

                          SizedBox(height: 20),

                          // Được đánh giá tốt
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text('Được đánh giá tốt', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                          //     Text('Chi tiết', style: fontRegular),
                          //   ],
                          // ),
                          // Column(
                          //   children: List.generate(goodReviews.length, (index) {
                          //     return Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Expanded(
                          //           child: Text(goodReviews[index], style: TextStyle(fontSize: 15, color: selectedGoodReviews[index] ? Colors.grey[900] : Colors.grey[700])),
                          //         ),
                          //         Checkbox(
                          //           shape: const CircleBorder(),
                          //           activeColor: AppColors.orange300,
                          //           value: selectedGoodReviews[index],
                          //           onChanged: (bool? value) {
                          //             setState(() {
                          //               selectedGoodReviews[index] = value!;
                          //             });
                          //           },
                          //         ),
                          //       ],
                          //     );
                          //   }),
                          // ),
                          // SizedBox(height: 20),

                          // Tiện nghi
                          BasicConvenienceSectionWidget(convenienceController: convenienceController, gymController: gymController, maxDisplay: maxDisplay),
                          SizedBox(height: 20),

                          // Sở thích cá nhân
                          FavoriteSectionConvenience(convenienceController: convenienceController, gymController: gymController, maxDisplay: maxDisplay),

                          SizedBox(height: 20),
                          //An ninh
                          SafeSectionConvenienceWidget(convenienceController: convenienceController, gymController: gymController, maxDisplay: maxDisplay),

                          SizedBox(height: 20),

                          // Cao cấp
                          HighClassSectionConvenienceWidget(convenienceController: convenienceController, gymController: gymController, maxDisplay: maxDisplay),

                          SizedBox(height: 20),
                          
                          CustomButton(
                            color: AppColors.orange300,
                            buttonText: 'Xem kết quả',
                            onPressed: () {
                              // Xem kết quả
                              gymController.resetFilter(isResetAll: false);
                              gymController.getAll();
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
