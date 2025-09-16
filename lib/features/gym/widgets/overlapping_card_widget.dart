import 'package:fitness_client/common/widgets/custom_dropdown_button.dart';
import 'package:fitness_client/common/widgets/divider_widget.dart';
import 'package:fitness_client/common/widgets/text_load_more_widget.dart';
import 'package:fitness_client/features/gym/domains/models/gym.dart';
import 'package:fitness_client/features/gym/widgets/subject_widget.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class OverlappingCardWidget extends StatefulWidget {
  const OverlappingCardWidget({super.key, required this.gym});
  final Gym gym;

  @override
  State<OverlappingCardWidget> createState() => _OverlappingCardWidgetState();
}

class _OverlappingCardWidgetState extends State<OverlappingCardWidget> {
  List<String> list = ['134 Tân Phú, P1, Quận...', 'Địa điểm 2', 'Địa điểm 3'];
  String? dropdownValue;

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
        Text(widget.gym.name!, style: fontBold.copyWith(fontSize: 22)),
        const SizedBox(height: 4),
        Text(widget.gym.address!, style: fontRegular.copyWith(fontSize: 16, color: Colors.grey[600])),
        const SizedBox(height: 16),

        if (widget.gym.subjects != null && widget.gym.subjects!.isNotEmpty) ...[
          Text('Nơi bạn sẽ tập luyện', style: fontRegular.copyWith(fontSize: 18)),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
              children: List.generate((widget.gym.subjects!.length).ceil(), (index) {
                return SubjectWidget(subject: widget.gym.subjects![index], onTap: () {});
              }),
            ),
          ),
          const SizedBox(height: 12),
        ],
        Text('Mở cửa ${widget.gym.openingTime?.from?.toInt()}h - ${widget.gym.openingTime?.to?.toInt()}h', style: fontMedium.copyWith(fontSize: 16, fontWeight: FontWeight.w300)),
        const SizedBox(height: 12),
        // CustomDropdownButton(
        //   value: dropdownValue,
        //   hintText: 'Danh sách chi nhánh',
        //   items: list.map<DropdownMenuItem<String>>((String value) {
        //     return DropdownMenuItem<String>(value: value, child: Text(value));
        //   }).toList(),
        //   onChanged: (String? newValue) {
        //     setState(() {
        //       dropdownValue = newValue!;
        //     });
        //   },
        // ),
        const SizedBox(height: 30),
        DividerWidget(),
        const SizedBox(height: 10),
        Text('Giới thiệu về địa điểm này', style: fontRegular.copyWith(fontSize: 18)),
        const SizedBox(height: 12),
        TextLoadMoreWidget(
          text: widget.gym.description!,
          style: fontRegular.copyWith(fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
