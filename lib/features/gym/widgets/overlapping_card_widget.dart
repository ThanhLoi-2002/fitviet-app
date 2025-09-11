import 'package:fitness_client/common/widgets/custom_dropdown_button.dart';
import 'package:fitness_client/common/widgets/divider_widget.dart';
import 'package:fitness_client/common/widgets/text_load_more_widget.dart';
import 'package:fitness_client/features/gym/widgets/subject_widget.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class OverlappingCardWidget extends StatefulWidget {
  const OverlappingCardWidget({super.key});

  @override
  State<OverlappingCardWidget> createState() => _OverlappingCardWidgetState();
}

class _OverlappingCardWidgetState extends State<OverlappingCardWidget> {
  List<String> list = ['134 Tân Phú, P1, Quận...', 'Địa điểm 2', 'Địa điểm 3'];
  String? dropdownValue;
      String text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
      'Mauris viverra maecenas proin sed. Porttitor non dui facilisis '
      'feugiat liberoutio tellus. Donec euismod, nisl eget consectetur '
      'tempus, nisl erat pharetra nisl, euismod tincidunt nisl erat eget '
      'ligula.';

  @override
  void initState() {
    super.initState();
    dropdownValue = list[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gym California', style: fontBold.copyWith(fontSize: 22)),
        const SizedBox(height: 4),
        Text('Cổng Hòa - Tân Bình', style: fontRegular.copyWith(fontSize: 16, color: Colors.grey[600])),
        const SizedBox(height: 16),
        Text('Nơi bạn sẽ tập luyện', style: fontRegular.copyWith(fontSize: 18)),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: [
              SubjectWidget(icon: Icons.fitness_center, label: 'Gym', onTap: () {}),
              SubjectWidget(label: 'Yoga', icon: Icons.self_improvement, onTap: () {}),
              SubjectWidget(label: 'Boxing', icon: Icons.sports_mma_sharp, onTap: () {}),
              SubjectWidget(label: 'Đạp xe', icon: Icons.directions_bike, onTap: () {}),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text('Mở cửa 4:00 AM - 21:00 PM', style: fontMedium.copyWith(fontSize: 16, fontWeight: FontWeight.w300)),
        const SizedBox(height: 12),
        CustomDropdownButton(
          value: dropdownValue,
          hintText: 'Danh sách chi nhánh',
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
        ),
        const SizedBox(height: 30),
        DividerWidget(),
        const SizedBox(height: 10),
        Text('Giới thiệu về địa điểm này', style: fontRegular.copyWith(fontSize: 18)),
        const SizedBox(height: 12),
        TextLoadMoreWidget(text: text, style: fontRegular.copyWith(fontSize: 14, fontWeight: FontWeight.w300)),
      ],
    );
  }
}
