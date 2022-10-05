import 'package:crypto_trends/errors/exceptions.dart';
import 'package:crypto_trends/features/coinList/data/datasources/coin_list_remote_data_source.dart';
import 'package:crypto_trends/features/settings/utils/currencies.dart';
import 'package:crypto_trends/features/settings/utils/get_currency.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../testData/coins_list_for_tests.dart';
import '../../../../testData/json/json_reader.dart';
import 'coin_list_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client, CurrencyStorage])
void main() {
  // http
  late MockClient client;
  late CoinListRemoteDataSourceImpl remote;
  late MockCurrencyStorage localStorage;
  final Map<String, String> defaultHeader = {
    'Content-type': 'application/json'
  };
  setUp(() {
    client = MockClient();
    localStorage = MockCurrencyStorage();
    remote = CoinListRemoteDataSourceImpl(
        client: client, currencyStorage: localStorage);
  });

  const tPage = 2;
  const tIds = ["bitcoin", "tether"];
  final apiResponseBody = readJson('coin_list.json');

  test(
      "Should make a call to coin list API with corrent parameters and the right Header",
      (() async {
    when(client.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response(apiResponseBody, 200));
    when(localStorage.getCurrentCurrency()).thenReturn(currenciesList.first);

    await remote.getRemoteCoinList(page: tPage);

    // print(buildUrl(currency: tCurrency, page: null,).toString());

    verify(client.get(
            buildUrl(
              currency: "USD",
              page: tPage,
            ),
            headers: defaultHeader))
        .called(1);
  }));

  test(
      "Should make a call to coin list API with corrent parameters including ids list and the right Header",
      (() async {
    when(client.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response(apiResponseBody, 200));
    when(localStorage.getCurrentCurrency()).thenReturn(currenciesList.first);

    await remote.getRemoteCoinList(page: tPage, ids: tIds);

    verify(client.get(
            buildUrl(
              currency: "USD",
              page: tPage,
              ids: tIds,
            ),
            headers: defaultHeader))
        .called(1);
  }));

  test("Should return a valid coin list when the call to Api successed",
      () async {
    when(client.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response(apiResponseBody, 200));
    when(localStorage.getCurrentCurrency()).thenReturn(currenciesList.first);

    final result = await remote.getRemoteCoinList(page: tPage);

    expect(result, testCoinModels);
  });

  test("Should throw a ServerException when the call to the API failed", () {
    when(client.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response("Something wrong", 404));
    when(localStorage.getCurrentCurrency()).thenReturn(currenciesList.first);

    final call = remote.getRemoteCoinList;

    expect(() => call(page: tPage), throwsA(isA<ServerException>()));
  });

  test(
      "Should throw a NoConnectionException when something went wrong and an unexpected exception is throwed ",
      () {
    when(client.get(any, headers: anyNamed("headers"))).thenThrow(Exception());
    when(localStorage.getCurrentCurrency()).thenReturn(currenciesList.first);

    final call = remote.getRemoteCoinList;

    expect(() => call(page: tPage), throwsA(isA<NoConnectionException>()));
  });
}
