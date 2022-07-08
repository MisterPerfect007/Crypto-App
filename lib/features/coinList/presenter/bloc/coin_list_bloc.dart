import 'package:bloc/bloc.dart';
import 'package:crypto_trends/errors/errors_message.dart';
import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';
import 'package:crypto_trends/features/coinList/presenter/utils/utils_functions.dart';
import 'package:crypto_trends/features/coinList/presenter/widgets/sorting%20criteria/sorting_criteria.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/network/network_info.dart';
import '../../../../errors/error_types.dart';
import '../../domain/usecases/get_coin_list.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';

class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  final GetRemoteCoinList getRemoteCoinList;
  final NetworkInfoImpl network;
  CoinListBloc({
    required this.getRemoteCoinList,
    required this.network,
  }) : super(CoinListInitial()) {
    on<CoinListEvent>((event, emit) async {
      if (event is CoinListGet) {
        emit(CoinListLoading());
        final isConnected = await network.isConnected;
        if (isConnected) {
          final coinListOrFailure =
              await getRemoteCoinList(event.currency, event.page);
          coinListOrFailure.fold(
              (failure) => emit(const CoinListFailure(ErrorType.failedRequest)),
              (coinList) => emit(CoinListLoaded(
                    coinList: sortCoinList(
                    coinList: coinList, criteria: event.sortingCriteria),
                  )));
        } else {
          emit(const CoinListFailure(ErrorType.noInternetConnection));
        }
      }
      //! on CoinListUpdate
      if (event is CoinListUpdate) {
        final coinListOrFailure =
            await getRemoteCoinList(event.currency, event.page);
        coinListOrFailure.fold(
            (failure) => emit(const CoinListUpdateFailure(serverErrorMessage)),
            (coinList) => emit(CoinListLoaded(
                coinList: sortCoinList(
                    coinList: coinList, criteria: event.sortingCriteria),
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
