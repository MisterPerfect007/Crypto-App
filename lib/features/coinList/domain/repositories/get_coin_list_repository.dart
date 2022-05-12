import '../../../../errors/failures.dart';
import '../entities/coin.dart';
import 'package:dartz/dartz.dart';

abstract class CoinListRepository{
  Future<Either<Failure, List<Coin>>> getCoinList({required String currency, int page});
}