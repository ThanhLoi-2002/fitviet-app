import 'package:flutter/material.dart';

class IconCircleButton extends StatelessWidget {
  const IconCircleButton({super.key, required this.onTap, this.width, this.height, this.backgroundColor, this.iconSize, required this.icon});
  final Function() onTap;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double? iconSize;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Container(
        width: width ?? 30,
        height: height ?? 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: backgroundColor ?? Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey[700]!)),
        child: Icon(icon, size: iconSize ?? 18),
      ),
    );
  }
}
