import 'package:fitness_client/common/widgets/avatar_header_widget.dart';
import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/custom_list_tile_widget.dart';
import 'package:fitness_client/common/widgets/divider_widget.dart';
import 'package:fitness_client/features/gym/widgets/amenities.dart';
import 'package:fitness_client/features/gym/widgets/customer_service_department.dart';
import 'package:fitness_client/features/gym/widgets/gym_app_bar_widget.dart';
import 'package:fitness_client/features/gym/widgets/overlapping_card_widget.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GymDetailScreen extends StatelessWidget {
  const GymDetailScreen({super.key, required this.gymId});
  final String gymId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          GymAppBarWidget(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OverlappingCardWidget(),
                  DividerWidget(),
                  AmenitiesWidget(),
                  DividerWidget(),
                  SizedBox(height: 20),
                  CustomerServiceDepartmentWidget(),
                  DividerWidget(),
                  MapAndRatingWiget(),
                  DividerWidget(),
                  CustomListTileWidget(title: 'Điều khoản và dịch vụ', onTap: () => {}),
                  CustomListTileWidget(title: 'Nội quy', onTap: () => {}),
                  CustomListTileWidget(title: 'Y tế và an toàn', onTap: () => {}),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: Row(
              spacing: 20,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.orange300),
                    child: Icon(Icons.message_outlined, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: CustomButton(onPressed: () {}, buttonText: 'Đặt ngay', color: AppColors.orange300),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MapAndRatingWiget extends StatelessWidget {
  const MapAndRatingWiget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Vị trí', style: fontRegular.copyWith(fontSize: 18)),
        SizedBox(
          height: 250, // Chiều cao của bản đồ
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(10.762622, 106.660172), // Tọa độ của vị trí
              zoom: 14,
            ),
            markers: {
              Marker(
                markerId: MarkerId('location'),
                position: LatLng(10.762622, 106.660172), // Tọa độ của vị trí
                infoWindow: InfoWindow(
                  title: 'Địa chỉ của bạn',
                  snippet: 'Địa chỉ: 123 Đường ABC, Quận 1, HCM', // Địa chỉ hiển thị
                ),
              ),
            },
          ),
        ),
        Row(
          spacing: 10,
          children: [
            Icon(Icons.star, color: AppColors.orange300),
            Text('5,0', style: fontRegular.copyWith(fontSize: 18)),
            Icon(Icons.circle, size: 8, color: AppColors.orange300),
            Text('28 đánh giá', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: [
              RatingItem(name: 'Alex Ng', date: '2 ngày trước', review: 'Dịch vụ tốt, không gian đẹp cực kì, mấy mốc ơn.'),
              RatingItem(name: 'Jane Doe', date: '3 ngày trước', review: 'Không gian thoải mái, nhân viên thân thiện.'),
              RatingItem(name: 'Jane Doe', date: '3 ngày trước', review: 'Không gian thoải mái, nhân viên thân thiện.'),
            ],
          ),
        ),
        SizedBox(height: 16),
        CustomButton(buttonText: 'Hiện tất cả đánh giá', onPressed: () {}, color: Colors.white, isBorder: true, textColor: Colors.grey[900], isBold: false),
      ],
    );
  }
}

class RatingItem extends StatelessWidget {
  final String name;
  final String date;
  final String review;

  const RatingItem({super.key, required this.name, required this.date, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 160,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration( borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey[400]!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarHeaderWidget(
            imageUrl: '',
            textTop: Text(name, style: fontMedium, maxLines: 1, overflow: TextOverflow.ellipsis,),
            textBottom: Text(date, style: fontRegular.copyWith(color: Colors.grey)),
            avatarSize: 50,
            textSpacing: 4
          ),
          SizedBox(height: 8),
          Text('$review $review', maxLines: 3, overflow: TextOverflow.ellipsis,),
        ],
      ),
    );
  }
}
