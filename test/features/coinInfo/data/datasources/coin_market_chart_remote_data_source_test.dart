import 'package:crypto_trends/errors/exceptions.dart';
import 'package:crypto_trends/features/coinInfo/data/datasources/coin_market_chart_remote_data_source.dart';
import 'package:crypto_trends/features/coinInfo/data/models/coin_market_chart_model.dart';
import 'package:crypto_trends/features/settings/utils/currencies.dart';
import 'package:crypto_trends/features/settings/utils/get_currency.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../testData/json/json_reader.dart';
import '../../testData/coin_market_chart.dart';
import 'coin_market_chart_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client, CurrencyStorage])
void main() {
  late MockClient client;
  late CoinMarketChartRemoteDataSourceImpl remote;
  late MockCurrencyStorage localStorage;
  
  final Map<String, String> defaultHeader = {
    'Content-type': 'application/json'
  };
  setUp(() {
    client = MockClient();
    localStorage = MockCurrencyStorage();
    remote = CoinMarketChartRemoteDataSourceImpl(client: client, currencyStorage: localStorage);
  });
  const tId = "bitcoin";
  const tDays = "7";
  const tDailyInterval = true;

  final String apiResponse = readJson("coin_market_chart.json");
  final CoinMarketChartModel coinMarketChartModel =
      CoinMarketChartModel(prices: testCoinMarketChart);

  test("Should make the API call with given parameters and headers", () async {
    when(
      client.get(any, headers: anyNamed("headers")),
    ).thenAnswer((_) async => http.Response(apiResponse, 200));
    when(localStorage.getCurrentCurrency()).thenReturn(currenciesList.first);

    await remote.getRemote(
      id: tId,
      days: tDays,
      dailyInterval: tDailyInterval,
    );

    verify(
      client.get(
          buildUrl(
            id: tId,
            days: tDays,
            currency: "USD",
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
    when(localStorage.getCurrentCurrency()).thenReturn(currenciesList.first);

    final result = await remote.getRemote(
      id: tId,
      days: tDays,
      dailyInterval: tDailyInterval,
    );

    expect(result, coinMarketChartModel);
  });

  test("Should throw a ServerExeption when the request did not succeed (status != 200)", () async {
    when(
      client.get(any, headers: anyNamed("headers")),
    ).thenAnswer((_) async => http.Response(apiResponse, 404));
    when(localStorage.getCurrentCurrency()).thenReturn(currenciesList.first);

    final call = remote.getRemote;

    expect(
      () =>  call(
            id: tId,
            days: tDays,
            dailyInterval: tDailyInterval),
        throwsA(isA<ServerException>()));
  });

  test("Should throw a NoConnectionException when something went wrong and throw an unexpected exception", () async {
    when(
      client.get(any, headers: anyNamed("headers")),
    ).thenThrow(Exception());

    final call = remote.getRemote;

    expect(
      () =>  call(
            id: tId,
            days: tDays,
            dailyInterval: tDailyInterval),
        throwsA(isA<NoConnectionException>()));
  });
}
