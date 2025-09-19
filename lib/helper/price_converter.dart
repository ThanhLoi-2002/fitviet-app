import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PriceConverter {
  static String formatCurrency(double price, {String locale = 'vi_VN', String symbol = ''}) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol, // Không hiển thị ký hiệu tiền tệ nếu để trống
      decimalDigits: 0, // Không hiển thị phần thập phân
    );
    return '${formatter.format(price)}VND';
  }
  
  static String convertPrice(double? price, {double? discount, String? discountType, bool forDM = false, String? formatedStringPrice}) {
    if (discount != null && discountType != null) {
      if (discountType == 'amount') {
        price = price! - discount;
      } else if (discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }

    if (price! > 100000) {
      return '${intl.NumberFormat.compact().format(price)}VND';
    }
    return '${formatedStringPrice ?? toFixed(price)}VND';
  }

  static double? convertWithDiscount(double? price, double? discount, String? discountType) {
    if (discountType == 'amount') {
      price = price! - discount!;
    } else if (discountType == 'percent') {
      price = price! - ((discount! / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double? discount, String type, int quantity) {
    double calculatedAmount = 0;
    if (type == 'amount' || type == 'fixed') {
      calculatedAmount = discount! * quantity;
    } else if (type == 'percent') {
      calculatedAmount = (discount! / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(String price, String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : 'VND'} OFF';
  }

  static double toFixed(double val) {
    num mod = power(10, 2);
    return (((val * mod).toPrecision(2)).floor().toDouble() / mod);
  }

  static int power(int x, int n) {
    int retval = 1;
    for (int i = 0; i < n; i++) {
      retval *= x;
    }
    return retval;
  }
}
