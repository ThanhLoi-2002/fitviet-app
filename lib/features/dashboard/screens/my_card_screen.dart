import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/text_row_widget.dart';
import 'package:fitness_client/features/dashboard/widgets/expire_date_widget.dart';
import 'package:fitness_client/features/package/controllers/package_controller.dart';
import 'package:fitness_client/features/package/domains/models/client_package.dart';
import 'package:fitness_client/features/package/widgets/package_item_widget.dart';
import 'package:fitness_client/features/profile/controllers/profile_controller.dart';
import 'package:fitness_client/helper/date_converter.dart';
import 'package:fitness_client/helper/route_helper.dart';
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
    Get.find<PackageController>().getClientPackage();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
      builder: (packageController) {
        ClientPackage? clientPackage = packageController.clientPackage;
        return GetBuilder<ProfileController>(
          builder: (profileController) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Gói tập của tôi'),
                // actions: [
                //   Padding(
                //     padding: const EdgeInsets.only(right: 16),
                //     child: Builder(
                //       builder: (context) => InkWell(
                //         borderRadius: BorderRadius.all(Radius.circular(20)),
                //         onTap: () => {Scaffold.of(context).openEndDrawer()},
                //         child: Padding(padding: const EdgeInsets.all(4.0), child: Icon(Icons.menu)),
                //       ),
                //     ),
                //   ),
                // ],
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
                        child: clientPackage != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(clientPackage.gym!.name!, style: fontRegular.copyWith(fontSize: 20, color: Colors.white)),
                                  TextRowWidget(
                                    textLeft: clientPackage.package!.name!,
                                    textRight: 'Lượt checkin: ${clientPackage.totalCheckins}/${clientPackage.package!.totalSessions!.toInt()}',
                                    size: 14,
                                    textLeftcolor: Colors.white,
                                    textRightColor: Colors.white,
                                  ),
                                  SizedBox(height: 40),
                                  TextRowWidget(
                                    textLeft: 'Tên: ${profileController.client!.name!}',
                                    textRight: 'Mã user: ${profileController.client!.userCode!}',
                                    size: 14,
                                    textLeftcolor: Colors.white,
                                    textRightColor: Colors.white,
                                  ),

                                  Text(
                                    'Ngày bắt đầu: ${DateConverter.formatOnlyDate(clientPackage.startDate!)}',
                                    style: fontRegular.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                                  ),
                                  ExpireDateWidget(clientPackage: clientPackage,),
                                  SizedBox(height: 6),
                                ],
                              )
                            : Center(
                                child: Text('Bạn chưa tham gia gói tập nào', style: fontRegular.copyWith(fontSize: 20, color: Colors.white)),
                              ),
                      ),

                      SizedBox(height: 16),
                      CustomButton(
                        onPressed: () {
                          Get.toNamed(RouteHelper.package);
                        },
                        radius: 8,
                        height: 48,
                        isBold: false,
                        isBorder: true,
                        buttonText: 'Xem các gói tập',
                        color: Colors.white,
                        width: context.width,
                        textColor: Colors.grey[900],
                      ),

                      SizedBox(height: 16),

                      if (clientPackage != null)
                        Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gói tập của bạn', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                            PackageItemWidget(
                              onTap: () {
                                Get.toNamed(RouteHelper.getPackageDetailRoute(clientPackage.package!.id!));
                              },
                              package: clientPackage.package!,
                            ),
                          ],
                        ),

                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              // endDrawer: CardDrawerWidget(),
            );
          },
        );
      },
    );
  }
}
