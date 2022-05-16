import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_trends/features/coinList/domain/usecases/get_coin_list.dart';
import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../testData/coins_list_for_tests.dart';
import 'coin_list_bloc_test.mocks.dart';

@GenerateMocks([GetRemoteCoinList])
void main() {
  late CoinListBloc bloc;
  late MockGetRemoteCoinList getRemoteCoinList;
  setUp(() {
    getRemoteCoinList = MockGetRemoteCoinList();
    bloc = CoinListBloc(getRemoteCoinList: getRemoteCoinList);
  });
  test("Initial state should be CoinListInitial", () {
    expect(bloc.state, CoinListInitial());
  });
  const tCurrency = "usd";
  const tPage = 2;
  blocTest<CoinListBloc, CoinListState>(
      'Should make call to the usecase with correct given arguments',
      setUp: () {
        when(getRemoteCoinList(any, any))
            .thenAnswer((_) async => const Right(testCoins));
      },
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const GetCoinList(currency: tCurrency, page: tPage)),
      verify: (_) {
        verify(getRemoteCoinList(tCurrency, tPage)).called(1);
      });
  
  blocTest<CoinListBloc, CoinListState>(
      'Should emit [CoinListLoading, CoinListLoaded] when GetCoinList is triggered with success response',
      setUp: () {
        when(getRemoteCoinList(any, any))
            .thenAnswer((_) async => const Right(testCoins));
      },
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const GetCoinList(currency: tCurrency, page: tPage)),
      expect: () => [CoinListLoading(), const CoinListLoaded(testCoins)]);
  // blocTest<CoinListBloc, CoinListState>(
  //     'Should emit [CoinListLoading, CoinListFailure] when GetCoinList is triggered and some failure is returned',
  //     setUp: () {
  //       when(getRemoteCoinList(any, any))
  //           .thenAnswer((_) async => const Right(testCoins));
  //     },
  //     build: () => bloc,
  //     act: (bloc) =>
  //         bloc.add(const GetCoinList(currency: tCurrency, page: tPage)),
  //     expect: () => [CoinListLoading(), const CoinListFailure()]);
}
