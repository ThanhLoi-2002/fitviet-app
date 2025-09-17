import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/features/dashboard/widgets/card_drawer_widget.dart';
import 'package:fitness_client/helper/route_helper.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCardScreen extends StatefulWidget {
  const MyCardScreen({super.key});

  @override
  State<MyCardScreen> createState() => _MyCardScreenState();
}

class _MyCardScreenState extends State<MyCardScreen> with TickerProviderStateMixin {
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
    return Scaffold(
      appBar: AppBar(
        title: Row(spacing: 5, children: [Text('Thẻ của tôi'), Icon(Icons.arrow_drop_down)]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Builder(
              builder: (context) => InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                onTap: () => {Scaffold.of(context).openEndDrawer()},
                child: Padding(padding: const EdgeInsets.all(4.0), child: Icon(Icons.menu)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thông tin người dùng
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 8, offset: Offset(0, 4))],
                  gradient: LinearGradient(colors: [Color.fromRGBO(0, 155, 123, 1), Color.fromRGBO(0, 189, 092, 1)], begin: Alignment.bottomRight, end: Alignment.topLeft),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('California fitness', style: fontRegular.copyWith(fontSize: 20, color: Colors.white)),
                    Text(
                      'Gold Member',
                      style: fontRegular.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 40),

                    Text(
                      'NGUYEN VAN A',
                      style: fontRegular.copyWith(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'MVBYD6767',
                          style: fontRegular.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'EXP: 21/12/2022',
                          style: fontRegular.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                  ],
                ),
              ),

              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    onPressed: () {
                      Get.toNamed(RouteHelper.package);
                    },
                    radius: 8,
                    height: 48,
                    isBold: false,
                    isBorder: true,
                    buttonText: 'Mua gói tập',
                    color: Colors.white,
                    width: context.width * 0.4,
                    textColor: Colors.grey[900],
                  ),
                  CustomButton(
                    onPressed: () {},
                    radius: 8,
                    height: 48,
                    isBold: false,
                    isBorder: true,
                    buttonText: 'Bảo lưu',
                    color: Colors.white,
                    width: context.width * 0.4,
                    textColor: Colors.grey[900],
                  ),
                ],
              ),

              SizedBox(height: 16),
              TabBar(
                controller: _tabController,
                isScrollable: false,
                tabs: [
                  Tab(icon: Icon(Icons.grid_on_rounded)),
                  Tab(icon: Icon(Icons.contacts)),
                ],
                labelColor: Color.fromRGBO(48, 48, 48, 1), // Màu chữ khi được chọn
                unselectedLabelColor: Color.fromRGBO(128, 128, 128, 1), // Màu chữ khi không được chọn
                indicatorColor: Color.fromRGBO(48, 48, 48, 1),
                indicatorWeight: 0.5,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabAlignment: TabAlignment.fill,
              ),
              SizedBox(height: 16),
              // Tiêu đề lớp học
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Lớp hôm nay', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                  Icon(Icons.calendar_today, size: 24, color: AppColors.orange300),
                ],
              ),
              SizedBox(height: 16),
              // Danh sách lớp học
              // Expanded(
              //   child: ListView(
              //     children: [
              //       ClassCard(title: 'Yoga Basics', time: '16:00'),
              //       ClassCard(title: 'Gym New', time: '18:00'),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      endDrawer: CardDrawerWidget(),
    );
  }
}

class ClassCard extends StatelessWidget {
  final String title;
  final String time;

  const ClassCard({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(title: Text(title), subtitle: Text(time), trailing: Icon(Icons.arrow_forward_ios)),
    );
  }
}
