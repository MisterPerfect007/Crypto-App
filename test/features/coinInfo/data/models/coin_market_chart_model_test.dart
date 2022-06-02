import 'dart:convert';

import 'package:crypto_trends/features/coinInfo/data/models/coin_market_chart_model.dart';
import 'package:crypto_trends/features/coinInfo/domain/entities/coin_market_chart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../testData/json/json_reader.dart';
import '../../testData/coin_market_chart.dart';

void main(){
  // final model = CoinMarketChartModel(prices: testCoinMarketChart);
  final CoinMarketChartModel coinMarketChartModel =
    CoinMarketChartModel(prices: testCoinMarketChart);
  final Map<String, dynamic> jsonData = jsonDecode(readJson("coin_market_chart.json"));
  test("model should be a subclass of CoinMarketChart", (){
    expect(coinMarketChartModel, isA<CoinMarketChart>());
  });

  test("Should return a valid model from json", (){
    final result = CoinMarketChartModel.fromJson(jsonData);

    expect(result, coinMarketChartModel);
  });
  test("Should return a valid map", (){
    final result = coinMarketChartModel.toJson(testCoinMarketChart);

    expect(result, jsonData);
  });


}