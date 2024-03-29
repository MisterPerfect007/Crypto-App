import 'dart:convert';

import 'package:crypto_trends/errors/exceptions.dart';
import 'package:crypto_trends/features/coinList/data/models/coin_model.dart';
import 'package:http/http.dart';

import '../../../settings/utils/get_currency.dart';

abstract class CoinListRemoteDataSource {
  /// Make a call to the coin list API enpoint: https://api.coingecko.com/api/v3/coins/markets?{ some given arguments}
  ///
  /// throw a [ServerException] or [NoConnectionException] when something went wrong
  Future<List<CoinModel>> getRemoteCoinList(
      {int? page, List<String>? ids, int? perPage});
}

/*
  * API: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=true&price_change_percentage=7d
 */
class CoinListRemoteDataSourceImpl implements CoinListRemoteDataSource {
  final Client client;
  final CurrencyStorage currencyStorage;
  
  const CoinListRemoteDataSourceImpl({
    required this.client,
    required this.currencyStorage
  });
  @override
  Future<List<CoinModel>> getRemoteCoinList({
    int? page,
    List<String>? ids,
    int? perPage,
  }) async {
    const Map<String, String> defaultHeader = {
      'Content-type': 'application/json'
    };
    final url = buildUrl(page: page, ids: ids, currency: currencyStorage.getCurrentCurrency().shortName);

    final Response response;
    try {
      response = await client
          .get(url, headers: defaultHeader)
          .timeout(const Duration(seconds: 60));
    } catch (e) {
      throw NoConnectionException();
    }
    if (response.statusCode == 200) {
      final responseBody = response.body;
      final responseJson =
          List<Map<String, dynamic>>.from(jsonDecode(responseBody));
      return responseJson
          .map((coinjson) => CoinModel.fromJson(coinjson))
          .toList();
    } else {
      throw ServerException();
    }
  }
}

Uri buildUrl(
    {required String currency, int? page, List<String>? ids, int? perPage}) {
  return Uri.https('api.coingecko.com', '/api/v3/coins/markets', {
    'vs_currency': currency,
    'order': 'market_cap_desc',
    'per_page': perPage?.toString() ?? '100',
    'page': page?.toString(),
    'ids': ids?.join(','),
    'sparkline': 'true',
    'price_change_percentage': '7d',
  });
}
