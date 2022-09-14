import 'package:dartz/dartz.dart';

import '../../../../errors/failures.dart';
import '../entity/search_coin.dart';
import '../repository/get_search_items.dart';

class GetSearchCoin{
  final SearchCoinRepository repository;

  GetSearchCoin(this.repository);

  Future<Either<Failure, List<SearchCoin>>> call(String query) async {
    return await repository.getSearchCoin(query);
  }
}