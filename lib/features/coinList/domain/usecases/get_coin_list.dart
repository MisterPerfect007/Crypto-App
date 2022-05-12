import 'package:dartz/dartz.dart';

import '../../../../errors/failures.dart';
import '../entities/coin.dart';
import '../repositories/get_coin_list_repository.dart';

class GetCoinList {
  final CoinListRepository repository;

  GetCoinList({
    required this.repository
  });

  Future<Either<Failure, List<Coin>>> call(String currency, int page) async {
    return await repository.getCoinList(currency: currency, page: page);
  }
}
