import 'package:fitness_client/common/widgets/avatar_header_widget.dart';
import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/custom_snackbar.dart';
import 'package:fitness_client/features/gym/controllers/gym_controller.dart';
import 'package:fitness_client/features/rating/controllers/rating_controller.dart';
import 'package:fitness_client/util/app_colors.dart';
import 'package:fitness_client/util/dimensions.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key, required this.gymController, required this.ratingController});
  final GymController gymController;
  final RatingController ratingController;

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 1; // Biến lưu trữ đánh giá
  final TextEditingController _descriptionController = TextEditingController();
  bool isEnabled = false;
  bool isRated = false;

  @override
  void initState() {
    super.initState();
    if (Get.find<RatingController>().rating != null) {
      setState(() {
        _descriptionController.text = Get.find<RatingController>().rating!.content!;
        _rating = Get.find<RatingController>().rating!.rating!.toInt();
        isEnabled = true;
        isRated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingController>(
      builder: (ratingController) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
          insetPadding: const EdgeInsets.all(30),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 5,
                    children: [
                      InkWell(onTap: () => Get.back(), child: Icon(Icons.close)),
                      AvatarHeaderWidget(
                        avatarSize: 48,
                        textSpacing: 0,
                        imageUrl: widget.gymController.gym!.merchant!.avatar ?? '',
                        textTop: Text(
                          widget.gymController.gym!.name!,
                          style: fontRegular.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textBottom: Text('Xếp hạng phòng tập này', style: fontRegular.copyWith(fontSize: 14, fontWeight: FontWeight.w300)),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(index < _rating ? Icons.star : Icons.star_border, color: Colors.amber),
                        onPressed: () {
                          setState(() {
                            _rating = index + 1; // Cập nhật đánh giá
                          });
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _descriptionController,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        isEnabled = false;
                      } else {
                        isEnabled = true;
                      }
                      setState(() {});
                    },
                    maxLength: 500,
                    decoration: InputDecoration(
                      hintText: 'Mô tả trải nghiệm của bạn',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey), // Màu viền khi không có focus
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey), // Màu viền khi có focus
                      ),
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    onPressed: isEnabled
                        ? () async {
                            if (isRated) {
                              bool isSuccess = await widget.ratingController.updateRating(rating: _rating, content: _descriptionController.text.trim());
                              if (isSuccess) {
                                widget.gymController.getGymById(widget.gymController.gym!.id!);
                                widget.ratingController.reset();
                                widget.ratingController.getAll(gymId: widget.gymController.gym!.id!, limit: 10);
                                showCustomSnackBar('Cập nhật thành công', isError: false);
                                Get.back();
                              }
                            } else {
                              bool isSuccess = await widget.ratingController.writeRating(rating: _rating, content: _descriptionController.text.trim(), gymId: widget.gymController.gym!.id!);
                              if (isSuccess) {
                                widget.gymController.getGymById(widget.gymController.gym!.id!);
                                widget.ratingController.reset();
                                widget.ratingController.getAll(gymId: widget.gymController.gym!.id!, limit: 10);
                                showCustomSnackBar('Đánh giá thành công', isError: false);
                                Get.back();
                              }
                            }
                          }
                        : null,
                    isLoading: widget.ratingController.isLoading,
                    buttonText: isRated ? 'Cập nhật bài viết' : 'Đăng bài viết',
                    color: AppColors.orange300,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
