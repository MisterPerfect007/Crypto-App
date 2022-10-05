import 'package:crypto_trends/errors/failures.dart';
import 'package:crypto_trends/features/coinInfo/domain/repository/get_coin_market_chart_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../errors/exceptions.dart';
import '../../domain/entities/coin_market_chart.dart';
import '../datasources/coin_market_chart_remote_data_source.dart';

class GetCoinMarketChartRepositoryImpl implements GetCoinMarketChartRepository {
  final CoinMarketChartRemoteDataSourceImpl remote;

  GetCoinMarketChartRepositoryImpl({required this.remote});

  @override
  Future<Either<Failure, CoinMarketChart>> getRemoteCoinMarketChart({
    required String id,
    required String days,
    required bool dailyInterval,
  }) async {
    try {
      final result = await remote.getRemote(
        id: id,
        days: days,
        dailyInterval: dailyInterval,
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on NoConnectionException {
      return Left(NoConnectionFailure());
    }
  }
}
