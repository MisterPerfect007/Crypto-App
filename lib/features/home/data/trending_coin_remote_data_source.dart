import 'dart:convert';

import 'package:http/http.dart';

Uri _baseUri = Uri.https("api.coingecko.com", "/api/v3/search/trending");
Map<String, String> _defaultHeader = {'Content-type': 'application/json'};

class TrendingCoinRemoteDataSource {
  final Client client;
  const TrendingCoinRemoteDataSource({required this.client});

  Future<List<String>> getTrendingCoinsIds() async {
    final Response response;
    try {
      response = await client
          .get(_baseUri, headers: _defaultHeader);
    } catch (e) {
      throw Exception();
    }
    if (response.statusCode == 200) {
      final List reponseBody = jsonDecode(response.body)["coins"];
      if (reponseBody.isNotEmpty) {
        List<String> ids =
            reponseBody.map((coin) => coin["item"]["id"].toString()).toList();
        return ids;
      } else {
        throw Exception();
      }
    } else {
      throw Exception();
    }
  }
}
