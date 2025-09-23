import 'package:fitness_client/features/banner/controllers/banner_controller.dart';
import 'package:fitness_client/features/banner/widgets/banner_widget.dart';
import 'package:fitness_client/features/gym/controllers/gym_controller.dart';
import 'package:fitness_client/features/gym/widgets/gym_card_widget.dart';
import 'package:fitness_client/features/gym/widgets/gyms_shimmer.dart';
import 'package:fitness_client/features/profile/controllers/profile_controller.dart';
import 'package:fitness_client/helper/auth_helper.dart';
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
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    // Lắng nghe sự thay đổi của tab
    _tabController.addListener(() {
      // Khi tab thay đổi
      int index = _tabController.index; // Lấy index của tab hiện tại
      Get.find<GymController>().tabChanged(index);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        Get.find<GymController>().getAll();
      }
    });

    Get.find<BannerController>().getAllBanner();
    Get.find<GymController>().getAll();

    if (AuthHelper.isLoggedIn()) {
      Get.find<ProfileController>().getMyInfo();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      builder: (bannerController) {
        List<String> banners = bannerController.banners.map((b) => b.logo!).toList();
        return GetBuilder<GymController>(
          builder: (gymController) {
            return SingleChildScrollView(
              controller: _scrollController,
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

                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.qrCodeScanner);
                        },
                        child: Icon(Icons.qr_code, size: 30),
                      ),
                    ],
                  ),

                  //Banner
                  BannerWidget(images: banners),

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
                      // IconButton(
                      //   icon: Icon(Icons.menu),
                      //   onPressed: () {
                      //     // Xử lý sự kiện khi nhấn nút icon
                      //   },
                      // ),
                    ],
                  ),

                  gymController.gyms == null ? GymsShimmer() : SizedBox(),
                  gymController.gyms != null && gymController.gyms!.isEmpty && gymController.isLoading ? Center(child: CircularProgressIndicator()) : SizedBox(),
                  gymController.gyms != null && gymController.gyms!.isEmpty && !gymController.isLoading ? Center(child: Text('Không có phòng gym nào')) : SizedBox(),

                  gymController.gyms != null && gymController.gyms!.isNotEmpty
                      ? GridView.builder(
                          physics: NeverScrollableScrollPhysics(), // Disable scrolling
                          shrinkWrap: true, // Allow the grid to take only the necessary space
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            childAspectRatio: 1, // Adjust the aspect ratio as needed
                            crossAxisSpacing: 4.0, // Space between columns
                            mainAxisSpacing: 5.0, // Space between rows
                          ),

                          itemCount: gymController.gyms!.length + (gymController.isLoading ? 1 : 0), // Thêm 1 để hiển thị loader
                          itemBuilder: (context, index) {
                            if (index < gymController.gyms!.length) {
                              return GestureDetector(
                                onTap: () {
                                  Get.find<GymController>().resetGymNull();
                                  Get.toNamed(RouteHelper.getGymDetailRoute(gymController.gyms![index].id!));
                                },
                                child: GymCardWidget(gym: gymController.gyms![index]),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        )
                      : SizedBox(),

                  SizedBox(height: context.height * 0.03),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
