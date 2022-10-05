import 'package:crypto_trends/features/coinList/domain/repositories/get_coin_list_repository.dart';
import 'package:crypto_trends/features/coinList/domain/usecases/get_coin_list.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../testData/coins_list_for_tests.dart';
import 'get_coin_list_test.mocks.dart';

@GenerateMocks([CoinListRepository])
void main() {
  late MockCoinListRepository repository;
  late GetRemoteCoinList usecase;
  setUp(() {
    repository = MockCoinListRepository();
    usecase = GetRemoteCoinList(repository: repository);
  });
  
  const testPage = 1;
  test("Should get coins from repository", () async {
    when(repository.getRemoteCoinList(page: testPage))
        .thenAnswer((_) async => Right(testCoins));

    final result = await usecase(page: testPage);

    expect(result, Right(testCoins));
    verify(repository.getRemoteCoinList(page: testPage))
        .called(1);
    verifyNoMoreInteractions(repository);
  });
}
