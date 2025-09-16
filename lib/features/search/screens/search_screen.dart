import 'package:fitness_client/common/widgets/search_field_widget.dart';
import 'package:fitness_client/features/convenience/controllers/convenience_controller.dart';
import 'package:fitness_client/features/convenience/domains/enums/convenience_enum.dart';
import 'package:fitness_client/features/gym/controllers/gym_controller.dart';
import 'package:fitness_client/features/gym/widgets/gym_card_widget.dart';
import 'package:fitness_client/features/gym/widgets/gyms_shimmer.dart';
import 'package:fitness_client/features/search/widgets/filter_drawer_widget.dart';
import 'package:fitness_client/features/subject/controllers/subject_controller.dart';
import 'package:fitness_client/helper/route_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounceTimer; // Biến để lưu timer debounce

  @override
  void initState() {
    super.initState();

    // Lắng nghe cuộn để tải thêm dữ liệu
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !Get.find<GymController>().isLoading && !Get.find<GymController>().isOutOfItem) {
        Get.find<GymController>().getAll();
      }
    });

    if (Get.find<ConvenienceController>().basicConveniences.isEmpty) {
      Get.find<ConvenienceController>().getAllConvenience(ConvenienceType.basic.value);
    }

    if (Get.find<ConvenienceController>().favoriteConveniences.isEmpty) {
      Get.find<ConvenienceController>().getAllConvenience(ConvenienceType.favorite.value);
    }

    if (Get.find<SubjectController>().subjects.isEmpty) {
      Get.find<SubjectController>().getAllsubject();
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel(); // Hủy timer khi dispose
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Hàm xử lý debounce khi nhập tìm kiếm
  void _onSearchChanged() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel(); // Hủy timer nếu đang chạy
    }
    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      Get.find<GymController>().resetFilter(isResetAll: false);
      Get.find<GymController>().updateFilter(search: _searchController.text.trim(), isOutOfItem: false);
      Get.find<GymController>().getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GymController>(
      builder: (gymController) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Get.find<GymController>().resetFilter();
                Get.find<GymController>().getAll();
                Get.back();
              },
              child: Icon(Icons.arrow_back),
            ),
            title: Text('Tìm kiếm'),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Builder(
                  builder: (context) => InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    onTap: () => {Scaffold.of(context).openEndDrawer()},
                    child: Padding(padding: const EdgeInsets.all(4.0), child: Icon(Icons.filter_alt_outlined)),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).disabledColor, width: 0.5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: SearchFieldWidget(
                    controller: _searchController,
                    radius: 50,
                    filledColor: Colors.grey[100],
                    hint: 'Tìm kiếm',
                    suffixIcon: _searchController.text.isNotEmpty ? Icons.clear : null,
                    prefixIcon: CupertinoIcons.search,
                    prefixIconColor: Color.fromRGBO(255, 100, 0, 1),
                    onChanged: (text) {
                      _onSearchChanged();
                    },
                    iconPressed: () {
                      _searchController.text = '';
                      _onSearchChanged();
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        gymController.gyms == null ? GymsShimmer() : SizedBox(),
                        gymController.gyms != null && gymController.gyms!.isEmpty ? Center(child: Text('Không có phòng gym nào')) : SizedBox(),
                        gymController.gyms != null && gymController.gyms!.isNotEmpty
                            ? GridView.builder(
                                physics: NeverScrollableScrollPhysics(), // Disable scrolling
                                shrinkWrap: true, // Allow the grid to take only the necessary space
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Number of columns
                                  childAspectRatio: 1, // Adjust the aspect ratio as needed
                                  crossAxisSpacing: 4.0, // Space between columns
                                  mainAxisSpacing: 5.0, // Space between rows
                                ),

                                itemCount: gymController.gyms!.length + (gymController.isLoading ? 1 : 0), // Thêm 1 để hiển thị loader
                                itemBuilder: (context, index) {
                                  if (index < gymController.gyms!.length) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(RouteHelper.getGymDetailRoute(gymController.gyms![index].id!));
                                      },
                                      child: GymCardWidget(gym: gymController.gyms![index]),
                                    );
                                  } else {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                },
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left: 16),
                //       child: Text('Gần đây', style: fontRegular),
                //     ),
                //   ],
                // ),
                // Expanded(
                //   child: ListView(
                //     children: [
                //       SearchResultTileWidget(gymName: 'Gym Nguyen', distance: '13 km', location: 'Hochiminh city'),
                //       SearchResultTileWidget(gymName: 'Gym BTT', distance: '13 km', location: 'Hochiminh city'),
                //       SearchResultTileWidget(gymName: 'Gym ABC', distance: '13 km', location: 'Hochiminh city'),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          endDrawer: FilterDrawerWidget(),
        );
      },
    );
  }
}
