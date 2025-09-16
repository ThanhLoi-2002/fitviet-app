import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class GymsShimmer extends StatefulWidget {
  const GymsShimmer({super.key});

  @override
  State<GymsShimmer> createState() => _GymsShimmerState();
}

class _GymsShimmerState extends State<GymsShimmer> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(), // Disable scrolling
      shrinkWrap: true, // Allow the grid to take only the necessary space
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        childAspectRatio: 0.5, // Adjust the aspect ratio as needed
        crossAxisSpacing: 8.0, // Space between columns
        mainAxisSpacing: 10.0, // Space between rows
      ),
      itemCount: 4, // Total number of items
      itemBuilder: (context, index) {
        return Shimmer(
          duration: const Duration(seconds: 2),
          child: Container(
            height: 160,
            width: double.infinity, // Use full width of the grid cell
            decoration: BoxDecoration(color: Colors.grey[200]),
          ),
        );
      },
    );
  }
}
