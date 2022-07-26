import 'package:crypto_trends/features/home/data/trending_coin_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'trending_coin_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient client;
  late TrendingCoinRemoteDataSource dataSource;
  setUp(() {
    client = MockClient();
    dataSource = TrendingCoinRemoteDataSource(client: client);
  });
  Uri _baseUri = Uri.https("api.coingecko.com", "/api/v3/search/trending");
  Map<String, String> _defaultHeader = {'Content-type': 'application/json'};

  test("call to the API with correct Uri and headers", () {
    when(client.get(any, headers: anyNamed("headers"))).thenAnswer((_) async =>
        http.Response('{"coins": [{"item":{ "id": "bitcoin"}}]}', 200));

    dataSource.getTrendingCoinsIds();

    verify(client.get(_baseUri, headers: _defaultHeader)).called(1);
    verifyNoMoreInteractions(client);
  });

  test("throw an [TrendingCoinException] when get error from client get call",
      () {
    when(client.get(any, headers: anyNamed("headers"))).thenThrow(Exception());

    final call = dataSource.getTrendingCoinsIds;

    expect(() => call(), throwsA(isA<TrendingCoinException>()));
  });

  test("throw an [TrendingCoinException] when response.statusCode != 200", () {
    when(client.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response('', 400));

    final call = dataSource.getTrendingCoinsIds;

    expect(() => call(), throwsA(isA<TrendingCoinException>()));
  });
}
