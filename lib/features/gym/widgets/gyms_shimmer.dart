import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class GymsShimmer extends StatefulWidget {
  const GymsShimmer({super.key});

  @override
  State<GymsShimmer> createState() => _GymsShimmerState();
}

class _GymsShimmerState extends State<GymsShimmer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: List.generate((4 / 2).ceil(), (index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = index * 2; i < (index + 1) * 2 && i < 4; i++)
              Padding(
                padding: const EdgeInsets.only(right: 8.0), // Khoảng cách bên phải
                child: Shimmer(
                  duration: const Duration(seconds: 2),
                  child: Container(
                    height: 160,
                    width: context.width * 0.4,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
