import 'package:fitness_client/helper/route_helper.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 20,
        children: [
          // Phần tiêu đề với tên người dùng
          Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircleAvatar(backgroundColor: Colors.grey[300], radius: 30),
                SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello'),
                      Text('Nguyễn Văn A', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.orange300
                  ),
                  child: IconButton(
                    icon: Icon(Icons.edit,size: 16, color: Colors.white,),
                    onPressed: () {
                      // Thêm hành động khi nhấn nút chỉnh sửa
                    },
                  ),
                ),
              ],
            ),
          ),
          // Danh sách các tùy chọn
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  buildListTile('Thanh toán và chi trả', Icons.credit_card, () => {}),
                  buildListTile('Giới thiệu bạn bè', Icons.people, () => {}),
                  buildListTile('Trở thành đối tác của FitNet', Icons.fitness_center, () => {}),
                  buildListTile('Cách hoạt động của FitNet', Icons.fitness_center, () => {}),
                  buildListTile('Trợ giúp', Icons.help, () => {}),
                  buildListTile('Gửi phản hồi', Icons.help, () => {}),
                  buildListTile('Đăng xuất', Icons.logout, () => {Get.offAllNamed(RouteHelper.signIn)}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListTile(String title, IconData? icon, Function() onTap) {
    bool isLogout = title == 'Đăng xuất';
    return ListTile(
      leading: Icon(icon, size: 24),
      title: Text(title),
      trailing: !isLogout ? Icon(Icons.arrow_forward_ios, size: 16) : null,
      onTap: onTap,
    );
  }
}