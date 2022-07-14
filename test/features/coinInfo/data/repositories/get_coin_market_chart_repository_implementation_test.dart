import 'package:crypto_trends/errors/exceptions.dart';
import 'package:crypto_trends/errors/failures.dart';
import 'package:crypto_trends/features/coinInfo/data/datasources/coin_market_chart_remote_data_source.dart';
import 'package:crypto_trends/features/coinInfo/data/models/coin_market_chart_model.dart';
import 'package:crypto_trends/features/coinInfo/data/repositories/get_coin_market_chart_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../testData/coin_market_chart.dart';
import 'get_coin_market_chart_repository_implementation_test.mocks.dart';

@GenerateMocks([CoinMarketChartRemoteDataSourceImpl])
void main() {
  late MockCoinMarketChartRemoteDataSourceImpl dataSource;
  late GetCoinMarketChartRepositoryImpl repository;

  setUp(() {
    dataSource = MockCoinMarketChartRemoteDataSourceImpl();
    repository = GetCoinMarketChartRepositoryImpl(remote: dataSource);
  });

  const tId = "bitcoin";
  const tCurrency = "usd";
  const tDays = "7";
  const tDailyInterval = true;

  void whenSuccess() {
    when(
      dataSource.getRemote(
        id: anyNamed("id"),
        currency: anyNamed("currency"),
        days: anyNamed("days"),
        dailyInterval: anyNamed("dailyInterval"),
      ),
    ).thenAnswer(
        (_) async => CoinMarketChartModel(prices: testCoinMarketChart));
  }

  test("Should get Coin market chart data from datasource", () async {
    whenSuccess();

    await repository.getRemoteCoinMarketChart(
      id: tId,
      currency: tCurrency,
      days: tDays,
      dailyInterval: tDailyInterval,
    );
    verify(dataSource.getRemote(
      id: tId,
      currency: tCurrency,
      days: tDays,
      dailyInterval: tDailyInterval,
    )).called(1);
    verifyNoMoreInteractions(dataSource);
  });

  test("Should return Coin  market chart data when every was fine", () async {
    whenSuccess();

    final result = await repository.getRemoteCoinMarketChart(
      id: tId,
      currency: tCurrency,
      days: tDays,
      dailyInterval: tDailyInterval,
    );

    expect(result, Right(CoinMarketChartModel(prices: testCoinMarketChart)));
  });

  test("Should return a server failure when the request fails", () async {
    when(
      dataSource.getRemote(
        id: anyNamed("id"),
        currency: anyNamed("currency"),
        days: anyNamed("days"),
        dailyInterval: anyNamed("dailyInterval"),
      ),
    ).thenThrow(ServerException());

    final result = await repository.getRemoteCoinMarketChart(
      id: tId,
      currency: tCurrency,
      days: tDays,
      dailyInterval: tDailyInterval,
    );

    expect(result, left(ServerFailure()));
  });

  test("Should return a NoConnectionFailure when a NoConnectionException is throwed", () async {
    when(
      dataSource.getRemote(
        id: anyNamed("id"),
        currency: anyNamed("currency"),
        days: anyNamed("days"),
        dailyInterval: anyNamed("dailyInterval"),
      ),
    ).thenThrow(NoConnectionException());

    final result = await repository.getRemoteCoinMarketChart(
      id: tId,
      currency: tCurrency,
      days: tDays,
      dailyInterval: tDailyInterval,
    );

    expect(result, left(NoConnectionFailure()));
  });
}
