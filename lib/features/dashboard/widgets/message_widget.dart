import 'package:fitness_client/features/dashboard/screens/inbox_screen.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({super.key, required this.message});
  final Message message;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: Text(widget.message.sender[0], style: TextStyle(fontSize: 20, color: Colors.black)),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              widget.message.sender,
              style: fontRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
              overflow: TextOverflow.ellipsis, // Thêm thuộc tính này
              maxLines: 1,
            ),
          ),
          Text(widget.message.time),
        ],
      ),
      subtitle: Row(
        spacing: 10,
        children: [
          Expanded(
            child: Text(
              widget.message.status,
              overflow: TextOverflow.ellipsis, // Thêm thuộc tính này
              maxLines: 1,
            ),
          ),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.orange300),
          ),
        ],
      ),
      // trailing: Text(message.time),
    );
  }
}
