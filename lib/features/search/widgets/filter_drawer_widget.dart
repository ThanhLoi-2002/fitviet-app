import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/custom_slider_widget.dart';
import 'package:fitness_client/features/search/widgets/action_button_widget.dart';
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
  String? selectedLocation = '134 Tân Phú, P1, Quận...';
  String? selectedActivity = 'Gym';
  double rating = 4.0;
  double price = 3000000; // Giá tiền
  double range = 17; // Phạm vi
  List<bool> selectedGoodReviews = [false, false, false, false, false];

  // Đánh giá tốt
  List<String> goodReviews = ['Vệ sinh tăng cường', 'Thiết bị hiện đại', 'Vị trí tốt', 'Trải nghiệm thú vị', 'Không gian tuyệt vời'];

  // Tiện nghi
  List<String> amenities = ['Wifi', 'Hồ bơi', 'Sauna', 'Máy sấy'];
  List<bool> selectedAmenities = [false, false, false, false];

  // Sở thích cá nhân
  List<String> personalPreferences = ['Riêng tư', 'Thân thiện', 'Ánh sáng', 'Cây xanh', 'Liên kết CLB', 'Có bảo lưu'];
  List<bool> selectedPreferences = [false, false, false, false, false, false];

  // Bộ môn
  List<String> activities = ['Yoga', 'Gym', 'Boxing', 'Crossfit'];
  @override
  Widget build(BuildContext context) {
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
              Text('Vị trí của bạn', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedLocation,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                items: <String>['134 Tân Phú, P1, Quận...', 'Địa điểm 2', 'Địa điểm 3'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLocation = newValue;
                  });
                },
              ),
              SizedBox(height: 20),

              // Bộ môn
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bộ môn', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextButton(
                    onPressed: () {
                      // Hành động khi nhấn "Xem thêm"
                    },
                    child: Text('Xem thêm', style: fontRegular.copyWith()),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0, // Khoảng cách giữa các chips
                runSpacing: 8.0, // Khoảng cách giữa các dòng
                children: List.generate((activities.length / 2).ceil(), (index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = index * 2; i < (index + 1) * 2 && i < activities.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0), // Khoảng cách bên phải
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedActivity = selectedActivity == activities[i] ? null : activities[i];
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3, // Sử dụng MediaQuery để lấy kích thước
                              height: MediaQuery.of(context).size.height * 0.07, // Sử dụng MediaQuery để lấy kích thước
                              alignment: Alignment.center, // Căn giữa nội dung
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: selectedActivity == activities[i] ? AppColors.orange300 : Colors.grey[200], // Màu nền thay đổi khi được chọn
                              ),
                              child: Text(
                                activities[i],
                                style: TextStyle(
                                  color: selectedActivity == activities[i] ? Colors.white : Colors.black, // Màu chữ thay đổi khi được chọn
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 20),

              // Đánh giá
              Text('Đánh giá', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
              Column(
                children: List.generate(5, (index) {
                  int star = 5 - index;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('Từ $star sao', style: TextStyle(fontSize: 15, color: star == rating ? Colors.grey[900] : Colors.grey[700])),
                      ),
                      Radio<double>(
                        activeColor: AppColors.orange300,
                        value: 5 - index.toDouble(),
                        groupValue: rating,
                        onChanged: (double? value) {
                          setState(() {
                            rating = value!;
                          });
                        },
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 20),

              // Giá tiền
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Giá tiền', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text('${price.toInt()} đ', style: TextStyle(fontSize: 16)),
                ],
              ),
              CustomSliderWidget(
                max: 5000000,
                min: 0,
                price: price,
                label: '${price.toInt()} đ',
                onChanged: (double newValue) {
                  setState(() {
                    price = newValue;
                  });
                },
              ),

              SizedBox(height: 20),

              // Phạm vi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Phạm vi', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text('${range.toInt()} km', style: TextStyle(fontSize: 16)),
                ],
              ),
              CustomSliderWidget(
                max: 50,
                min: 0,
                price: range,
                label: '${range.toInt()} km',
                onChanged: (double newValue) {
                  setState(() {
                    range = newValue;
                  });
                },
              ),

              SizedBox(height: 20),

              // Được đánh giá tốt
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Được đánh giá tốt', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text('Chi tiết', style: fontRegular),
                ],
              ),
              Column(
                children: List.generate(goodReviews.length, (index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(goodReviews[index], style: TextStyle(fontSize: 15, color: selectedGoodReviews[index] ? Colors.grey[900] : Colors.grey[700])),
                      ),
                      Checkbox(
                        shape: const CircleBorder(),
                        activeColor: AppColors.orange300,
                        value: selectedGoodReviews[index],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedGoodReviews[index] = value!;
                          });
                        },
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 20),

              // Tiện nghi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tiện nghi', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text('Xem thêm', style: fontRegular),
                ],
              ),
              SizedBox(height: 10),
              Wrap(
                              spacing: 8.0, // Khoảng cách giữa các chips
                              runSpacing: 8.0, // Khoảng cách giữa các dòng
                              children: List.generate((activities.length / 2).ceil(), (index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = index * 2; i < (index + 1) * 2 && i < activities.length; i++)
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0), // Khoảng cách bên phải
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              // Toggled selection for the activity
                                              selectedActivity = selectedActivity == activities[i] ? null : activities[i];
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.3, // Sử dụng MediaQuery để lấy kích thước
                                            height: MediaQuery.of(context).size.height * 0.07, // Sử dụng MediaQuery để lấy kích thước
                                            alignment: Alignment.center, // Căn giữa nội dung
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: selectedActivity == activities[i] ? AppColors.orange300 : Colors.grey[200], // Màu nền thay đổi khi được chọn
                                            ),
                                            child: Text(
                                              activities[i],
                                              style: TextStyle(
                                                color: selectedActivity == activities[i] ? Colors.white : Colors.black, // Màu chữ thay đổi khi được chọn
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              }),
                            ),
              SizedBox(height: 20),

              // Sở thích cá nhân
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sở thích cá nhân', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text('Xem thêm', style: fontRegular),
                ],
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0, // Khoảng cách giữa các chips
                runSpacing: 8.0, // Khoảng cách giữa các dòng
                children: List.generate((personalPreferences.length / 2).ceil(), (index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = index * 2; i < (index + 1) * 2 && i < personalPreferences.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0), // Khoảng cách bên phải
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // Toggle selection for the preference
                                selectedPreferences[i] = !selectedPreferences[i];
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3, // Sử dụng MediaQuery để lấy kích thước
                              height: MediaQuery.of(context).size.height * 0.07, // Sử dụng MediaQuery để lấy kích thước
                              alignment: Alignment.center, // Căn giữa nội dung
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: selectedPreferences[i] ? AppColors.orange300 : Colors.grey[200], // Màu nền thay đổi khi được chọn
                              ),
                              child: Text(
                                personalPreferences[i],
                                style: TextStyle(
                                  color: selectedPreferences[i] ? Colors.white : Colors.black, // Màu chữ thay đổi khi được chọn
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 20),

              CustomButton(
                color: AppColors.orange300,
                buttonText: 'Xem kết quả',
                onPressed: () {
                  // Xem kết quả
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
