import 'package:crypto_trends/errors/exceptions.dart';
import 'package:crypto_trends/features/coinList/data/datasources/coin_list_remote_data_source.dart';
import 'package:dartz/dartz.dart';

import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';

import 'package:crypto_trends/errors/failures.dart';

import '../../domain/repositories/get_coin_list_repository.dart';

class CoinListRepositoryImpl implements CoinListRepository{
  final CoinListRemoteDataSource remote;

  CoinListRepositoryImpl({required this.remote});
  @override
  Future<Either<Failure, List<Coin>>> getRemoteCoinList({required String currency, int? page}) async {
    try {
      final coinModelsList =  await remote.getRemoteCoinList(currency: currency, page: page);
      return Right(coinModelsList);
      
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
}