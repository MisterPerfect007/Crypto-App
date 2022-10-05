import '../../../../errors/failures.dart';
import '../entities/coin.dart';
import 'package:dartz/dartz.dart';

abstract class CoinListRepository{
  Future<Either<Failure, List<Coin>>> getRemoteCoinList({int? page, List<String>? ids, int? perPage});
}