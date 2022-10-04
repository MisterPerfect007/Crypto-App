import 'package:crypto_trends/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/coin_market_chart.dart';

abstract class GetCoinMarketChartRepository {
  Future<Either<Failure, CoinMarketChart>> getRemoteCoinMarketChart({
    required String id,
    required String days,
    required bool dailyInterval,
  });
}
