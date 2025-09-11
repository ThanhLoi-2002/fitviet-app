import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitness_client/common/widgets/custom_image_widget.dart';
import 'package:fitness_client/features/banner/controllers/banner_controller.dart';
import 'package:fitness_client/util/dimensions.dart';
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
        return bannerController.banners.isEmpty
            ? SizedBox()
            : CarouselSlider.builder(
                options: CarouselOptions(
                  height: 137,
                  autoPlay: false,
                  enlargeCenterPage: false,
                  aspectRatio: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index; // Cập nhật chỉ số ảnh hiện tại
                    });
                  },
                ),
                itemCount: bannerController.banners.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    child: CustomImageWidget(width: double.infinity, height: 137, imageUrl: bannerController.banners[index].logo!, fit: BoxFit.fill),
                  );
                },
              );
      },
    );
  }
}
