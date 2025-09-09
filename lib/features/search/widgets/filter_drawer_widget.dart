import 'package:fitness_client/features/search/widgets/action_button_widget.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDrawerWidget extends StatefulWidget {
  const FilterDrawerWidget({super.key});

  @override
  State<FilterDrawerWidget> createState() => _FilterDrawerWidgetState();
}

class _FilterDrawerWidgetState extends State<FilterDrawerWidget> {
  @override
  Widget build(BuildContext context) {
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
              Text('Vị trí của bạn', style: fontRegular),
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
              Text('Bộ môn', style: fontRegular),
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0, // Khoảng cách giữa các chips
                runSpacing: 8.0, // Khoảng cách giữa các dòng
                children: List.generate((activities.length / 2).ceil(), (index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int i = index * 2; i < (index + 1) * 2 && i < activities.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0), // Khoảng cách bên phải
                          child: SizedBox(
                            width: context.width * 0.25,
                            child: ChoiceChip(
                              label: Text(activities[i]),
                              selected: selectedActivity == activities[i],
                              selectedColor: Colors.orange,
                              backgroundColor: Colors.grey[200],
                              onSelected: (selected) {
                                setState(() {
                                  selectedActivity = selected ? activities[i] : null;
                                });
                              },
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Hành động khi nhấn "Xem thêm"
                },
                child: Text('Xem thêm', style: TextStyle(color: Colors.orange)),
              ),
              SizedBox(height: 20),

              // Đánh giá
              Text('Đánh giá', style: fontRegular),
              Column(
                children: List.generate(5, (index) {
                  return RadioListTile<double>(
                    title: Text('Từ ${5 - index} sao'),
                    value: 5 - index.toDouble(),
                    groupValue: rating,
                    onChanged: (double? value) {
                      setState(() {
                        rating = value!;
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 20),

              // Giá tiền
              Text('Giá tiền', style: fontRegular),
              Slider(
                value: price,
                min: 0,
                max: 5000000,
                divisions: 10,
                label: '${price.toInt()} đ',
                onChanged: (newValue) {
                  setState(() {
                    price = newValue;
                  });
                },
              ),
              Text('${price.toInt()} đ', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),

              // Phạm vi
              Text('Phạm vi', style: fontRegular),
              Slider(
                value: range,
                min: 0,
                max: 50,
                divisions: 10,
                label: '${range.toInt()} km',
                onChanged: (newValue) {
                  setState(() {
                    range = newValue;
                  });
                },
              ),
              Text('${range.toInt()} km', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),

              // Được đánh giá tốt
              Text('Được đánh giá tốt', style: fontRegular),
              Column(
                children: List.generate(goodReviews.length, (index) {
                  return CheckboxListTile(
                    title: Text(goodReviews[index]),
                    value: selectedGoodReviews[index],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedGoodReviews[index] = value!;
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 20),

              // Tiện nghi
              Text('Tiện nghi', style: fontRegular),
              Wrap(
                spacing: 8.0,
                children: amenities.map((amenity) {
                  int index = amenities.indexOf(amenity);
                  return ChoiceChip(
                    label: Text(amenity),
                    selected: selectedAmenities[index],
                    onSelected: (selected) {
                      setState(() {
                        selectedAmenities[index] = selected;
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Sở thích cá nhân
              Text('Sở thích cá nhân', style: fontRegular),
              Wrap(
                spacing: 8.0,
                children: personalPreferences.map((preference) {
                  int index = personalPreferences.indexOf(preference);
                  return ChoiceChip(
                    label: Text(preference),
                    selected: selectedPreferences[index],
                    onSelected: (selected) {
                      setState(() {
                        selectedPreferences[index] = selected;
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  // Xem kết quả
                  Get.back();
                },
                child: Text('Xem kết quả'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
