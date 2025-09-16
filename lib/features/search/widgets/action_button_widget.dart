import 'package:fitness_client/features/gym/controllers/gym_controller.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.close),
              ),
              SizedBox(width: 10),
              Text('Bộ lọc', style: fontMedium.copyWith(fontSize: 20)),
            ],
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () {
            Get.find<GymController>().initFilter();
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('Reset', style: fontRegular.copyWith(fontSize: 15, color: Colors.grey[600])),
          ),
        ),
      ],
    );
  }
}
