import 'package:flutter/material.dart';

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({super.key, required this.title, this.icon, required this.onTap});
  final String title;
  final IconData? icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isLogout = title == 'Đăng xuất';
    return ListTile(leading: icon != null ? Icon(icon, size: 24) : null, title: Text(title), trailing: !isLogout ? Icon(Icons.arrow_forward_ios, size: 16) : null, onTap: onTap);
  }
}
