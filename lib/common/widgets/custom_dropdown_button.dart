import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({super.key, required this.items, required this.onChanged, this.value, this.hintText});
  final List<DropdownMenuItem<String>> items;
  final Function(String? newValue) onChanged;
  final String? value;
  final String? hintText;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: widget.value ?? widget.items[0].value,
      hint: Text(widget.hintText ?? 'Chọn một giá trị'),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      items: widget.items,
      onChanged: widget.onChanged,
    );
  }
}
