import 'package:fitness_client/common/widgets/custom_carousel_widget.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key, required this.images});
  final List<String> images;

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.images.isEmpty ? SizedBox() : CustomCarouselWidget(height: 137, images: widget.images);
  }
}
