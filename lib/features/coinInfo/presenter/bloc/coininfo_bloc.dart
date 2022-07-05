import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/coin_market_chart.dart';
import '../../domain/usescases/get_coin_market_chart.dart';

part 'coininfo_event.dart';
part 'coininfo_state.dart';

class CoinInfoBloc extends Bloc<CoinInfoEvent, CoinInfoState> {
  final GetCoinMarketChart usecase;
  CoinInfoBloc({required this.usecase}) : super(CoinInfoInitial()) {
    on<CoinInfoEvent>((event, emit) async {
      if (event is GetCoinInfo) {
        emit(CoinInfoLoading());
        final leftOrRight = await usecase.call(
          id: event.id,
          currency: event.currency,
          days: event.days,
          dailyInterval: event.dailyInterval,
        );
        leftOrRight.fold(
          (l) => emit(CoinInfoError()),
          (chartData) => emit(CoinInfoLoaded(coinMarketChart: chartData)),
        );
      }
      //make call the usecase
      //if (right is return)
      //emit Loaded
      //else
      //emit Error
    });
  }
}
