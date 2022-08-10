import 'package:dartz/dartz.dart';

import '../../../../errors/failures.dart';
import '../entities/coin.dart';
import '../repositories/get_coin_list_repository.dart';

class GetRemoteCoinList {
  final CoinListRepository repository;

  GetRemoteCoinList({required this.repository});

  Future<Either<Failure, List<Coin>>> call( {required String currency, int? page, List<String>? ids, int? perPage}) async {
    return await repository.getRemoteCoinList(currency: currency, page: page, ids: ids, perPage: perPage);
  }
}
