import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/divider_widget.dart';
import 'package:fitness_client/features/gym/domains/models/gym.dart';
import 'package:fitness_client/features/rating/controllers/rating_controller.dart';
import 'package:fitness_client/features/rating/widgets/rating_widget.dart';
import 'package:fitness_client/helper/route_helper.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapAndRatingWidget extends StatefulWidget {
  const MapAndRatingWidget({super.key, required this.gym});
  final Gym gym;

  @override
  State<MapAndRatingWidget> createState() => _MapAndRatingWidgetState();
}

class _MapAndRatingWidgetState extends State<MapAndRatingWidget> {
  @override
  void initState() {
    super.initState();
    Get.find<RatingController>().getAll(gymId: widget.gym.id!, limit: 5);
  }

  @override
  Widget build(BuildContext context) {
    List<double> location = [widget.gym.location![0], widget.gym.location![1]];
    return GetBuilder<RatingController>(
      builder: (ratingController) {
        return Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DividerWidget(),
            Text('Vị trí', style: fontRegular.copyWith(fontSize: 18)),
            SizedBox(
              height: 250, // Chiều cao của bản đồ
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.gym.lat!, widget.gym.long!), // Tọa độ của vị trí
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('location'),
                    position: LatLng(location[1], location[0]), // Tọa độ của vị trí
                    infoWindow: InfoWindow(
                      title: 'Địa chỉ của bạn',
                      snippet: widget.gym.address, // Địa chỉ hiển thị
                    ),
                  ),
                },
              ),
            ),
            Row(
              spacing: 10,
              children: [
                Icon(Icons.star, color: AppColors.orange300),
                Text(widget.gym.rating.toString(), style: fontRegular.copyWith(fontSize: 18)),
                Icon(Icons.circle, size: 8, color: AppColors.orange300),
                Text('${widget.gym.ratingCount} đánh giá', style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            if (ratingController.ratings != null && ratingController.ratings!.isNotEmpty)
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ratingController.ratings!.length > 5 ? 5 : ratingController.ratings!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: RatingWidget(rating: ratingController.ratings![index]),
                    );
                  },
                ),
              ),
            SizedBox(height: 16),
            CustomButton(
              buttonText: 'Hiện tất cả đánh giá',
              onPressed: () {
                Get.find<RatingController>().reset();
                Get.toNamed(RouteHelper.getRatingRoute(widget.gym.id!));
              },
              color: Colors.white,
              isBorder: true,
              textColor: Colors.grey[900],
              isBold: false,
            ),
          ],
        );
      },
    );
  }
}
