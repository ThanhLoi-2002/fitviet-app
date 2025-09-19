import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/features/banner/widgets/banner_widget.dart';
import 'package:fitness_client/features/gym/controllers/gym_controller.dart';
import 'package:fitness_client/features/package/controllers/package_controller.dart';
import 'package:fitness_client/features/package/widgets/package_item_widget.dart';
import 'package:fitness_client/features/profile/controllers/profile_controller.dart';
import 'package:fitness_client/helper/route_helper.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  final _scrollController = ScrollController();
  int? _selectedPackageIndex; // Theo dõi chỉ số gói được chọn

  @override
  void initState() {
    super.initState();
    String? gymId = Get.find<ProfileController>().client!.gym;

    if (gymId != null) {
      Get.find<PackageController>().reset();
      Get.find<GymController>().getGymById(gymId);
      Get.find<PackageController>().getAllPackage(gymId);
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        if (gymId != null) {
          Get.find<PackageController>().getAllPackage(gymId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GymController>(
      builder: (gymController) {
        List<String> gymBanners = gymController.gym == null ? [] : gymController.gym!.images!;
        return GetBuilder<PackageController>(
          builder: (packageController) {
            return Scaffold(
              appBar: AppBar(title: Text('Các gói tập', style: fontMedium.copyWith(fontSize: 20)), centerTitle: true),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      BannerWidget(images: gymBanners),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: packageController.packages.length,
                        itemBuilder: (context, index) {
                          return PackageItemWidget(
                            package: packageController.packages[index],
                            isSelected: _selectedPackageIndex == index,
                            onTap: () {
                              setState(() {
                                _selectedPackageIndex = _selectedPackageIndex == index ? null : index;
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: CustomButton(
                      onPressed: _selectedPackageIndex != null
                          ? () {
                              Get.toNamed(RouteHelper.getPackageDetailRoute(packageController.packages[_selectedPackageIndex!].id!));
                            }
                          : null,
                      buttonText: 'Chi tiết gói tập',
                      color: AppColors.orange300,
                    ),
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
