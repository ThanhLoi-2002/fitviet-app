import 'package:fitness_client/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tiêu đề
                Text('Register to FitNet', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 40),
                // Trường nhập tên đăng nhập
                TextField(
                  decoration: InputDecoration(labelText: 'Tên đăng nhập', border: OutlineInputBorder()),
                ),
                SizedBox(height: 16),
                // Trường nhập email
                TextField(
                  decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                ),
                SizedBox(height: 16),
                // Trường nhập số điện thoại
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                    border: OutlineInputBorder(),
                    prefixText: '+84 ', // Mã vùng cho Việt Nam
                  ),
                ),
                SizedBox(height: 16),
                // Trường nhập mật khẩu
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Mật khẩu', border: OutlineInputBorder()),
                ),
                SizedBox(height: 16),
                // Trường nhập xác nhận mật khẩu
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Nhập lại mật khẩu', border: OutlineInputBorder()),
                ),
                SizedBox(height: 20),
                // Nút Đăng ký
                ElevatedButton(
                  onPressed: () {
                    // Hành động đăng ký
                  },
                  child: Text('Đăng ký'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Màu nền
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                ),
                SizedBox(height: 20),
                // Liên kết đăng nhập
                TextButton(
                  onPressed: () {
                    // Hành động quay lại trang đăng nhập
                    Get.offAllNamed(RouteHelper.signIn);
                  },
                  child: Text('Đã có tài khoản? Đăng nhập ngay'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}