import 'package:bloc/bloc.dart';
import 'package:crypto_trends/errors/errors_message.dart';
import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';
import 'package:crypto_trends/features/coinList/presenter/utils/utils_functions.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_coin_list.dart';

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
            (coinList) => emit(CoinListLoaded(
                coinList:
                    sortCoinList(coinList: coinList, criteria: event.criteria),
                isUpdate: true)));
      }

      //! on CoinListSorting
      if (event is CoinListSorting) {
        emit(CoinListLoaded(
            coinList: sortCoinList(
                coinList: event.coinList, criteria: event.criteria)));
      }
    });
  }
}
