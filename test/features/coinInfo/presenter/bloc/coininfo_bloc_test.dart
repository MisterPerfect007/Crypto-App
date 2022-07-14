import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_trends/core/network/network_info.dart';
import 'package:crypto_trends/errors/error_types.dart';
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
@GenerateMocks([NetworkInfo])
void main() {
  late CoinInfoBloc coinInfoBloc;
  late MockGetCoinMarketChart usecase;
  late MockNetworkInfo networkInfo;

  setUp(() {
    usecase = MockGetCoinMarketChart();
    networkInfo = MockNetworkInfo();
    coinInfoBloc = CoinInfoBloc(usecase: usecase, network: networkInfo);
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
      when(networkInfo.isConnected).thenAnswer((_) async => true);
  }
  blocTest<CoinInfoBloc, CoinInfoState>(
    "Should check networkInfo",
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
      verify(networkInfo.isConnected).called(1);
    }
  );
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
      with an internet connection and a correct CoinMarketChart is returned
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
    """ Should emit [CoinInfoLoading, CoinInfoFailure(ErrorType.failedRequest)] when GetCoinInfo is triggered
      with an internet connection and a ServerFailure is returned
    """,
    setUp: () {
      when(usecase.call(
        id: anyNamed("id"),
        currency: anyNamed("currency"),
        days: anyNamed("days"),
        dailyInterval: anyNamed("dailyInterval"),
      )).thenAnswer((_) async => Left(ServerFailure()));
      when(networkInfo.isConnected).thenAnswer((_) async => true);
    },
    build: () => coinInfoBloc,
    act: (bloc) => bloc.add(GetCoinInfo(
      currency: tCurrency,
      id: tId,
      days: tDays,
      dailyInterval: tDailyInterval,
    )),
    expect: () => [CoinInfoLoading(), const CoinInfoFailure(ErrorType.failedRequest)]
  );
  blocTest<CoinInfoBloc, CoinInfoState>(
    """ Should emit [CoinInfoLoading, CoinInfoFailure(ErrorType.noInternetConnection)] when GetCoinInfo is triggered
      with an internet connection and a NoConnectionFailure is returned
    """,
    setUp: () {
      when(usecase.call(
        id: anyNamed("id"),
        currency: anyNamed("currency"),
        days: anyNamed("days"),
        dailyInterval: anyNamed("dailyInterval"),
      )).thenAnswer((_) async => Left(NoConnectionFailure()));
      when(networkInfo.isConnected).thenAnswer((_) async => true);
    },
    build: () => coinInfoBloc,
    act: (bloc) => bloc.add(GetCoinInfo(
      currency: tCurrency,
      id: tId,
      days: tDays,
      dailyInterval: tDailyInterval,
    )),
    expect: () => [CoinInfoLoading(), const CoinInfoFailure(ErrorType.noInternetConnection)]
  );
  blocTest<CoinInfoBloc, CoinInfoState>(
    """ Should emit [CoinInfoLoading, CoinInfoFailure(ErrorType.noInternetConnection)] when GetCoinInfo is triggered
      without an internet connection
    """,
    setUp: () {
      when(networkInfo.isConnected).thenAnswer((_) async => false);
    },
    build: () => coinInfoBloc,
    act: (bloc) => bloc.add(GetCoinInfo(
      currency: tCurrency,
      id: tId,
      days: tDays,
      dailyInterval: tDailyInterval,
    )),
    expect: () => [CoinInfoLoading(),
            const CoinInfoFailure(ErrorType.noInternetConnection),],
    verify: (_) {
      verifyNever(usecase.call(
        id: anyNamed("id"),
        currency: anyNamed("currency"),
        days: anyNamed("days"),
        dailyInterval: anyNamed("dailyInterval"),
      ));
    }
  );
}
