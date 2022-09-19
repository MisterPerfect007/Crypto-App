import 'package:bloc/bloc.dart';
import 'package:crypto_trends/errors/error_types.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/network/network_info.dart';
import '../../../../../core/utils/give_error_type.dart';
import '../../../../coinList/domain/entities/coin.dart';
import '../../../../coinList/domain/usecases/get_coin_list.dart';

part 'coin_infos_event.dart';
part 'coin_infos_state.dart';

class CoinInfosBloc extends Bloc<CoinInfosEvent, CoinInfosState> {
  final GetRemoteCoinList getRemoteCoinList;
  final NetworkInfo network;
  CoinInfosBloc({
    required this.getRemoteCoinList,
    required this.network,
  }) : super(CoinInfosInitial()) {
    on<CoinInfosEvent>((event, emit) async {
      if (event is CoinInfosGet){
        emit(CoinInfosLoading());
        final isConnected = await network.isConnected;
        if (isConnected) {
          final coinListOrFailure = await getRemoteCoinList(
              currency: event.currency, ids: [event.coinId]);
          coinListOrFailure.fold(
            (failure) => emit(CoinInfosFailure(giveErrorType(failure))), 
            (coinList) { 
              if(coinList.isNotEmpty) {
                emit(CoinInfosLoaded(coinList.first));
              } else{
                const CoinInfosFailure(ErrorType.failedRequest);
              }
              },
            );
        } else{
          emit(const CoinInfosFailure(ErrorType.noInternetConnection));
        }
      }
    });
  }
}
