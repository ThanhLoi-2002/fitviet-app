import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class AmenitiesWidget extends StatefulWidget {
  const AmenitiesWidget({super.key});

  @override
  State<AmenitiesWidget> createState() => _AmenitiesWidgetState();
}

class _AmenitiesWidgetState extends State<AmenitiesWidget> {
  bool _isExpanded = false;
  List<Amenity> items = [
    Amenity(icon: Icons.wifi, label: 'Wifi miễn phí'),
    Amenity(icon: Icons.ac_unit, label: 'Điều hòa'),
    Amenity(icon: Icons.spa, label: 'Xông hơi'),
    Amenity(icon: Icons.lock, label: 'Tủ đồ'),
    Amenity(icon: Icons.local_parking, label: 'Bãi đỗ xe'),
    Amenity(icon: Icons.shower, label: 'Phòng tắm'),
  ];
  // Chọn số lượng mục tối đa hiển thị
  int get itemCountToShow => _isExpanded ? items.length : 3;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tiện nghi', style: fontRegular.copyWith(fontSize: 18)),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCountToShow,
          itemBuilder: (context, index) {
            return ListTile(leading: Icon(items[index].icon), title: Text(items[index].label));
          },
        ),
        // Hiển thị nút "Hiển thị thêm" nếu có nhiều hơn 3 mục
        if (items.length > 3)
          CustomButton(
            buttonText: _isExpanded ? 'Ẩn bớt' : 'Hiển thị thêm ${items.length - 3} tiện nghi',
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
    );
  }
}

class Amenity {
  const Amenity({required this.icon, required this.label});

  final IconData icon;
  final String label;
}
