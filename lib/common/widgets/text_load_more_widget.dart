import 'package:flutter/material.dart';

class TextLoadMoreWidget extends StatefulWidget {
  const TextLoadMoreWidget({super.key, required this.text, this.style, this.limit});
  final String text;
  final TextStyle? style;
  final int? limit;

  @override
  State<TextLoadMoreWidget> createState() => _TextLoadMoreWidgetState();
}

class _TextLoadMoreWidgetState extends State<TextLoadMoreWidget> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hiển thị văn bản
        Text(
          _isExpanded ? widget.text : (widget.text.split(' ').length > (widget.limit ?? 30) ? '${widget.text.split(' ').take(widget.limit ?? 30).join(' ')}...' : widget.text),
          style: widget.style ?? TextStyle(fontSize: 16),
          maxLines: _isExpanded ? null : 2, // Tối đa 2 dòng nếu không mở rộng
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis, // Hiển thị dấu "..."
        ),
        const SizedBox(height: 8),
        // Nút hiển thị thêm
        if (widget.text.split(' ').length > (widget.limit ?? 30))
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded; // Đổi trạng thái mở rộng
              });
            },
            child: Text(_isExpanded ? 'Ẩn bớt' : 'Hiển thị thêm', style: TextStyle(color: Colors.blue)),
          ),
      ],
    );
  }
}
