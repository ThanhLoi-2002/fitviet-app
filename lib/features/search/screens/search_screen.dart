import 'package:fitness_client/common/widgets/search_field_widget.dart';
import 'package:fitness_client/features/search/widgets/filter_drawer_widget.dart';
import 'package:fitness_client/features/search/widgets/search_result_tile_widget.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm kiếm'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Builder(
              builder: (context) => InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                onTap: () => {Scaffold.of(context).openEndDrawer()},
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.filter_alt_outlined),
                ),
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
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text('Gần đây', style: fontRegular),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  SearchResultTileWidget(gymName: 'Gym Nguyen', distance: '13 km', location: 'Hochiminh city'),
                  SearchResultTileWidget(gymName: 'Gym BTT', distance: '13 km', location: 'Hochiminh city'),
                  SearchResultTileWidget(gymName: 'Gym ABC', distance: '13 km', location: 'Hochiminh city'),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: FilterDrawerWidget(),
    );
  }
}
