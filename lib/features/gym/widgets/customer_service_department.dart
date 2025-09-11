import 'package:fitness_client/common/widgets/avatar_header_widget.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class CustomerServiceDepartmentWidget extends StatelessWidget {
  const CustomerServiceDepartmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AvatarHeaderWidget(
          imageUrl: '',
          textTop: Text('Bộ phận CSKH', style: fontRegular.copyWith(fontSize: 20, fontWeight: FontWeight.w400)),
          textBottom: Text('Gym California', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w300)),
        ),
        SizedBox(height: 16),
        buildTile('Địa điểm tuyệt vời', Icons.local_activity),
        SizedBox(height: 4),
        buildTile('Vệ sinh tằng cường', Icons.wash_rounded),
        SizedBox(height: 4),
        buildTile('Trang thiết bị hiện đại', Icons.settings),
        SizedBox(height: 16),
        Text('Tỷ lệ phản hồi: 100%', style: fontRegular.copyWith(fontSize: 16)),
        SizedBox(height: 4),
        Text('Thời gian phản hồi: trong vòng 1 giờ', style: fontRegular.copyWith(fontSize: 16)),
        SizedBox(height: 16),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: Text(
                'Để bảo vệ khoản thanh toán của bạn, tuyệt đối không '
                'chuyển tiền hoặc liên lạc bên ngoài trang web '
                'hỗ trợ ứng dụng Karmel.',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ),
            Icon(Icons.shield_outlined, color: AppColors.orange300),
          ],
        ),
      ],
    );
  }

  Widget buildTile(String text, IconData icon) {
    return Row(
      spacing: 10,
      children: [
        Icon(icon, color: Colors.grey[800]),
        Text(text, style: fontRegular.copyWith(fontSize: 16)),
      ],
    );
  }
}
