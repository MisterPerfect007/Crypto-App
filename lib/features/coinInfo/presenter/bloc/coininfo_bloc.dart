import 'package:bloc/bloc.dart';
import 'package:crypto_trends/core/utils/give_error_type.dart';
import 'package:crypto_trends/errors/error_types.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/entities/coin_market_chart.dart';
import '../../domain/usescases/get_coin_market_chart.dart';

part 'coininfo_event.dart';
part 'coininfo_state.dart';

class CoinInfoBloc extends Bloc<CoinInfoEvent, CoinInfoState> {
  final GetCoinMarketChart usecase;
  final NetworkInfo network;
  CoinInfoBloc({
    required this.usecase,
    required this.network,
  }) : super(CoinInfoInitial()) {
    on<CoinInfoEvent>((event, emit) async {
      emit(CoinInfoLoading());
      if (await network.isConnected) {
        if (event is GetCoinInfo) {
        final leftOrRight = await usecase.call(
          id: event.id,
          currency: event.currency,
          days: event.days,
          dailyInterval: event.dailyInterval,
        );
        leftOrRight.fold(
          (failure) => emit(CoinInfoFailure(giveErrorType(failure))),
          (chartData) => emit(CoinInfoLoaded(coinMarketChart: chartData)),
        );
      }
      } else {
         emit(const CoinInfoFailure(ErrorType.noInternetConnection));
      }
    });
  }
}
