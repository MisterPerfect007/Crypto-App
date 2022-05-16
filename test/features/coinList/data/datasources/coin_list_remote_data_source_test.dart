import 'package:crypto_trends/errors/exceptions.dart';
import 'package:crypto_trends/features/coinList/data/datasources/coin_list_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../testData/coins_list_for_tests.dart';
import '../../../../testData/json/json_reader.dart';
import 'coin_list_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  // http
  late MockClient client;
  late CoinListRemoteDataSourceImpl remote;
  late Map<String, String> defaultHeader;
  setUp(() {
    client = MockClient();
    remote = CoinListRemoteDataSourceImpl(client: client);
    defaultHeader = { 'Content-type': 'application/json' };
  });

  Uri buildUrl({required String currency, int? page}) {
    return Uri.https('api.coingecko.com', '/api/v3/coins/markets', {
    'vs_currency': currency,
    'order': 'market_cap_desc',
    'per_page': '10',
    'page': page != null ? page.toString() :  '1',
    'sparkline': 'true',
    'price_change_percentage': '7d',
  });
  }
  const tCurrency = "usd";
  const tPage = 2;
  final apiResponseBody = readJson('coin_list.json');

  test("Should make a call to coin list API with corrent parameters and the right Header", (() async {
    when(client.get(any, headers: anyNamed("headers"))).thenAnswer((_) async => http.Response("{}", 200));

    await remote.getRemoteCoinList(currency: tCurrency, page: tPage);

    verify(client.get(buildUrl(currency: tCurrency, page: tPage), headers: defaultHeader)).called(1);
  }));

  test("Should return a valid coin list when the call to Api successed", () async {
    when(client.get(any, headers: anyNamed("headers"))).thenAnswer((_) async => http.Response(apiResponseBody, 200));

    final result = await remote.getRemoteCoinList(currency: tCurrency, page: tPage);

    expect(result, testCoinModels);
  });

  test("Should throw a ServerException when the call to the API failed", () {
    when(client.get(any, headers: anyNamed("headers"))).thenAnswer((_) async => http.Response("Something wrong", 404));

    final call = remote.getRemoteCoinList;

    expect(() => call(currency: tCurrency, page: tPage), throwsA(isA<ServerException>()));
  });
}
