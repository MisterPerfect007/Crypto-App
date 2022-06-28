import 'package:bloc/bloc.dart';
import 'package:crypto_trends/errors/errors_message.dart';
import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/usecases/get_coin_list.dart';
import '../cubit/sorting_cubit.dart';
import '../widgets/sorting criteria/criteria_list.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';

class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  final GetRemoteCoinList getRemoteCoinList;
  CoinListBloc({required this.getRemoteCoinList}) : super(CoinListInitial()) {
    on<CoinListEvent>((event, emit) async {
      if (event is CoinListGet) {
        emit(CoinListLoading());
        final coinListOrFailure =
            await getRemoteCoinList(event.currency, event.page!);
        coinListOrFailure.fold(
            (failure) => emit(const CoinListFailure(serverErrorMessage)),
            (coinList) => emit(CoinListLoaded(
                  coinList: coinList,
                )));
      }
      //! on CoinListUpdate
      if (event is CoinListUpdate) {
        final coinListOrFailure =
            await getRemoteCoinList(event.currency, event.page!);
        coinListOrFailure.fold(
            (failure) => emit(const CoinListUpdateFailure(serverErrorMessage)),
            (coinList) =>
                emit(CoinListLoaded(coinList: coinList, isUpdate: true)));
      }

      //! on CoinListSorting
      if (event is CoinListSorting) {
        List<Coin> coinList = List<Coin>.from(event.coinListState);
        //*Rank
        // if (mapEquals(event.criteria, rankDesc)) {
        //   coinList.sort((a, b) => a.marketCapRank!.compareTo(b.marketCapRank!));
        // }
        // if (mapEquals(event.criteria, rankAsc)){
        //   coinList.sort((a, b) => a.marketCapRank!.compareTo(b.marketCapRank!));
        //   coinList = coinList.reversed.toList();
        // }
        // //*Price
        // if (mapEquals(event.criteria, priceDesc)) {
        //   coinList.sort((a, b) => a.marketCapRank!.compareTo(b.marketCapRank!));
        //   if(event.criteria["desc"]){
            
        //   }
        // }
        // if (mapEquals(event.criteria, priceAsc)){
        //   coinList.sort((a, b) => a.marketCapRank!.compareTo(b.marketCapRank!));
        // }
        switch (event.criteria["by"]) {
          case "Rank":
            coinList.sort((a, b) => b.marketCapRank!.compareTo(a.marketCapRank!));
            break;
          case "Price":
            coinList.sort((a, b) => a.currentPrice!.compareTo(b.currentPrice!));
            break;
          case "% 24h":
            coinList.sort((a, b) => a.priceChangePercentage24h!.compareTo(b.priceChangePercentage24h!));
            break;
          default:
        }
        if(event.criteria["desc"]){
          coinList = coinList.reversed.toList();
        }
        emit(CoinListLoaded(coinList: coinList));
      }
    });
  }
}
