import 'package:crypto_trends/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class GetCoinMarketChartRepository {
  Future<Either<Failure, List<List>>> getRemoteCoinMarketChart({
    required String id,
    required String currency,
    required String days,
    required bool dailyInterval,
  });
}
