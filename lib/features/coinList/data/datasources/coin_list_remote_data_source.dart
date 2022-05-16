import 'dart:convert';

import 'package:crypto_trends/errors/exceptions.dart';
import 'package:crypto_trends/features/coinList/data/models/coin_model.dart';
import 'package:http/http.dart';

abstract class CoinListRemoteDataSource {
  /// Make a call to the coin list API enpoint: https://api.coingecko.com/api/v3/coins/markets?{ some given arguments}
  ///
  /// throw a [ServerException] when something went wrong
  Future<List<CoinModel>> getRemoteCoinList(
      {required String currency, int? page});
}

/*
  * API: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=true&price_change_percentage=7d
 */
class CoinListRemoteDataSourceImpl implements CoinListRemoteDataSource {
  final Client client;
  const CoinListRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<List<CoinModel>> getRemoteCoinList(
      {required String currency, int? page}) async {
    const Map<String, String> defaultHeader = { 'Content-type': 'application/json' };
    final url = Uri.https('api.coingecko.com', '/api/v3/coins/markets', {
      'vs_currency': currency,
      'order': 'market_cap_desc',
      'per_page': '10',
      'page': page != null ? page.toString() : '1',
      'sparkline': 'true',
      'price_change_percentage': '7d',
    });

    //! Call the remote API
    final response = await client.get(url, headers: defaultHeader);
    client.close();
    //* if (success)
    if (response.statusCode == 200) {
      final responseBody = response.body;
      final responseJson = jsonDecode(responseBody);
      List<CoinModel> listCoinModel = [];
      for (int i = 0; i < responseJson.length; i++) {
        listCoinModel.add(CoinModel.fromJson(responseJson[i]));
      }
    // => return list of coinModel from API's response
      return listCoinModel;
    }
    //* else
    else {
    // => throw a [ServerException]
      throw ServerException();
    }
  }
}
