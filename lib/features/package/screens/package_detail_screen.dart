import 'package:fitness_client/common/widgets/custom_image_widget.dart';
import 'package:fitness_client/common/widgets/custom_list_tile_widget.dart';
import 'package:fitness_client/common/widgets/divider_widget.dart';
import 'package:fitness_client/common/widgets/text_load_more_widget.dart';
import 'package:fitness_client/common/widgets/text_row_widget.dart';
import 'package:fitness_client/features/banner/widgets/banner_widget.dart';
import 'package:fitness_client/features/gym/controllers/gym_controller.dart';
import 'package:fitness_client/features/gym/widgets/conveniences_widget.dart';
import 'package:fitness_client/features/gym/widgets/overlapping_card_widget.dart';
import 'package:fitness_client/features/package/controllers/package_controller.dart';
import 'package:fitness_client/features/package/domains/enums/packag_enum.dart';
import 'package:fitness_client/features/package/widgets/price_widget.dart';
import 'package:fitness_client/features/profile/controllers/profile_controller.dart';
import 'package:fitness_client/features/rating/widgets/map_and_rating_widget.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageDetailScreen extends StatefulWidget {
  const PackageDetailScreen({super.key, required this.id});
  final String id;

  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<PackageController>().getPackageById(widget.id);

    String? gymId = Get.find<ProfileController>().client!.gym;

    if (gymId != null) {
      Get.find<GymController>().getGymById(gymId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
      builder: (packageController) {
        return GetBuilder<GymController>(
          builder: (gymController) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Các gói tập', style: fontMedium.copyWith(fontSize: 20)),
                centerTitle: true,
                // actions: [
                //   Padding(
                //     padding: const EdgeInsets.only(right: 16),
                //     child: InkWell(
                //       borderRadius: BorderRadius.all(Radius.circular(20)),
                //       onTap: () {},
                //       child: Padding(padding: const EdgeInsets.all(4.0), child: Icon(Icons.more_vert)),
                //     ),
                //   ),
                // ],
              ),
              body: Container(
                height: context.height,
                padding: const EdgeInsets.all(16),
                color: Colors.grey[100],
                child: packageController.package == null
                    ? SizedBox()
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                spacing: 15,
                                children: [
                                  CustomImageWidget(imageUrl: packageController.package!.images!.isNotEmpty ? packageController.package!.images![0] : "", width: 100, borderRadius: 8),
                                  Column(
                                    spacing: 5,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        packageController.package!.name!,
                                        style: fontRegular.copyWith(color: AppColors.orange300, fontSize: 20, fontWeight: FontWeight.w600),
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      PriceWidget(originalPrice: packageController.package!.price!, promotionalPrice: packageController.package!.promotionalPrice!),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),

                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 10,
                                children: [
                                  TextRowWidget(textLeft: 'Loại', textRight: 'Gói ${packageController.package!.timePeriodType!.valueInVietnamese}'),
                                  TextRowWidget(textLeft: 'Thời hạn', textRight: '${packageController.package!.duration} ${packageController.package!.timePeriodType!.valueInVietnamese}'),
                                  TextRowWidget(textLeft: 'Tổng số buổi', textRight: '${packageController.package!.totalSessions!.toInt()} buổi'),
                                  Text('Mô tả', style: fontRegular.copyWith(fontSize: 16, color: Colors.grey[700])),

                                  TextLoadMoreWidget(
                                    text: packageController.package!.description ?? "Chưa có mô tả nào",
                                    style: fontRegular.copyWith(fontSize: 14, fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                children: [
                                  BannerWidget(images: gymController.gym!.images!),
                                  SizedBox(height: 16),
                                  OverlappingCardWidget(gym: gymController.gym!),

                                  ConveniencesWidget(gym: gymController.gym!),

                                  // CustomerServiceDepartmentWidget(),
                                  MapAndRatingWidget(gym: gymController.gym!),
                                  DividerWidget(),
                                  CustomListTileWidget(title: 'Điều khoản và dịch vụ', onTap: () => {}),
                                  CustomListTileWidget(title: 'Nội quy', onTap: () => {}),
                                  CustomListTileWidget(title: 'Y tế và an toàn', onTap: () => {}),
                                ],
                              ),
                            ),

                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
