import '../../../coinList/domain/entities/coin.dart';

//!Tested function
///Return the total of all the [priceChangePercentage24h] in the [coinList]
double getTop100Percentage(List<Coin> coinList){
  double percentage = 0;
  for (int i = 0; i < coinList.length; i++) {
    double? per = coinList[i].priceChangePercentage24h;
    if (per != null) {
      percentage += per;
    }
  }
  return double.parse(percentage.toStringAsFixed(2));
}