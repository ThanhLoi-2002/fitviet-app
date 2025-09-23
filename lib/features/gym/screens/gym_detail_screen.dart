import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/custom_list_tile_widget.dart';
import 'package:fitness_client/common/widgets/divider_widget.dart';
import 'package:fitness_client/features/gym/controllers/gym_controller.dart';
import 'package:fitness_client/features/gym/widgets/conveniences_widget.dart';
import 'package:fitness_client/features/gym/widgets/gym_app_bar_widget.dart';
import 'package:fitness_client/features/gym/widgets/overlapping_card_widget.dart';
import 'package:fitness_client/features/rating/controllers/rating_controller.dart';
import 'package:fitness_client/features/rating/widgets/map_and_rating_widget.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class GymDetailScreen extends StatefulWidget {
  const GymDetailScreen({super.key, required this.gymId});
  final String gymId;

  @override
  State<GymDetailScreen> createState() => _GymDetailScreenState();
}

class _GymDetailScreenState extends State<GymDetailScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<GymController>().getGymById(widget.gymId).then((response) => {Get.find<RatingController>().reset(), Get.find<RatingController>().getAll(gymId: widget.gymId, limit: 5)});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GymController>(
      builder: (gymController) {
        return gymController.gym == null
            ? Shimmer(
                duration: const Duration(seconds: 2),
                child: Container(
                  padding: EdgeInsets.all(30),
                  height: context.height,
                  width: context.width,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                ),
              )
            : Scaffold(
                body: CustomScrollView(
                  slivers: [
                    GymAppBarWidget(images: gymController.gym!.images!.isNotEmpty ? gymController.gym!.images! : ['']),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OverlappingCardWidget(gym: gymController.gym!),

                            ConveniencesWidget(gym: gymController.gym!),

                            // CustomerServiceDepartmentWidget(),
                            MapAndRatingWidget(gym: gymController.gym!),
                            DividerWidget(),
                            CustomListTileWidget(title: 'Điều khoản và dịch vụ', onTap: () => {}),
                            CustomListTileWidget(title: 'Nội quy', onTap: () => {}),
                            CustomListTileWidget(title: 'Y tế và an toàn', onTap: () => {}),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: Row(
                        spacing: 20,
                        children: [
                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding: EdgeInsets.all(12),
                          //     decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.orange300),
                          //     child: Icon(Icons.message_outlined, color: Colors.white),
                          //   ),
                          // ),
                          Expanded(
                            child: CustomButton(onPressed: () {}, buttonText: 'Đặt ngay', color: AppColors.orange300),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
