import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCarouselWidget extends StatefulWidget {
  const CustomCarouselWidget({super.key, this.height, this.autoPlay, required this.images});
  final double? height;
  final bool? autoPlay;
  final List<String> images;

  @override
  State<CustomCarouselWidget> createState() => _CustomCarouselWidgetState();
}

class _CustomCarouselWidgetState extends State<CustomCarouselWidget> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      // Nếu danh sách rỗng, hiển thị một widget khác
      return SizedBox(
        height: widget.height ?? 230,
        child: Center(
          child: Text('Không có hình ảnh nào để hiển thị', style: TextStyle(fontSize: 16, color: Colors.grey)),
        ),
      );
    }

    return Stack(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: widget.height ?? 230,
            autoPlay: widget.autoPlay ?? false,
            enlargeCenterPage: false,
            aspectRatio: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index; // Cập nhật chỉ số ảnh hiện tại
              });
            },
          ),
          itemCount: widget.images.isEmpty ? 1 : widget.images.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(image: NetworkImage(widget.images[index]), fit: BoxFit.cover),
              ),
            );
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: SizedBox(
            width: context.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: currentIndex == entry.key ? Colors.white : Colors.grey),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
