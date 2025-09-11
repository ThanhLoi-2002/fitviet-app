import 'package:fitness_client/features/banner/controllers/banner_controller.dart';
import 'package:fitness_client/features/banner/widgets/banner_widget.dart';
import 'package:fitness_client/features/gym/controllers/gym_controller.dart';
import 'package:fitness_client/features/gym/widgets/gym_card_widget.dart';
import 'package:fitness_client/features/gym/widgets/gyms_shimmer.dart';
import 'package:fitness_client/helper/route_helper.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    Get.find<BannerController>().getAllBanner();
    Get.find<GymController>().getAll();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GymController>(
      builder: (gymController) {
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            context.width * 0.05, // padding trái
            context.height * 0.05, // padding trên
            context.width * 0.05, // padding phải
            0, // padding dưới
          ),
          child: Column(
            spacing: 10,
            children: [
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => {Get.toNamed(RouteHelper.search)},
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).disabledColor, width: 0.5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.orange),
                            SizedBox(width: 10),
                            Text('Tìm kiếm', style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Icon(Icons.qr_code, size: 30),
                ],
              ),

              //Banner
              BannerWidget(),

              // TabBar
              Row(
                children: [
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabs: [
                        Tab(text: 'Phổ biến'),
                        Tab(text: 'Gần đây'),
                      ],
                      labelColor: Color.fromRGBO(48, 48, 48, 1), // Màu chữ khi được chọn
                      unselectedLabelColor: Color.fromRGBO(128, 128, 128, 1), // Màu chữ khi không được chọn
                      indicatorColor: AppColors.orange300,
                      dividerColor: Colors.white,
                      tabAlignment: TabAlignment.start,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      // Xử lý sự kiện khi nhấn nút icon
                    },
                  ),
                ],
              ),

              gymController.gyms == null ? GymsShimmer() : SizedBox(),

              gymController.gyms != null && gymController.gyms!.isNotEmpty
                  ? Column(
                      spacing: 5,
                      children: List.generate((gymController.gyms!.length / 2).ceil(), (index) {
                        return Container(
                          padding: EdgeInsets.only(left: context.width * 0.03),
                          child: Row(
                            spacing: 5,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (int i = index * 2; i < (index + 1) * 2 && i < gymController.gyms!.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0), // Khoảng cách bên phải
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RouteHelper.getGymDetailRoute(gymController.gyms![i].id!));
                                    },
                                    child: GymCardWidget(gym: gymController.gyms![i]),
                                  ),
                                ),
                              for (int i = index * 2; i < (index + 1) * 2 && i < gymController.gyms!.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0), // Khoảng cách bên phải
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RouteHelper.getGymDetailRoute(gymController.gyms![i].id!));
                                    },
                                    child: GymCardWidget(gym: gymController.gyms![i]),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                    )
                  : SizedBox(),

              SizedBox(height: context.height * 0.03),
            ],
          ),
        );
      },
    );
  }
}
