import 'dart:convert';

import 'package:crypto_trends/features/search/data/models/search_coin_model.dart';
import 'package:http/http.dart';

import '../../../../errors/exceptions.dart';

abstract class SearchItemDataSource {
  /// throw a [ServerException] or [NoConnectionException] when something went wrong
  Future<List<SearchCoinModel>> getSearchItem(String query);
}

class SearchItemDataSourceImpl implements SearchItemDataSource {
  final Client client;
  const SearchItemDataSourceImpl({
    required this.client,
  });
  @override
  Future<List<SearchCoinModel>> getSearchItem(String query) async {
    const Map<String, String> defaultHeader = {
      'Content-type': 'application/json'
    };
    final url = _buildUrl(query);

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
          Map<String, dynamic>.from(jsonDecode(responseBody));
      final coins = List.from(responseJson["coins"]);

      return coins.map((coin) => SearchCoinModel.fromJson(coin)).toList();
      
    } else {
      throw ServerException();
    }
  }
}

Uri _buildUrl(String query) {
  return Uri.https('api.coingecko.com', '/api/v3/search', {
    'query': query,
  });
}
