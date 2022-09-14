import 'package:crypto_trends/errors/failures.dart';
import 'package:crypto_trends/features/search/domain/entity/search_coin.dart';
import 'package:dartz/dartz.dart';

abstract class SearchCoinRepository {
  Future<Either<Failure, List<SearchCoin>>> getSearchCoin(String query);
}