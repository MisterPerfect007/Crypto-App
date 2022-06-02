import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/coin_market_chart.dart';
import '../../domain/usescases/get_coin_market_chart.dart';

part 'coininfo_event.dart';
part 'coininfo_state.dart';

class CoinInfoBloc extends Bloc<CoinInfoEvent, CoinInfoState> {
  final GetCoinMarketChart usecase;
  CoinInfoBloc({required this.usecase}) : super(CoinInfoInitial()) {
    on<CoinInfoEvent>((event, emit) {
      if(event is GetCoinInfo){
        emit(CoinInfoLoading());
      }
      // TODO: implement event handler
      //make call the usecase
        //if (right is return)
          //emit Loaded
        //else
          //emit Error
    });
  }
}
