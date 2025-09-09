import 'package:fitness_client/common/widgets/confirmation_dialog.dart';
import 'package:fitness_client/common/widgets/not_logged_in_screen.dart';
import 'package:fitness_client/common/widgets/customer_image_widget.dart';
import 'package:fitness_client/features/auth/controllers/auth_controller.dart';
import 'package:fitness_client/features/profile/controllers/profile_controller.dart';
import 'package:fitness_client/helper/auth_helper.dart';
import 'package:fitness_client/helper/route_helper.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    if (AuthHelper.isLoggedIn()) {
      Get.find<ProfileController>().getMyInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return !AuthHelper.isLoggedIn()
        ? NotLoggedInScreen()
        : GetBuilder<ProfileController>(
            builder: (profileController) {
              return Scaffold(
                body: Column(
                  spacing: 20,
                  children: [
                    // Phần tiêu đề với tên người dùng
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Container(
                            height: 80, // Chiều cao tổng thể (để bao gồm viền)
                            width: 80, // Chiều rộng tổng thể (để bao gồm viền)
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey[400]!, // Màu viền
                                width: 2, // Độ dày viền
                              ),
                            ),
                            child: ClipOval(
                              child: CustomImageWidget(imageUrl: profileController.client?.avatar ?? '', height: 70, width: 70, fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hello'),
                                Text(profileController.client?.name ?? "Your name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.orange300),
                            child: IconButton(
                              icon: Icon(Icons.edit, size: 16, color: Colors.white),
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
                            buildListTile('Đăng xuất', Icons.logout, () => {logout()}),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }

  Widget buildListTile(String title, IconData? icon, Function() onTap) {
    bool isLogout = title == 'Đăng xuất';
    return ListTile(leading: Icon(icon, size: 24), title: Text(title), trailing: !isLogout ? Icon(Icons.arrow_forward_ios, size: 16) : null, onTap: onTap);
  }

  void logout() {
    Get.dialog(
      ConfirmationDialog(
        icon: Icons.help,
        description: 'Bạn có chắc muốn đăng xuất',
        isLogOut: true,
        onYesPressed: () async {
          Get.find<ProfileController>().clearUserInfo();
          await Get.find<AuthController>().clearSharedData();
          Get.find<AuthController>().socialLogout();
          Get.offAllNamed(RouteHelper.signIn);
        },
      ),
      useSafeArea: false,
    );
  }
}
