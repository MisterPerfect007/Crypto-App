import 'package:crypto_trends/features/coinList/data/models/coin_model.dart';
import 'package:crypto_trends/features/coinList/presenter/utils/utils_functions.dart';
import 'package:crypto_trends/features/coinList/presenter/widgets/sorting%20criteria/criteria_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../testData/coins_list_for_tests.dart';

@GenerateMocks([SharedPreferences])
// @GenerateMocks([SortingCubit])
void main() {
  group("calculate7DPercentage", () {
    test("Should caculate and return the right pourcentage", () {
      final result1 = calculate7DPercentage([1, 2]);
      final result2 = calculate7DPercentage([12, 2, 11.9122]);
      final result3 = calculate7DPercentage([100, 00.1, 101.12]);
      final result4 = calculate7DPercentage([10, 00.1, 9]);

      expect(result1, 100);
      expect(result2, -0.73167);
      expect(result3, 1.12);
      expect(result4, -10);
    });

    test("Should return null if argument is not a list or an empty", () {
      final result1 = calculate7DPercentage([]);
      final result2 = calculate7DPercentage(null);

      expect(result1, null);
      expect(result2, null);
    });
  });

  group("sortCoinList", () {
    group("Rank", () {
      const testCoinWithNullRank = [
            CoinModel(id: "id_1", symbol: "symbol_1", name: "name_1"),
            CoinModel(id: "id_2", symbol: "symbol_2", name: "name_2"),
            CoinModel(id: "id_3", symbol: "symbol_3", name: "name_3"),
          ];
      test("Should sort coin list by Rank desc", () {
        final result =
            sortCoinList(coinList: testCoinModels, criteria: rankDesc);

        expect(result, [bitcoinModel, ethereumModel, tetherModel]);
      });
      test("Should sort coin list by Rank Asc", () {
        final result =
            sortCoinList(coinList: testCoinModels, criteria: rankAsc);

        expect(result, [tetherModel, ethereumModel, bitcoinModel]);
      });
      test("Should sort coin list by Rank with null values", () {
        final result = sortCoinList(
          coinList: testCoinWithNullRank,
          criteria: rankAsc,
        );

        expect(result, testCoinWithNullRank);
      });
    });

    group("Price", () {
      test("Should sort coin list by price desc", () {
        final result =
            sortCoinList(coinList: testCoinModels, criteria: priceDesc);

        expect(result, [bitcoinModel, ethereumModel, tetherModel]);
      });
      test("Should sort coin list by price asc", () {
        final result =
            sortCoinList(coinList: testCoinModels, criteria: priceAsc);

        expect(result, [tetherModel, ethereumModel, bitcoinModel]);
      });
    });

    group("% 24h", () {
      test("Should sort coin list by percentage24HDesc desc", () {
        final result =
            sortCoinList(coinList: testCoinModels, criteria: percentage24HDesc);

        expect(result, [tetherModel, bitcoinModel, ethereumModel]);
      });
      test("Should sort coin list by percentage24HDesc asc", () {
        final result =
            sortCoinList(coinList: testCoinModels, criteria: percentage24HAsc);

        expect(result, [ethereumModel, bitcoinModel, tetherModel]);
      });
    });

    group("% 7d", () {
      test("Should sort coin list by percentage7DDesc desc", () {
        final result =
            sortCoinList(coinList: testCoinModels, criteria: percentage7DDesc);

        expect(result, [bitcoinModel, ethereumModel, tetherModel]);
      });
      test("Should sort coin list by percentage7DDesc asc", () {
        final result =
            sortCoinList(coinList: testCoinModels, criteria: percentage7DAsc);

        expect(result, [tetherModel, ethereumModel, bitcoinModel]);
      });
    });

    group("Name", () {
      test("Should sort coin list by percentage7DDesc desc", () {
        final result =
            sortCoinList(coinList: testCoinModels, criteria: nameDesc);

        expect(result, [tetherModel, ethereumModel, bitcoinModel]);
      });
      test("Should sort coin list by percentage7DDesc asc", () {
        final result =
            sortCoinList(coinList: testCoinModels, criteria: nameAsc);

        expect(result, [bitcoinModel, ethereumModel, tetherModel]);
      });
    });
  });
}
