import 'package:crypto_trends/features/coinList/presenter/cubit/sorting_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/coin.dart';

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

///Sort the [coinList] according to the given [criteria]
///
//*Tested
List<Coin> sortCoinList(
    {required List<Coin> coinList, required Map<String, dynamic> criteria}) {
  List<Coin> newCoinList = List<Coin>.from(coinList);

  double smallestDouble = - 10000;

  switch (criteria["by"]) {
    case "Rank":
      newCoinList.sort((a, b) => (b.marketCapRank ?? 0).compareTo((a.marketCapRank ?? 0)));
      break;
    case "Price":
      newCoinList.sort((a, b) => (a.currentPrice ?? smallestDouble).compareTo((b.currentPrice ?? smallestDouble)));
      break;
    case "% 24h":
      newCoinList.sort((a, b) =>
          (a.priceChangePercentage24h ?? smallestDouble).compareTo((b.priceChangePercentage24h ?? smallestDouble)));
      break;
    case "% 7d":
      newCoinList.sort((a, b) => (a.priceChangePercentage7dInCurrency ?? smallestDouble)
          .compareTo(b.priceChangePercentage7dInCurrency ?? smallestDouble));
      break;
    case "Name":
      newCoinList
          .sort((a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()));
      break;
  }
  if (criteria["desc"]) {
    return newCoinList.reversed.toList();
  }
  return newCoinList;
}
