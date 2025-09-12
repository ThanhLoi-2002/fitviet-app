import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/divider_widget.dart';
import 'package:fitness_client/features/gym/domains/models/gym.dart';
import 'package:fitness_client/features/rating/domains/models/rating.dart';
import 'package:fitness_client/features/rating/widgets/rating_widget.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapAndRatingWidget extends StatefulWidget {
  const MapAndRatingWidget({super.key, required this.gym});
  final Gym gym;

  @override
  State<MapAndRatingWidget> createState() => _MapAndRatingWidgetState();
}

class _MapAndRatingWidgetState extends State<MapAndRatingWidget> {
  List<Rating> ratings = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                position: LatLng(widget.gym.lat!, widget.gym.long!), // Tọa độ của vị trí
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: [
              if(ratings.isNotEmpty)
              ListView.builder(
                itemCount: ratings.length,
                itemBuilder: (context, index) {
                  return RatingWidget(rating: ratings[index]);
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        CustomButton(buttonText: 'Hiện tất cả đánh giá', onPressed: () {}, color: Colors.white, isBorder: true, textColor: Colors.grey[900], isBold: false),
      ],
    );
  }
}
