
import 'package:crypto_trends/core/network/network_info.dart';
import 'package:dartz/dartz.dart';

import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';

import 'package:crypto_trends/errors/failures.dart';

import '../../domain/repositories/get_coin_list_repository.dart';

class CoinListRepositoryImpl implements CoinListRepository{
  // final NetworkInfo networkInfo;
  // final 
  // const CoinListRepositoryImpl({});
  @override
  Future<Either<Failure, List<Coin>>> getRemoteCoinList({required String currency, int? page}) {
    // TODO: implement getCoinList
    throw UnimplementedError();
  }
  
}