import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/features/banner/widgets/banner_widget.dart';
import 'package:fitness_client/features/package/controllers/package_controller.dart';
import 'package:fitness_client/features/package/widgets/package_item_widget.dart';
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
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        Get.find<PackageController>();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  BannerWidget(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return PackageItemWidget(
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
                          Get.toNamed(RouteHelper.payment);
                        }
                      : null,
                  buttonText: 'Thanh toán',
                  color: AppColors.orange300,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
