import 'package:flutter/material.dart';

class CardDrawerWidget extends StatelessWidget {
  const CardDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => {},
                child: ListTile(leading: Icon(Icons.qr_code), title: Text('QR Code')),
              ),

              InkWell(
                onTap: () => {},
                child: ListTile(leading: Icon(Icons.dashboard), title: Text('Thông tin thẻ tập')),
              ),
              InkWell(
                onTap: () => {},
                child: ListTile(leading: Icon(Icons.star), title: Text('Đánh giá')),
              ),
              InkWell(
                onTap: () => {},
                child: ListTile(leading: Icon(Icons.help), title: Text('Hỗ trợ từ phòng tập')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
