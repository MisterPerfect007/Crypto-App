import 'package:crypto_trends/errors/exceptions.dart';
import 'package:crypto_trends/errors/failures.dart';
import 'package:crypto_trends/features/coinList/data/datasources/coin_list_remote_data_source.dart';
import 'package:crypto_trends/features/coinList/data/repository/get_coin_list_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../testData/coins_list_for_tests.dart';
import 'get_coin_list_repository_implementation_test.mocks.dart';

@GenerateMocks([CoinListRemoteDataSourceImpl])
void main() {
  late MockCoinListRemoteDataSourceImpl remote;
  late CoinListRepositoryImpl repository;

  setUp(() {
    remote = MockCoinListRemoteDataSourceImpl();
    repository = CoinListRepositoryImpl(remote: remote);
  });
  const tPage = 2;

  test(
      "Should call the getRemoteCoinList method with correct arguments",
      () async {
    when(remote.getRemoteCoinList(page: anyNamed("page")))
        .thenAnswer((_) async => testCoinModels);

    await repository.getRemoteCoinList(page: tPage);

    verify(remote.getRemoteCoinList(page: tPage))
        .called(1);
    verifyNoMoreInteractions(remote);
  });
  test("Should return a List of [Coin] when everything went good", () async {
    when(remote.getRemoteCoinList(page: anyNamed("page")))
        .thenAnswer((_) async => testCoinModels);
    final result = await repository.getRemoteCoinList(page: tPage);

    expect(result, Right(testCoinModels));
  });
  test("Should return a ServerFailure when a ServerException is thrown", () async {
    when(remote.getRemoteCoinList(page: anyNamed("page")))
        .thenThrow(ServerException());
    final result = await repository.getRemoteCoinList(page: tPage);

    expect(result, Left(ServerFailure()));
  });
}
