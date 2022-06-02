import 'dart:convert';

import 'package:crypto_trends/errors/exceptions.dart';
import 'package:crypto_trends/features/coinInfo/data/models/coin_market_chart_model.dart';
import 'package:http/http.dart';

abstract class CoinMarketChartRemoteDataSource {
  ///Get coin market chart remote data
  ///
  ///Return a [CoinMarketChartModel] when the call to the API succeded
  ///
  ///Throws a [ServerException] when something went wrong
  Future<CoinMarketChartModel> getRemote({
    required String id,
    required String currency,
    required String days,
    required bool dailyInterval,
  });
}

//https://api.coingecko.com/api/v3/coins/bitcoin/market_chart
//?vs_currency=usd&days=7&interval=daily

class CoinMarketChartRemoteDataSourceImpl
    implements CoinMarketChartRemoteDataSource {
  final Client client;

  CoinMarketChartRemoteDataSourceImpl({required this.client});
  @override
  Future<CoinMarketChartModel> getRemote({
    required String id,
    required String currency,
    required String days,
    required bool dailyInterval,
  }) async {
    final response = await client.get(
        buildUrl(
          id: id,
          currency: currency,
          days: days,
          dailyInterval: dailyInterval,
        ),
        headers: defaultHeader);
    if (response.statusCode == 200) {
      final responseBody = response.body;
      return CoinMarketChartModel.fromJson(jsonDecode(responseBody));
    } else {
      throw ServerException();
    }
  }

  Map<String, String> get defaultHeader => {'Content-type': 'application/json'};

  Uri buildUrl({
    required String id,
    required String currency,
    required String days,
    required bool dailyInterval,
  }) {
    return Uri.https('api.coingecko.com', '/api/v3/coins/$id/market_chart', {
      'vs_currency': currency,
      'days': days,
      'interval': dailyInterval ? 'daily' : ''
    });
  }
}