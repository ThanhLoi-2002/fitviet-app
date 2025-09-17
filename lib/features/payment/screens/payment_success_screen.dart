import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/icon_circle_button.dart';
import 'package:fitness_client/helper/route_helper.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.width * 0.05),
      child: SizedBox(
        height: context.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              child: Icon(Icons.check, color: Colors.white, size: 40),
            ),
            Text("Thanh toán thành công!", style: fontBold.copyWith(fontSize: 20, color: Theme.of(context).textTheme.bodyLarge!.color)),
            const SizedBox(height: 20),
            Text(
              '1.500.000 đ',
              textAlign: TextAlign.center,
              style: fontBold.copyWith(color: Colors.green, fontSize: 30),
            ),
            const SizedBox(height: 40),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.width *  0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15,
                    children: [
                      Text('Gói tập 1 tháng Gym California', style: fontRegular.copyWith(fontSize: 18, color: Colors.grey[700])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Mã giao dịch', style: fontRegular.copyWith(fontSize: 18, color: Colors.grey[700])),
                        
                          Text(
                            '2146578689',
                            style: fontRegular.copyWith(fontSize: 18, color: Colors.grey[900], fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Thời gian', style: fontRegular.copyWith(fontSize: 18, color: Colors.grey[700])),
                          Text(
                            '15:07, Thứ 2 12/12/2021',
                            style: fontRegular.copyWith(fontSize: 18, color: Colors.grey[900], fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
        
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                  IconCircleButton(icon: Icons.share_outlined, onTap: () {}),
                  IconCircleButton(icon: Icons.camera_alt, onTap: () {}),
                  IconCircleButton(icon: Icons.person, onTap: () {}),
            ],),
            const SizedBox(height: 40),
        
            CustomButton(
              buttonText: 'Quay về trang chủ',
              color: AppColors.orange300,
              onPressed: () {
                Get.toNamed(RouteHelper.initial);
              },
            ),
          ],
        ),
      ),
    );
  }
}
