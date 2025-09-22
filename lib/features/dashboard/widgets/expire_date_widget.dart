import 'package:fitness_client/features/package/domains/enums/packag_enum.dart';
import 'package:fitness_client/features/package/domains/models/client_package.dart';
import 'package:fitness_client/helper/date_converter.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class ExpireDateWidget extends StatelessWidget {
  const ExpireDateWidget({super.key, required this.clientPackage});
  final ClientPackage clientPackage;

  @override
  Widget build(BuildContext context) {
    if (clientPackage.package!.timePeriodType == PackageTimePeriodType.month || clientPackage.package!.timePeriodType == PackageTimePeriodType.year) {
      DateTime expireDate = clientPackage.startDate!.add(Duration(hours: 7));

      if (clientPackage.package!.timePeriodType == PackageTimePeriodType.month) {
        expireDate = DateTime(expireDate.year, expireDate.month + clientPackage.package!.duration!, expireDate.day).add(Duration(days: 0)); // Adjust day if needed
      } else if (clientPackage.package!.timePeriodType == PackageTimePeriodType.year) {
        expireDate = DateTime(expireDate.year + clientPackage.package!.duration!, expireDate.month, expireDate.day);
      }
      return Text(
        'Ngày kết thúc: ${DateConverter.formatOnlyDate(expireDate)}',
        style: fontRegular.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
      );
    }
    return SizedBox();
  }
}
