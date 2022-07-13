import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

String customFormater(double? price) {
  if (price == null) {
    return "??";
  } else {
    if (price == 0.0) {
      return "0.0";
    }
    if (price > 1) {
      return NumberFormat("#,###.##", "en_US").format(price);
    } else if (price > 0.001) {
      return NumberFormat("#,###.${"#" * 6}", "en_US").format(price);
    } else if (price > 0.000000000000001) {
      return NumberFormat("#,###.${"#" * 15}", "en_US").format(price);
    }
    print(Decimal.parse(price.toString()));
    return Decimal.parse(price.toString()).toString();
  }
}
