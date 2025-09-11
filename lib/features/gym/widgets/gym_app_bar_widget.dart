import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitness_client/common/widgets/icon_circle_button.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GymAppBarWidget extends StatefulWidget {
  const GymAppBarWidget({super.key});

  @override
  State<GymAppBarWidget> createState() => _GymAppBarWidgetState();
}

class _GymAppBarWidgetState extends State<GymAppBarWidget> {
  final List<String> imgList = [AppConstants.imgDefault, AppConstants.imgDefault, AppConstants.imgDefault];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      stretch: true,
      leading: IconCircleButton(icon: Icons.arrow_back_ios_rounded, onTap: () => Get.back()),
      actions: [
        IconCircleButton(icon: Icons.share_outlined, onTap: () {}),
        IconCircleButton(icon: Icons.favorite_border, onTap: () {}),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            CarouselSlider.builder(
              options: CarouselOptions(
                height: 230,
                autoPlay: false,
                enlargeCenterPage: false,
                aspectRatio: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index; // Cập nhật chỉ số ảnh hiện tại
                  });
                },
              ),
              itemCount: imgList.isEmpty ? 1 : imgList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(image: NetworkImage(imgList[index]), fit: BoxFit.cover),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 10,
              child: SizedBox(
                width: context.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.asMap().entries.map((entry) {
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
        ),
      ),
    );
  }
}
