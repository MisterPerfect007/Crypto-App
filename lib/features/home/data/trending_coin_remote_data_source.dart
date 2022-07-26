import 'dart:convert';

import 'package:http/http.dart';

Uri _baseUri = Uri.https("api.coingecko.com", "/api/v3/search/trending");
Map<String, String> _defaultHeader = {'Content-type': 'application/json'};

class TrendingCoinException implements Exception {}

class TrendingCoinRemoteDataSource {
  final Client client;
  const TrendingCoinRemoteDataSource({required this.client});

  Future<List<String>> getTrendingCoinsIds() async {
    final Response response;
    try {
      response = await client.get(_baseUri, headers: _defaultHeader);
    } catch (e) {
      throw TrendingCoinException();
    }
    if (response.statusCode == 200) {
      final reponseBody = List<Map<String, dynamic>>.from(jsonDecode(response.body)["coins"]);
      if (reponseBody.isNotEmpty) {
        List<String> ids =
            reponseBody.map((coin) => coin["item"]["id"].toString()).toList();
        return ids;
      } else {
        throw TrendingCoinException();
      }
    } else {
      throw TrendingCoinException();
    }
  }
}
