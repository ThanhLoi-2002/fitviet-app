import 'package:fitness_client/common/widgets/customer_image_widget.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      child: CustomImageWidget(
        width: double.infinity,
        height: 137,
        imageUrl: 'https://tse3.mm.bing.net/th/id/OIP.09mzllR7Fq9-7LREOJNbggHaE7?pid=Api&P=0&h=220',
        fit: BoxFit.fill,
      ),
    );
  }
}
