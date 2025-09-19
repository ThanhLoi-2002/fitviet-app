import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({super.key, required this.imageUrl, this.width, this.height, this.borderRadius, this.fit});
  final String imageUrl;
  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => Shimmer(
          duration: const Duration(seconds: 2),
          child: Container(
            height: height ?? 100,
            width: width ?? context.width,
            decoration: BoxDecoration(color: Colors.grey[200]),
          ),
        ),

        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: fit ?? BoxFit.cover,
        height: height ?? 100,
        width: width ?? context.width,
      ),
    );
  }
}
