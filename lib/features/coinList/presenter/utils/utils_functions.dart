import 'package:shared_preferences/shared_preferences.dart';

//* Tested
double? calculate7DPercentage(List<double>? lastWeekData) {
  if (lastWeekData != null && lastWeekData.isNotEmpty) {
    return double.parse((100 *
            (lastWeekData[lastWeekData.length - 1] - lastWeekData[0]) /
            lastWeekData[0])
        .toStringAsFixed(5));
  } else {
    return null;
  }
}

///Should return true if price is up
///
///Should return false if price is down
///
///Should return null if none the case above
//*Tested
bool? isNewPriceUp({
  required String id,
  double? newPrice,
  required SharedPreferences prefs,
}) {
  if (prefs.getDouble(id) != null) {
    double oldPrice = prefs.getDouble(id)!;
    if (newPrice != null) {
      prefs.setDouble(id, newPrice);
      if (newPrice > oldPrice) {
        return true;
      } else if (newPrice < oldPrice) {
        return false;
      }
    }
  } else {
    prefs.setDouble(id, newPrice!);
  }
  return null;
}
