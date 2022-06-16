import 'package:bloc/bloc.dart';
import 'package:crypto_trends/errors/errors_message.dart';
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
          (failure) => emit(const CoinListFailure(serverErrorMessage)), 
          (coinList) => emit(CoinListLoaded(coinList))
        );
      }
      else if (event is UpdateCoinList){
        
        final newList = List<Coin>.from(event.coinList) ;
        newList[0] = Coin(
          id: newList[0].id, 
          symbol: newList[0].symbol, 
          name: newList[0].name,
          sparklineIn7d: newList[0].sparklineIn7d,
          currentPrice: 1838383
          );
        print(newList[0]);
        emit(CoinListLoaded(newList));
      }
    });
  }
}
