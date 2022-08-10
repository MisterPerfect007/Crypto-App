
import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_trends/core/network/network_info.dart';
import 'package:crypto_trends/errors/error_types.dart';
import 'package:crypto_trends/features/coinList/domain/usecases/get_coin_list.dart';
import 'package:crypto_trends/features/home/presenter/bloc/top10/top_10_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../testData/coins_list_for_tests.dart';
import '../../../../coinInfo/presenter/bloc/coininfo_bloc_test.mocks.dart';
import '../../../../coinList/presenter/bloc/coin_list_bloc_test.mocks.dart';

@GenerateMocks([NetworkInfo])
@GenerateMocks([GetRemoteCoinList])

void main() {
  late Top10Bloc bloc;
  late MockNetworkInfo network;
  late MockGetRemoteCoinList getRemoteCoinList;

  setUp((){
    network = MockNetworkInfo();
    getRemoteCoinList = MockGetRemoteCoinList();
    bloc = Top10Bloc(networkInfo: network, getCoinList: getRemoteCoinList);
  });

  test("Initial state should be Top10Initial", () {
    expect(bloc.state, Top10Initial());
  });

  int perPage = 10;
  String tCurrency = "usd";
  int tPage = 1;

  void whenSuccess(){
    when(network.isConnected).thenAnswer((_) async => true);
    when(getRemoteCoinList.call(currency: tCurrency, perPage: perPage, page: tPage))
        .thenAnswer((_) async => Right(testCoinModels));
  }

  blocTest("check internet connection",
      setUp: () {
        when(network.isConnected).thenAnswer((_) async => false);
      },
      build: () => bloc,
      act: (_) => bloc.add(GetTop10Coins(perPage: perPage, currency: tCurrency, page: tPage)),
      verify: (_) {
        verify(network.isConnected).called(1);
        verifyNoMoreInteractions(network);
      });
  blocTest<Top10Bloc, Top10State>(
    "emit [TrendingCoinsFailure(ErrorType.noInternetConnection)] when there is no internet",
    setUp: () {
      when(network.isConnected).thenAnswer((_) async => false);
    },
    build: () => bloc,
    act: (bloc) => bloc.add(GetTop10Coins(perPage: perPage, currency: tCurrency, page: tPage)),
    expect: () => [const Top10Failure(ErrorType.noInternetConnection)],
  );

   blocTest<Top10Bloc, Top10State>(
    "emit [Top10Loading] when there is internet",
    setUp: () {
      whenSuccess();
    },
    build: () => bloc,
    act: (bloc) => bloc.add(GetTop10Coins(perPage: perPage, currency: tCurrency, page: tPage)),
    expect: () => [
      Top10Loading(),
      // const Top10Failure(ErrorType.failedRequest)
    ],
  );

  blocTest<Top10Bloc, Top10State>(
    "call the remote coin list when there is internet connection",
    setUp: () {
      whenSuccess();
      
    },
    build: () => bloc,
    act: (bloc) => bloc.add(GetTop10Coins(perPage: perPage, currency: tCurrency, page: tPage)),
    verify: (_) {
      verify(getRemoteCoinList.call(currency: tCurrency, perPage: perPage, page: tPage)).called(1);
      verifyNoMoreInteractions(getRemoteCoinList);
    },
  );

  blocTest<Top10Bloc, Top10State>(
    "emit [Top10Loading, Top10Loaded] when coinList is return",
    setUp: () {
      whenSuccess();
    },
    build: () => bloc,
    act: (bloc) => bloc.add(GetTop10Coins(perPage: perPage, currency: tCurrency, page: tPage)),
    expect:() => [
      Top10Loading(),
      Top10Loaded(coinList: testCoinModels)
    ],
  );

}