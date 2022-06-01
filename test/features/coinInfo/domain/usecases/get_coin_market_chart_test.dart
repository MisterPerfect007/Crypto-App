import 'package:crypto_trends/features/coinInfo/domain/repository/get_coin_market_chart_repository.dart';
import 'package:crypto_trends/features/coinInfo/domain/usescases/get_coin_market_chart.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../testData/coin_market_chart.dart';
import 'get_coin_market_chart_test.mocks.dart';

@GenerateMocks([GetCoinMarketChartRepository])
void main() {
  late GetCoinMarketChart usecase;
  late MockGetCoinMarketChartRepository repository;

  setUp(() {
    repository = MockGetCoinMarketChartRepository();
    usecase = GetCoinMarketChart(repository: repository);
  });

  String id = "bitcoin";
  String currency = "usd";
  String days = "7";
  bool dailyInterval = true;

  test("Should get coinMarketChart from repository", () async {
    when(repository.getRemoteCoinMarketChart(
      id: anyNamed("id"),
      currency: anyNamed("currency"),
      days: anyNamed("days"),
      dailyInterval: anyNamed("dailyInterval"),
    )).thenAnswer(
      (_) async => const Right(testCoinMarketChart),
    );

    final result = await usecase.call(
      id: id,
      currency: currency,
      days: days,
      dailyInterval: dailyInterval,
    );
    verify(repository.getRemoteCoinMarketChart(
      id: id,
      currency: currency,
      days: days,
      dailyInterval: dailyInterval,
    )).called(1);

    expect(result, const Right(testCoinMarketChart));

    verifyNoMoreInteractions(repository);
  });
}
