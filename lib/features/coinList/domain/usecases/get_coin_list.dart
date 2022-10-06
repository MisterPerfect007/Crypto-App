import 'package:dartz/dartz.dart';

import '../../../../errors/failures.dart';
import '../entities/coin.dart';
import '../repositories/get_coin_list_repository.dart';

class GetRemoteCoinList {
  final CoinListRepository repository;

  GetRemoteCoinList({required this.repository});

  Future<Either<Failure, List<Coin>>> call( {int? page, List<String>? ids, int? perPage}) async {
    return await repository.getRemoteCoinList(page: page, ids: ids, perPage: perPage);
  }
}
