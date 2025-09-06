import 'package:fitness_client/features/dashboard/widgets/head_message_widget.dart';
import 'package:fitness_client/features/dashboard/widgets/message_widget.dart';
import 'package:fitness_client/features/dashboard/widgets/notification_widget.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final List<Message> messages = [
      Message(sender: 'Fitness', time: '13:28', status: 'Đăng nhập thành công! Đăng nhập thành công!', isToday: true),
      Message(sender: 'Fitness', time: '13:28', status: 'Đăng nhập thành công!', isToday: true),
      Message(sender: 'Fitness', time: '13:28', status: 'Đăng nhập thành công!', isToday: true),
      Message(sender: 'Fitness, Fitness, Fitness, Fitness', time: '13:28 - T7', status: 'Đăng nhập thành công!', isToday: false),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Hộp thư", style: fontBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
        actions: [Icon(Icons.more_vert)],
      ),
      body: Column(
        children: [
          // TabBar
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Tin nhắn'),
              Tab(text: 'Thông báo'),
            ],
            labelColor: Color.fromRGBO(48, 48, 48, 1),
            unselectedLabelColor: Color.fromRGBO(128, 128, 128, 1),
            indicatorColor: AppColors.orange300,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
          ),

          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ListView(
                    children: [
                      HeaderMessageWidget(title: 'Hôm nay'),
                      ...messages.where((msg) => msg.isToday).map((message) => MessageWidget(message: message)),
                      HeaderMessageWidget(title: 'Hôm qua'),
                      ...messages.where((msg) => !msg.isToday).map((message) => MessageWidget(message: message)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
                  child: ListView(
                    children: [
                      NotificationWidget(content: "Thêm E-mail để nhận được những thông báo và khuyến mãi từ chúng tôi.", date: "15 tháng 11, 2021"),
                      NotificationWidget(content: "Đăng ký thành công!", date: "10 tháng 11, 2021"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String sender;
  final String time;
  final String status;
  final bool isToday;

  Message({required this.sender, required this.time, required this.status, required this.isToday});
}
