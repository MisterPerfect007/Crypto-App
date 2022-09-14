import 'package:crypto_trends/features/search/domain/entity/search_coin.dart';
import 'package:crypto_trends/errors/failures.dart';
import 'package:crypto_trends/features/search/domain/repository/get_search_items.dart';
import 'package:dartz/dartz.dart';

import '../../../../errors/exceptions.dart';
import '../datasources/search_item_data_source.dart';

class SearchCoinRepositoryImpl implements SearchCoinRepository{
  final SearchItemDataSource source;
  const SearchCoinRepositoryImpl(this.source);

  @override
  Future<Either<Failure, List<SearchCoin>>> getSearchCoin(String query) async {
    try {
      final coinModelsList =  await source.getSearchItem(query);
      return Right(coinModelsList);
    } on ServerException {
      return Left(ServerFailure());
    } on NoConnectionException {
      return Left(NoConnectionFailure());
    }
  }
}