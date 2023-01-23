import 'package:crypto_trends/features/coinList/data/models/coin_model.dart';
import 'package:crypto_trends/features/home/presenter/utils/functions.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../testData/coins_list_for_tests.dart';

void main() {
  group("getTop100Percentage", () {
    List<CoinModel> list1 = const [
      CoinModel(
        id: "id",
        symbol: "symbol",
        name: "name",
        priceChangePercentage24h: 12.3,
      ),
      CoinModel(
        id: "id",
        symbol: "symbol",
        name: "name",
        priceChangePercentage24h: 12.311,
      ),
    ];
    List<CoinModel> list2 = const [
      CoinModel(
          id: "id",
          symbol: "symbol",
          name: "name",
          priceChangePercentage24h: null),
      CoinModel(
          id: "id",
          symbol: "symbol",
          name: "name",
          priceChangePercentage24h: 12.322)
    ];

    test("return -29.02", () {
      final double percentage = getTop100Percentage(testCoinModels);

      expect(percentage, -9.67);
    });

    test("return 24.6", () {
      final double percentage = getTop100Percentage(list1);

      expect(percentage, 12.31);
    });

    test("return 12.3", () {
      final double percentage = getTop100Percentage(list2);

      expect(percentage, 6.16);
    });
  });
}
