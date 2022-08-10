import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_trends/core/network/network_info.dart';
import 'package:crypto_trends/errors/error_types.dart';
import 'package:crypto_trends/errors/failures.dart';
import 'package:crypto_trends/features/coinList/domain/usecases/get_coin_list.dart';
import 'package:crypto_trends/features/home/data/trending_coin_remote_data_source.dart';
import 'package:crypto_trends/features/home/presenter/bloc/trending_coin/trending_coin_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../testData/coins_list_for_tests.dart';
import 'trending_coin_bloc_test.mocks.dart';

@GenerateMocks([NetworkInfo])
@GenerateMocks([TrendingCoinRemoteDataSource])
@GenerateMocks([GetRemoteCoinList])
void main() {
  late TrendingCoinsBloc bloc;
  late MockTrendingCoinRemoteDataSource trendingCoinRemote;
  late MockGetRemoteCoinList getRemoteCoinList;
  late MockNetworkInfo network;

  setUp(() {
    trendingCoinRemote = MockTrendingCoinRemoteDataSource();
    getRemoteCoinList = MockGetRemoteCoinList();
    network = MockNetworkInfo();
    bloc = TrendingCoinsBloc(
      getCoinList: getRemoteCoinList,
      networkInfo: network,
      trendingCoinSource: trendingCoinRemote,
    );
  });

  test("Initial state should be CoinListInitial", () {
    expect(bloc.state, TrendingCoinsInitial());
  });

  whenSuccess() {
    when(trendingCoinRemote.getTrendingCoinsIds())
        .thenAnswer((_) async => ['bitcoin', 'tether']);
    when(network.isConnected).thenAnswer((_) async => true);
  }

  blocTest("check internet connection",
      setUp: () {
        when(network.isConnected).thenAnswer((_) async => false);
      },
      build: () => bloc,
      act: (_) => bloc.add(GetTrendingCoins()),
      verify: (_) {
        verify(network.isConnected).called(1);
        verifyNoMoreInteractions(network);
      });

  blocTest<TrendingCoinsBloc, TrendingCoinsState>(
    "emit [TrendingCoinsFailure(ErrorType.noInternetConnection)] when there is no internet",
    setUp: () {
      when(network.isConnected).thenAnswer((_) async => false);
    },
    build: () => bloc,
    act: (bloc) => bloc.add(GetTrendingCoins()),
    expect: () => [const TrendingCoinsFailure(ErrorType.noInternetConnection)],
  );
  blocTest<TrendingCoinsBloc, TrendingCoinsState>(
    "emit [TrendingCoinsLoading] ] when there is internet",
    setUp: () {
      whenSuccess();
    },
    build: () => bloc,
    act: (bloc) => bloc.add(GetTrendingCoins()),
    expect: () => [
      TrendingCoinsLoading(),
      const TrendingCoinsFailure(ErrorType.failedRequest)
    ],
  );

  blocTest<TrendingCoinsBloc, TrendingCoinsState>(
      "call the trending coins data source when there is internet connection",
      setUp: () {
        whenSuccess();
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTrendingCoins()),
      verify: (_) {
        verify(trendingCoinRemote.getTrendingCoinsIds()).called(1);
        verifyNoMoreInteractions(trendingCoinRemote);
      });

  blocTest<TrendingCoinsBloc, TrendingCoinsState>(
    """emit [TrendingCoinsLoading, TrendingCoinsFailure(ErrorType.failredRequest)]
      when trending coins data source throw an exception""",
    setUp: () {
      when(network.isConnected).thenAnswer((_) async => true);
      when(trendingCoinRemote.getTrendingCoinsIds()).thenThrow(Exception());
    },
    build: () => bloc,
    act: (bloc) => bloc.add(GetTrendingCoins()),
    expect: () => [
      TrendingCoinsLoading(),
      const TrendingCoinsFailure(ErrorType.failedRequest),
    ],
  );

  blocTest<TrendingCoinsBloc, TrendingCoinsState>(
    """emit [TrendingCoinsLoading, TrendingCoinsFailure(ErrorType.failredRequest)]
      when ids list is empty""",
    setUp: () {
      final List<String> ids = []; //empty
      when(trendingCoinRemote.getTrendingCoinsIds())
          .thenAnswer((_) async => ids);
      when(network.isConnected).thenAnswer((_) async => true);
    },
    build: () => bloc,
    act: (bloc) => bloc.add(GetTrendingCoins()),
    expect: () => [
      TrendingCoinsLoading(),
      const TrendingCoinsFailure(ErrorType.failedRequest),
    ],
  );
  blocTest<TrendingCoinsBloc, TrendingCoinsState>(
    "call getRemoteCoinList when ids is not empty",
    setUp: () {
      final List<String> ids = ['bitcoin']; //not empty
      when(trendingCoinRemote.getTrendingCoinsIds())
          .thenAnswer((_) async => ids);
      when(network.isConnected).thenAnswer((_) async => true);
      when(getRemoteCoinList.call(
        currency: anyNamed("currency"),
        ids: anyNamed("ids"),
      )).thenAnswer((_) async => Right(testCoinModels));
    },
    build: () => bloc,
    act: (bloc) => bloc.add(GetTrendingCoins()),
    verify: (_) {
      verify(getRemoteCoinList.call(currency: "usd", ids: ['bitcoin']))
          .called(1);
    },
  );
  blocTest<TrendingCoinsBloc, TrendingCoinsState>(
    """emit [TrendingCoinsLoading, TrendingCoinsLoaded] 
    when getRemoteCoinList return coin list""",
    setUp: () {
      final List<String> ids = ['bitcoin']; //not empty
      when(trendingCoinRemote.getTrendingCoinsIds())
          .thenAnswer((_) async => ids);
      when(network.isConnected).thenAnswer((_) async => true);
      when(getRemoteCoinList.call(
        currency: anyNamed("currency"),
        ids: anyNamed("ids"),
      )).thenAnswer((_) async => Right(testCoinModels));
    },
    build: () => bloc,
    act: (bloc) => bloc.add(GetTrendingCoins()),
    expect: () => [
      TrendingCoinsLoading(),
      TrendingCoinsLoaded(coinList: testCoinModels),
    ],
  );

  blocTest<TrendingCoinsBloc, TrendingCoinsState>(
    """emit [TrendingCoinsLoading, TrendingCoinsFailure(ErrorType.failedRequest)] 
    when getRemoteCoinList return ServerFailure""",
    setUp: () {
      final List<String> ids = ['bitcoin']; //not empty
      when(trendingCoinRemote.getTrendingCoinsIds())
          .thenAnswer((_) async => ids);
      when(network.isConnected).thenAnswer((_) async => true);
      when(getRemoteCoinList.call(
        currency: anyNamed("currency"),
        ids: anyNamed("ids"),
      )).thenAnswer((_) async => Left(ServerFailure()));
    },
    build: () => bloc,
    act: (bloc) => bloc.add(GetTrendingCoins()),
    expect: () => [
      TrendingCoinsLoading(),
      const TrendingCoinsFailure(ErrorType.failedRequest),
    ],
  );

  blocTest<TrendingCoinsBloc, TrendingCoinsState>(
    """emit [TrendingCoinsLoading, TrendingCoinsFailure(ErrorType.noInternetConnection)] 
    when getRemoteCoinList return ServerFailure""",
    setUp: () {
      final List<String> ids = ['bitcoin']; //not empty
      when(trendingCoinRemote.getTrendingCoinsIds())
          .thenAnswer((_) async => ids);
      when(network.isConnected).thenAnswer((_) async => true);
      when(getRemoteCoinList.call(
        currency: anyNamed("currency"),
        ids: anyNamed("ids"),
      )).thenAnswer((_) async => Left(NoConnectionFailure()));
    },
    build: () => bloc,
    act: (bloc) => bloc.add(GetTrendingCoins()),
    expect: () => [
      TrendingCoinsLoading(),
      const TrendingCoinsFailure(ErrorType.noInternetConnection),
    ],
  );
}
