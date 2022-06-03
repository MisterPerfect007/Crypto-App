import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_trends/errors/failures.dart';
import 'package:crypto_trends/features/coinInfo/domain/entities/coin_market_chart.dart';
import 'package:crypto_trends/features/coinInfo/domain/usescases/get_coin_market_chart.dart';
import 'package:crypto_trends/features/coinInfo/presenter/bloc/coininfo_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../testData/coin_market_chart.dart';
import 'coininfo_bloc_test.mocks.dart';

@GenerateMocks([GetCoinMarketChart])
void main() {
  late CoinInfoBloc coinInfoBloc;
  late MockGetCoinMarketChart usecase;

  setUp(() {
    usecase = MockGetCoinMarketChart();
    coinInfoBloc = CoinInfoBloc(usecase: usecase);
  });
  String tId = "bitcoin";
  String tCurrency = "usd";
  String tDays = "7";
  bool tDailyInterval = true;
  final CoinMarketChart coinMarketChart = CoinMarketChart(prices: testCoinMarketChart);

  test("initial should be [CoinInfoInitial]", () {
    expect(coinInfoBloc.state, CoinInfoInitial());
  });

  void whenSuccess(){
    when(usecase.call(
        id: anyNamed("id"),
        currency: anyNamed("currency"),
        days: anyNamed("days"),
        dailyInterval: anyNamed("dailyInterval"),
      )).thenAnswer((_) async => Right(coinMarketChart));
  }
  blocTest<CoinInfoBloc, CoinInfoState>(
    "Should call usecase with corrent parameters",
    setUp: () {
      whenSuccess();
    },
    build: () => coinInfoBloc,
    act: (bloc) => bloc.add(GetCoinInfo(
      currency: tCurrency,
      id: tId,
      days: tDays,
      dailyInterval: tDailyInterval,
    )),
    verify: (_) {
      verify(usecase.call(
        id: tId,
        currency: tCurrency,
        days: tDays,
        dailyInterval: tDailyInterval,
      )).called(1);
    }
  );

  blocTest<CoinInfoBloc, CoinInfoState>(
    """ Should emit [CoinInfoLoading, CoinInfoLoaded] when GetCoinInfo is triggered
      and a correct CoinMarketChart is returned
    """,
    setUp: () {
      whenSuccess();
    },
    build: () => coinInfoBloc,
    act: (bloc) => bloc.add(GetCoinInfo(
      currency: tCurrency,
      id: tId,
      days: tDays,
      dailyInterval: tDailyInterval,
    )),
    expect: () => [CoinInfoLoading(), CoinInfoLoaded(coinMarketChart: coinMarketChart)]
  );

  blocTest<CoinInfoBloc, CoinInfoState>(
    """ Should emit [CoinInfoLoading, CoinInfoError] when GetCoinInfo is triggered
      and a ServerFailure is returned
    """,
    setUp: () {
      when(usecase.call(
        id: anyNamed("id"),
        currency: anyNamed("currency"),
        days: anyNamed("days"),
        dailyInterval: anyNamed("dailyInterval"),
      )).thenAnswer((_) async => Left(ServerFailure()));
    },
    build: () => coinInfoBloc,
    act: (bloc) => bloc.add(GetCoinInfo(
      currency: tCurrency,
      id: tId,
      days: tDays,
      dailyInterval: tDailyInterval,
    )),
    expect: () => [CoinInfoLoading(), CoinInfoError()]
  );
}
