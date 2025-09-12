import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/custom_image_widget.dart';
import 'package:fitness_client/common/widgets/divider_widget.dart';
import 'package:fitness_client/features/gym/domains/models/gym.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class ConveniencesWidget extends StatefulWidget {
  const ConveniencesWidget({super.key, required this.gym});
  final Gym gym;

  @override
  State<ConveniencesWidget> createState() => _ConveniencesWidgetState();
}

class _ConveniencesWidgetState extends State<ConveniencesWidget> {
  bool _isExpanded = false;
  // Chọn số lượng mục tối đa hiển thị
  int get itemCountToShow => widget.gym.basicConvenience!.length <= 3 ? widget.gym.basicConvenience!.length : (_isExpanded ? widget.gym.basicConvenience!.length : 3);
  @override
  Widget build(BuildContext context) {
    return widget.gym.basicConvenience!.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DividerWidget(),
              SizedBox(height: 10),
              Text('Tiện nghi', style: fontRegular.copyWith(fontSize: 18)),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: itemCountToShow,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CustomImageWidget(imageUrl: widget.gym.basicConvenience![index].logo!, width: 34, height: 34, borderRadius: 8,),
                    title: Text(widget.gym.basicConvenience![index].name!),
                  );
                },
              ),
              // Hiển thị nút "Hiển thị thêm" nếu có nhiều hơn 3 mục
              if (widget.gym.basicConvenience!.length > 3)
                CustomButton(
                  buttonText: _isExpanded ? 'Ẩn bớt' : 'Hiển thị thêm ${widget.gym.basicConvenience!.length - 3} tiện nghi',
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded; // Đổi trạng thái mở rộng
                    });
                  },
                  color: Colors.white,
                  isBorder: true,
                  textColor: Colors.grey[900],
                  isBold: false,
                ),
            ],
          )
        : SizedBox();
  }
}
