import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_trends/core/network/network_info.dart';
import 'package:crypto_trends/errors/error_types.dart';
import 'package:crypto_trends/errors/errors_message.dart';
import 'package:crypto_trends/errors/failures.dart';
import 'package:crypto_trends/features/coinList/domain/usecases/get_coin_list.dart';
import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:crypto_trends/features/coinList/presenter/widgets/sorting%20criteria/criteria_list.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../testData/coins_list_for_tests.dart';
import 'coin_list_bloc_test.mocks.dart';

@GenerateMocks([GetRemoteCoinList])
@GenerateMocks([NetworkInfoImpl])

void main() {
  late CoinListBloc bloc;
  late MockGetRemoteCoinList getRemoteCoinList;
  late MockNetworkInfoImpl network;
  setUp(() {
    getRemoteCoinList = MockGetRemoteCoinList();
    network = MockNetworkInfoImpl();
    bloc = CoinListBloc(getRemoteCoinList: getRemoteCoinList, network: network);
  });

  test("Initial state should be CoinListInitial", () {
    expect(bloc.state, CoinListInitial());
  });
  const tCurrency = "usd";
  const tPage = 2;
  group(
    "CoinListGet",
    (() {
      void whenAllStubSuccess(){
        when(network.isConnected)
                .thenAnswer((_) async => true);
        when(getRemoteCoinList(any, any))
                .thenAnswer((_) async => Right(testCoins));
      }
      blocTest<CoinListBloc, CoinListState>(
          'Should make call to the usecase with correct given arguments',
          setUp: () {
            whenAllStubSuccess();
          },
          build: () => bloc,
          act: (bloc) =>
              bloc.add(const CoinListGet(currency: tCurrency, page: tPage, sortingCriteria: rankDesc)),
          verify: (_) {
            verify(getRemoteCoinList(tCurrency, tPage)).called(1);
          });
      blocTest<CoinListBloc, CoinListState>(
          'Should check internet connection',
          setUp: () {
            whenAllStubSuccess();
          },
          build: () => bloc,
          act: (bloc) =>
              bloc.add(const CoinListGet(currency: tCurrency, page: tPage, sortingCriteria: rankDesc)),
          verify: (_) {
            verify(network.isConnected).called(1);
          });
      blocTest<CoinListBloc, CoinListState>(
          'Should emit [CoinListLoading, CoinListFailure(ErrorType.noInternetConnection)] when there is no internet connection',
          setUp: () {
            when(network.isConnected)
                .thenAnswer((_) async => false);
          },
          build: () => bloc,
          act: (bloc) =>
              bloc.add(const CoinListGet(currency: tCurrency, page: tPage, sortingCriteria: rankDesc)),
          expect: () => [CoinListLoading(), const CoinListFailure(ErrorType.noInternetConnection)]
          );

      blocTest<CoinListBloc, CoinListState>(
          'Should emit [CoinListLoading, CoinListLoaded] when GetCoinList with internet connection is triggered with success response',
          setUp: () {
            whenAllStubSuccess();
          },
          build: () => bloc,
          act: (bloc) =>
              bloc.add(const CoinListGet(currency: tCurrency, page: tPage, sortingCriteria: rankDesc)),
          expect: () =>
              [CoinListLoading(), CoinListLoaded(coinList: testCoins)]);
      blocTest<CoinListBloc, CoinListState>(
          'Should emit [CoinListLoading, CoinListFailure] when GetCoinList is triggered and some failure is returned',
          setUp: () {
             when(network.isConnected)
                .thenAnswer((_) async => true);
            when(getRemoteCoinList(any, any))
                .thenAnswer((_) async => Left(ServerFailure()));
          },
          build: () => bloc,
          act: (bloc) =>
              bloc.add(const CoinListGet(currency: tCurrency, page: tPage, sortingCriteria: rankDesc)),
          expect: () =>
              [CoinListLoading(), const CoinListFailure(ErrorType.failedRequest)]);
    }),
  );
  group("CoinListUpdate", () {
    blocTest<CoinListBloc, CoinListState>(
        'Should make call to the usecase with correct given arguments',
        setUp: () {
          when(getRemoteCoinList(any, any))
              .thenAnswer((_) async => Right(testCoins));
        },
        build: () => bloc,
        act: (bloc) => bloc.add(const CoinListUpdate(
            currency: tCurrency, page: tPage, sortingCriteria: rankDesc)),
        verify: (_) {
          verify(getRemoteCoinList(tCurrency, tPage)).called(1);
        });
    blocTest<CoinListBloc, CoinListState>(
        'Should emit [CoinListUpdateLoading, CoinListUpdateLoaded] when CoinListupdate is triggered with success response',
        setUp: () {
          when(getRemoteCoinList(any, any))
              .thenAnswer((_) async => Right(testCoins));
        },
        build: () => bloc,
        act: (bloc) => bloc.add(const CoinListUpdate(
            currency: tCurrency, page: tPage, sortingCriteria: rankDesc)),
        expect: () => [CoinListLoaded(coinList: testCoins, isUpdate: true)]);
    blocTest<CoinListBloc, CoinListState>(
        'Should emit any state when CoinListUpdate is triggered and some failure is returned',
        setUp: () {
          when(getRemoteCoinList(any, any))
              .thenAnswer((_) async => Left(ServerFailure()));
        },
        build: () => bloc,
        act: (bloc) => bloc.add(const CoinListUpdate(
            currency: tCurrency, page: tPage, sortingCriteria: rankDesc)),
        expect: () => []);
  });
}
