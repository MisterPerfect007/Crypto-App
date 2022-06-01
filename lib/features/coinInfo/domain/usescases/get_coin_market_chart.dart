import 'package:crypto_trends/features/coinInfo/domain/repository/get_coin_market_chart_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../errors/failures.dart';
import '../repository/get_coin_market_chart_repository.dart';

class GetCoinMarketChart {
  final GetCoinMarketChartRepository repository;

  const GetCoinMarketChart({required this.repository});

  Future<Either<Failure, List<List>>> call({
    required String id,
    required String currency,
    required String days,
    required bool dailyInterval,
  }) async {
    return await repository.getRemoteCoinMarketChart(
      id: id,
      currency: currency,
      days: days,
      dailyInterval: dailyInterval,
    );
  }
}
