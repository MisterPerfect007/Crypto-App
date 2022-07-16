import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

String customFormater(double? price) {
  if (price == null) {
    return "??";
  } else {
    if (price == 0.0) {
      return "0.0";
    }
    if (price > 10) {
      return NumberFormat("#,###.##", "en_US").format(price);
    } else if (price > 0.001) {
      return NumberFormat("#,###.${"#" * 6}", "en_US").format(price);
    } else if (price > 0.000000000000001) {
      return NumberFormat("#,###.${"#" * 15}", "en_US").format(price);
    }
    // print(Decimal.parse(price.toString()));
    return Decimal.parse(price.toString()).toString();
  }
}

String timeSlotToDaysNumber(String timeSlot) {
  switch (timeSlot) {
    case "1D":
      return "1";
    case "7D":
      return "7";
    case "1M":
      return "30";
    case "3M":
      return "90";
    case "1Y":
      return "365";
    case "ALL":
      return "max";
    default:
      return "1";
  }
}
