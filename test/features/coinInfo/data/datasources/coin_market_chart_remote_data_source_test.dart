import 'package:crypto_trends/errors/exceptions.dart';
import 'package:crypto_trends/features/coinInfo/data/datasources/coin_market_chart_remote_data_source.dart';
import 'package:crypto_trends/features/coinInfo/data/models/coin_market_chart_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../testData/json/json_reader.dart';
import '../../testData/coin_market_chart.dart';
import 'coin_market_chart_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient client;
  late CoinMarketChartRemoteDataSourceImpl remote;
  final Map<String, String> defaultHeader = {
    'Content-type': 'application/json'
  };
  setUp(() {
    client = MockClient();
    remote = CoinMarketChartRemoteDataSourceImpl(client: client);
  });
  const tId = "bitcoin";
  const tCurrency = "usd";
  const tDays = "7";
  const tDailyInterval = true;

  final String apiResponse = readJson("coin_market_chart.json");
  final CoinMarketChartModel coinMarketChartModel =
      CoinMarketChartModel(prices: testCoinMarketChart);

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

  test("Should make the API call with given parameters and headers", () async {
    when(
      client.get(any, headers: anyNamed("headers")),
    ).thenAnswer((_) async => http.Response(apiResponse, 200));

    await remote.getRemote(
      id: tId,
      currency: tCurrency,
      days: tDays,
      dailyInterval: tDailyInterval,
    );

    verify(
      client.get(
          buildUrl(
            id: tId,
            currency: tCurrency,
            days: tDays,
            dailyInterval: tDailyInterval,
          ),
          headers: defaultHeader),
    ).called(1);
    verifyNoMoreInteractions(client);
  });
  test("Should return a correct model when the API call succeded", () async {
    when(
      client.get(any, headers: anyNamed("headers")),
    ).thenAnswer((_) async => http.Response(apiResponse, 200));

    final result = await remote.getRemote(
      id: tId,
      currency: tCurrency,
      days: tDays,
      dailyInterval: tDailyInterval,
    );

    expect(result, coinMarketChartModel);
  });

  test("Should throw a ServerExeption when something went wrong", () async {
    when(
      client.get(any, headers: anyNamed("headers")),
    ).thenAnswer((_) async => http.Response(apiResponse, 404));

    final call = remote.getRemote;

    expect(
      () =>  call(
            id: tId,
            currency: tCurrency,
            days: tDays,
            dailyInterval: tDailyInterval),
        throwsA(isA<ServerException>()));
  });
}
