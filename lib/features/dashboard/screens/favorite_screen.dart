import 'package:fitness_client/common/widgets/customer_image_widget.dart';
import 'package:fitness_client/util/app_constants.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Gym> gyms = [
      Gym(
        name: 'Gym California Gym California Gym California',
        rating: 5.0,
        price: '1.500.000 đ/tháng',
        imageUrl: AppConstants.imgDefault, // Thay thế bằng URL hình ảnh thực tế
      ),
      Gym(
        name: 'Gym AAA',
        rating: 4.5,
        price: '7.000.000 đ/tháng',
        imageUrl: AppConstants.imgDefault, // Thay thế bằng URL hình ảnh thực tế
      ),
      Gym(
        name: 'Gym ABC',
        rating: 4.5,
        price: '10.000.000 đ/tháng',
        imageUrl: AppConstants.imgDefault, // Thay thế bằng URL hình ảnh thực tế
      ),
    ];
    return Padding(
      padding: const EdgeInsets.only(right: Dimensions.paddingSizeLarge),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Yêu thích", style: fontBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
          actions: [Icon(Icons.more_vert)],
        ),
        body: ListView.builder(
          itemCount: gyms.length,
          itemBuilder: (context, index) {
            final gym = gyms[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall),
              child: Row(
                children: [
                  CustomImageWidget(imageUrl: gym.imageUrl, width: 100, height: 100, borderRadius: Dimensions.radiusDefault),
                  SizedBox(width: Dimensions.paddingSizeLarge),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gym.name,
                          style: fontRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Text('${gym.rating}'),
                          ],
                        ),
                        Text(
                          gym.price,
                          style: TextStyle(color: Colors.grey[800]),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Gym {
  final String name;
  final double rating;
  final String price;
  final String imageUrl;

  Gym({required this.name, required this.rating, required this.price, required this.imageUrl});
}
