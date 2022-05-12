import 'dart:convert';

import 'package:crypto_trends/features/coinList/data/models/coin_model.dart';
import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../testData/coins_list_for_tests.dart';
import '../../../../testData/json/json_reader.dart';

void main() {
  String jsonString = readJson("singleCoin.json");
  Map<String, dynamic> testSingleCoin = jsonDecode(jsonString);
  final CoinModel coinModel = CoinModel.fromJson(testSingleCoin);
  test("a coinModel should be a correct subclass of Coin", () {
    expect(coinModel, isA<Coin>());
  });
  test("Should return a valid json file from model", (){
    final result = coinModel.toJson();
    expect(result, testSingleCoin);
  });
  test("Should return a valid a model from json", () {
    const CoinModel validCoin = testSingleCoinModel;
    expect(coinModel, validCoin);
  });
}
