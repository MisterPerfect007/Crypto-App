import 'package:bloc/bloc.dart';
import 'package:crypto_trends/core/network/network_info.dart';
import 'package:crypto_trends/core/utils/give_error_type.dart';
import 'package:crypto_trends/errors/error_types.dart';
import 'package:crypto_trends/features/coinList/domain/usecases/get_coin_list.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../coinList/domain/entities/coin.dart';
import '../../data/trending_coin_remote_data_source.dart';

part 'trending_coin_event.dart';
part 'trending_coin_state.dart';

class TrendingCoinsBloc extends Bloc<TrendingCoinsEvent, TrendingCoinsState> {
  final TrendingCoinRemoteDataSource trendingCoinSource;
  final NetworkInfo networkInfo;
  final GetRemoteCoinList getCoinList;
  TrendingCoinsBloc({
    required this.trendingCoinSource,
    required this.networkInfo,
    required this.getCoinList,
  }) : super(TrendingCoinsInitial()) {
    on<TrendingCoinsEvent>((event, emit) async {
      if (event is GetTrendingCoins) {
        if (!(await networkInfo.isConnected)) {
          emit(const TrendingCoinsFailure(ErrorType.noInternetConnection));
        } else {
          emit(TrendingCoinsLoading());
          final List<String> ids;
          try {
            ids = await trendingCoinSource.getTrendingCoinsIds();
            if (ids.isEmpty) {
              emit(const TrendingCoinsFailure(ErrorType.failedRequest));
            } else {
              final coinListOrFailure =
                  await getCoinList(currency: "usd", ids: ids);
              coinListOrFailure.fold(
                (failure) => emit(TrendingCoinsFailure(giveErrorType(failure))),
                (coinList) => emit(TrendingCoinsLoaded(coinList: coinList)),
              );
            }
          } catch (_) {
            emit(const TrendingCoinsFailure(ErrorType.failedRequest));
          }
        }
      }
    });
  }
}
