import 'package:fitness_client/helper/price_converter.dart';
import 'package:fitness_client/util/styles.dart';
import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key, required this.originalPrice, required this.promotionalPrice});
  final double originalPrice;
  final double promotionalPrice;

  @override
  Widget build(BuildContext context) {
    return promotionalPrice == 0
        ? Text('Giá: ${PriceConverter.formatCurrency(originalPrice)}', style: fontMedium.copyWith(fontSize: 16, fontWeight: FontWeight.w400))
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Giá gốc: ${PriceConverter.formatCurrency(originalPrice)}',
                style: fontMedium.copyWith(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.lineThrough, // Gạch ngang văn bản
                  decorationColor: Colors.red,
                ),
              ),
              Text('Giảm còn: ${PriceConverter.formatCurrency(promotionalPrice)}', style: fontMedium.copyWith(fontSize: 16, fontWeight: FontWeight.w400)),
            ],
          );
  }
}
