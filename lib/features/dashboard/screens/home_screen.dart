import 'package:fitness_client/common/widgets/customer_image_widget.dart';
import 'package:fitness_client/features/dashboard/widgets/banner_widget.dart';
import 'package:fitness_client/helper/route_helper.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/styles.dart';
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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  onTap: () => { Get.toNamed(RouteHelper.search)},
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

          SizedBox(
            height: 400, // Hoặc một giá trị thích hợp khác
            child: TabBarView(
              controller: _tabController,
              children: [
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Số cột là 2
                    childAspectRatio: 0.7, // Tùy chỉnh tỷ lệ chiều rộng/chiều cao
                    crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
                    mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return GymCardWidget(title: 'Gym', price: '1.500.000đ ', rating: 5.0, imageUrl: AppConstants.imgDefault);
                  },
                  padding: EdgeInsets.all(8.0), // Padding xung quanh GridView
                ),
                Center(child: Text('Content for Tab 2')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GymCardWidget extends StatelessWidget {
  final String title;
  final String price;
  final double rating;
  final String imageUrl;

  const GymCardWidget({super.key, required this.title, required this.price, required this.rating, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageWidget(borderRadius: Dimensions.fontSizeOverSmall, imageUrl: imageUrl, fit: BoxFit.cover, height: 100, width: double.infinity),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Row(
                spacing: 4,
                children: [
                  Expanded(
                    child: Text(title, style: fontRegular, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  Icon(Icons.star, color: Colors.yellow, size: 16),
                  Text(rating.toString(), style: TextStyle(color: Colors.black)),
                ],
              ),
              Row(
                children: [
                  Text(price, style: fontMedium),
                  Text('/tháng', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
