import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class SearchResultTileWidget extends StatelessWidget {
  final String gymName;
  final String distance;
  final String location;

  const SearchResultTileWidget({super.key, required this.gymName, required this.distance, required this.location});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.access_time),
      title: Text(gymName),
      subtitle: Text(location),
      trailing: Text(distance, style: fontRegular),
    );
  }
}
