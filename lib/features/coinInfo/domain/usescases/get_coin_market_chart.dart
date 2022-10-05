import 'package:crypto_trends/features/coinInfo/domain/repository/get_coin_market_chart_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../errors/failures.dart';
import '../entities/coin_market_chart.dart';

class GetCoinMarketChart {
  final GetCoinMarketChartRepository repository;

  const GetCoinMarketChart({required this.repository});

  Future<Either<Failure, CoinMarketChart>> call({
    required String id,
    required String days,
    required bool dailyInterval,
  }) async {
    return await repository.getRemoteCoinMarketChart(
      id: id,
      days: days,
      dailyInterval: dailyInterval,
    );
  }
}
