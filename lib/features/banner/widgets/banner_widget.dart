import 'package:fitness_client/common/widgets/custom_carousel_widget.dart';
import 'package:fitness_client/features/banner/controllers/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      builder: (bannerController) {
      List<String> images = bannerController.banners.map((b) => b.logo!).toList();
        return bannerController.banners.isEmpty
            ? SizedBox()
            : CustomCarouselWidget(height: 137, images: images);
      },
    );
  }
}
