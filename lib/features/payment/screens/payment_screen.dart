import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/custom_image_widget.dart';
import 'package:fitness_client/common/widgets/divider_widget.dart';
import 'package:fitness_client/common/widgets/rating_bar.dart';
import 'package:fitness_client/features/package/widgets/package_item_widget.dart';
import 'package:fitness_client/helper/price_converter.dart';
import 'package:fitness_client/helper/route_helper.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thanh toán', style: fontMedium.copyWith(fontSize: 20)), centerTitle: true),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomImageWidget(imageUrl: AppConstants.imgDefault, width: 90, height: 100),
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gym California', style: fontRegular.copyWith(color: Colors.grey[900], fontSize: 18)),
                            Row(children: [RatingBar(rating: 4.2), Text('4.2')]),
                            Row(
                              children: [
                                Text(PriceConverter.formatCurrency(1500000), style: fontMedium),
                                Text('/tháng', style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              DividerWidget(),
              SizedBox(height: 10),
              PackageItemWidget(isSelected: false, onTap: () {}),
              SizedBox(height: 10),
              DividerWidget(),
              SizedBox(height: 10),

              Text('Ngày bắt đầu', style: fontRegular.copyWith(fontSize: 16, color: Colors.grey[700])),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ngày 07/12/2021 - 07/01/2022', style: fontMedium.copyWith(fontSize: 16)),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Thay đổi', style: fontRegular.copyWith(fontSize: 16)),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              DividerWidget(),
              SizedBox(height: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Chi tiết giá', style: fontRegular.copyWith(fontSize: 20, fontWeight: FontWeight.w400)),

                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Gói tập gym 1 tháng', style: fontRegular.copyWith(fontSize: 16, color: Colors.grey[700])),
                      Text('1.500.000 đ', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phụ phí', style: fontRegular.copyWith(fontSize: 16, color: Colors.grey[700])),
                      Text('1.000.000 đ', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Giảm giá', style: fontRegular.copyWith(fontSize: 16, color: Colors.grey[700])),
                      Text('-1.000.000 đ', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('1.500.000 đ', style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 10),
              DividerWidget(),
              SizedBox(height: 10),

              Text('Thanh toán', style: fontRegular.copyWith(fontSize: 20, fontWeight: FontWeight.w400)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Phương thức thanh toán', style: fontRegular.copyWith(fontSize: 16, color: Colors.grey[700])),
                  CustomButton(buttonText: 'Chọn', onPressed: () {}, color: AppColors.orange300, width: 70, isBold: false, height: 30),
                ],
              ),
              SizedBox(height: 10),
              DividerWidget(),
              SizedBox(height: 10),

              Text('Thanh toán', style: fontRegular.copyWith(fontSize: 20, fontWeight: FontWeight.w400)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Phương thức thanh toán', style: fontRegular.copyWith(fontSize: 16, color: Colors.grey[700])),
                  CustomButton(buttonText: 'Chọn', onPressed: () {}, color: AppColors.orange300, width: 70, isBold: false, height: 30),
                ],
              ),
              SizedBox(height: 10),
              DividerWidget(),
              SizedBox(height: 10),

              Text('Giảm giá', style: fontRegular.copyWith(fontSize: 20, fontWeight: FontWeight.w400)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nhập mã giảm giá', style: fontRegular.copyWith(fontSize: 16, color: Colors.grey[700])),
                  CustomButton(buttonText: 'Chọn', onPressed: () {}, color: AppColors.orange300, width: 70, isBold: false, height: 30),
                ],
              ),

              SizedBox(height: 10),
              DividerWidget(),
              SizedBox(height: 10),

              Text('Số điện thoại', style: fontRegular.copyWith(fontSize: 20, fontWeight: FontWeight.w400)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('Bắt buộc xác minh danh tính trước khi tập luyện', style: fontRegular.copyWith(fontSize: 16, color: Colors.grey[700]), softWrap: true, maxLines: 2),
                  ),
                  CustomButton(buttonText: 'Chọn', onPressed: () {}, color: AppColors.orange300, width: 70, isBold: false, height: 30),
                ],
              ),

              SizedBox(height: 10),
              DividerWidget(),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: fontRegular.copyWith(fontSize: 14, color: Colors.grey[700]),
                        children: [
                          TextSpan(text: 'Bằng việc tiến hành giao dịch, tôi đồng ý với các ', style: TextStyle()),

                          TextSpan(
                            text: 'điều khoản chung',
                            style: TextStyle(fontSize: 14, decoration: TextDecoration.underline, color: AppColors.orange300),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
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
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Tổng cộng', style: fontRegular.copyWith(fontSize: 16, color: Colors.grey[700])),
                      Text(
                        '1.500.000 đ',
                        style: fontRegular.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.orange300),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  onPressed: () {
                    Get.toNamed(RouteHelper.paymentSuccess);
                  },
                  buttonText: 'Thanh toán',
                  color: AppColors.orange300,
                  width: context.width * 0.4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
