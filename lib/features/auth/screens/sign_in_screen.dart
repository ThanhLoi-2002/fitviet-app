import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness_client/helper/route_helper.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed(RouteHelper.initial);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Biểu tượng thể hình
                Icon(Icons.fitness_center, size: 60, color: Colors.orange),
                SizedBox(height: 20),
                // Tiêu đề
                Text('Welcome to FitNet', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 40),
                // Trường nhập số điện thoại hoặc email
                TextField(
                  decoration: InputDecoration(labelText: 'Số điện thoại hoặc Email', border: OutlineInputBorder()),
                ),
                SizedBox(height: 16),
                // Trường nhập mật khẩu
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Mật khẩu', border: OutlineInputBorder()),
                ),
                SizedBox(height: 8),
                // Checkbox "Ghi nhớ mật khẩu"
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (value) {}),
                        Text('Ghi nhớ mật khẩu'),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Hành động quên mật khẩu
                      },
                      child: Text('Quên mật khẩu?'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Nút Đăng nhập
                ElevatedButton(
                  onPressed: () {
                    // Hành động đăng nhập
                  },
                  child: Text('Đăng nhập'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Màu nền
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                ),
                SizedBox(height: 20),
                // Khu vực đăng nhập bằng mạng xã hội
                Text('hoặc đăng nhập bằng'),
                SizedBox(height: 10),
                // Nút đăng nhập bằng Google
                ElevatedButton.icon(
                  onPressed: () {
                    // Hành động đăng nhập bằng Google
                  },
                  icon: Icon(Icons.login, color: Colors.black),
                  label: Text('Google', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Màu nền
                  ),
                ),
                SizedBox(height: 20),
                // Liên kết đăng ký
                TextButton(
                  onPressed: () {
                    Get.offAllNamed(RouteHelper.signUp);
                  },
                  child: Text('Chưa có tài khoản? Đăng ký ngay'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
