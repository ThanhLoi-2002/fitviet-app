import 'package:fitness_client/common/widgets/custom_button.dart';
import 'package:fitness_client/common/widgets/rating_bar.dart';
import 'package:fitness_client/features/gym/controllers/gym_controller.dart';
import 'package:fitness_client/features/rating/controllers/rating_controller.dart';
import 'package:fitness_client/features/rating/widgets/rating_dialog.dart';
import 'package:fitness_client/features/rating/widgets/rating_progress_widget.dart';
import 'package:fitness_client/features/rating/widgets/rating_widget.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key, required this.gymId});
  final String gymId;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Gọi phương thức để lấy tất cả đánh giá
      Get.find<RatingController>().reset();
      Get.find<RatingController>().getAll(gymId: widget.gymId, limit: 10);
      Get.find<RatingController>().getRatingDetailByGymId(gymId: widget.gymId);

      // Lắng nghe sự kiện cuộn để tải thêm đánh giá
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
          Get.find<RatingController>().getAll(gymId: widget.gymId, limit: 10);
        }
      });
    });
  }

  void ratingDialog(GymController gymController, RatingController ratingController) {
    Get.dialog(RatingDialog(gymController: gymController, ratingController: ratingController), useSafeArea: false);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingController>(
      builder: (ratingController) {
        return GetBuilder<GymController>(
          builder: (gymController) {
            bool isRated = ratingController.rating != null;
            List<Widget> ratingWidgets = [];
            int ratingCount = gymController.gym!.ratingCount!;
            for (int i = 0; i < ratingController.ratingList!.length; i++) {
              double value = ratingCount > 0 ? ratingController.ratingList![i] / ratingCount : 0;
              String text = (i + 1).toString();

              ratingWidgets.add(RatingProgressWidget(value: value, text: text));
            }
            return Scaffold(
              appBar: AppBar(
                title: Text('Đánh giá', style: fontMedium.copyWith(fontSize: 24)),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: InkWell(onTap: () {}, borderRadius: BorderRadius.circular(20), child: Icon(Icons.help)),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Center(
                              child: Column(
                                children: [
                                  Text('${gymController.gym!.rating}/5', style: fontBold.copyWith(fontSize: 28)),
                                  RatingBar(rating: gymController.gym!.rating),
                                  Text(
                                    '${gymController.gym!.ratingCount} đánh giá',
                                    style: TextStyle(color: Colors.grey),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(flex: 8, child: Column(children: ratingWidgets)),
                        ],
                      ),
                      SizedBox(height: 16),
                      CustomButton(
                        color: Colors.white,
                        isBorder: true,
                        textColor: Colors.grey[900],
                        isBold: false,
                        onPressed: () {
                          ratingDialog(gymController, ratingController);
                        },
                        buttonText: isRated ? 'Cập nhật đánh giá' : 'Viết đánh giá',
                      ),
                      SizedBox(height: 16),
                      // Thay thế Expanded bằng Container để đặt chiều cao cụ thể
                      SizedBox(
                        height: 300, // Chiều cao cụ thể cho danh sách đánh giá
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: ratingController.ratings!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: RatingWidget(rating: ratingController.ratings![index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
