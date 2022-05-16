import 'package:bloc/bloc.dart';
import 'package:crypto_trends/errors/failures.dart';
import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_coin_list.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';

class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  final GetRemoteCoinList getRemoteCoinList;
  CoinListBloc({required this.getRemoteCoinList}) : super(CoinListInitial()) {
    on<CoinListEvent>((event, emit) async {
      if(event is GetCoinList){
        emit(CoinListLoading());
        final coinListOrFailure = await getRemoteCoinList(event.currency, event.page!);
        coinListOrFailure.fold(
          (failure) => null, 
          (coinList) => emit(CoinListLoaded(coinList))
        );
        //1) fecth coin list from getCoinList usecase
        /*
          * call to the usecase
          
            => emit [Loading] state
            * if success
              => emit [Loaded] state
            * else
              => emit [Error] state
         */
      }
    });
  }
}
