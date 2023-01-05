import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';
import 'package:crypto_trends/features/coinList/presenter/utils/utils_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/utils/give_error_type.dart';
import '../../../../errors/error_types.dart';
import '../../domain/usecases/get_coin_list.dart';
import '../../getx-controller/coin_list_controller.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';

class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  final GetRemoteCoinList getRemoteCoinList;
  final NetworkInfo network;
  CoinListBloc({
    required this.getRemoteCoinList,
    required this.network,
  }) : super(CoinListInitial()) {
    final CoinListController coinListController = Get.put(CoinListController());
    on<CoinListEvent>(
      (event, emit) async {
        if (event is CoinListGet) {
          emit(CoinListLoading());
          final isConnected = await network.isConnected;
          if (isConnected) {
            final coinListOrFailure = await getRemoteCoinList(page: event.page);
            coinListOrFailure.fold(
                (failure) => emit(CoinListFailure(giveErrorType(failure))),
                (coinList) {
              coinListController.updateCoinList(coinList);
              emit(CoinListLoaded(
                coinList: sortCoinList(
                    coinList: coinList, criteria: event.sortingCriteria),
              ));
            });
          } else {
            emit(const CoinListFailure(ErrorType.noInternetConnection));
          }
        }
        //! on CoinListUpdate
        if (event is CoinListUpdate) {
          final coinListOrFailure = await getRemoteCoinList(page: event.page);
          coinListOrFailure.fold((_) {}, (coinList) {
            coinListController.updateCoinList(coinList);
            emit(CoinListLoaded(
                coinList: sortCoinList(
                    coinList: coinList, criteria: event.sortingCriteria),
                isUpdate: true));
          });
        }

        //! on CoinListSorting
        if (event is CoinListSorting) {
          emit(CoinListLoaded(
              coinList: sortCoinList(
                  coinList: event.coinList, criteria: event.criteria)));
        }
      },
      transformer: restartable(),
    );
  }
}
