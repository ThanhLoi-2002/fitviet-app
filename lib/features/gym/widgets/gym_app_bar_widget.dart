import 'package:fitness_client/common/widgets/custom_carousel_widget.dart';
import 'package:fitness_client/common/widgets/icon_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GymAppBarWidget extends StatefulWidget {
  const GymAppBarWidget({super.key, required this.images});
  final List<String> images;

  @override
  State<GymAppBarWidget> createState() => _GymAppBarWidgetState();
}

class _GymAppBarWidgetState extends State<GymAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      stretch: true,
      leading: IconCircleButton(icon: Icons.arrow_back_ios_rounded, onTap: () => Get.back()),
      actions: [
        IconCircleButton(icon: Icons.share_outlined, onTap: () {}),
        // IconCircleButton(icon: Icons.favorite_border, onTap: () {}),
      ],
      flexibleSpace: FlexibleSpaceBar(background: CustomCarouselWidget(images: widget.images)),
    );
  }
}
