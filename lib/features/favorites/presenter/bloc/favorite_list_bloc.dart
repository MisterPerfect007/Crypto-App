import 'package:bloc/bloc.dart';
import 'package:crypto_trends/errors/error_types.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/utils/give_error_type.dart';
import '../../../coinList/domain/entities/coin.dart';
import '../../../coinList/domain/usecases/get_coin_list.dart';

part 'favorite_list_event.dart';
part 'favorite_list_state.dart';

class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {
  final GetRemoteCoinList getRemoteCoinList;
  final NetworkInfo network;
  FavoriteListBloc({
    required this.getRemoteCoinList,
    required this.network,
  }) : super(FavoriteListInitial()) {
    on<FavoriteListEvent>((event, emit) async {
      if (event is GetFavoriteList) {
        emit(FavoriteListLoading());
        final isConnected = await network.isConnected;
        if (isConnected) {
          final coinListOrFailure = await getRemoteCoinList(ids: event.ids);
          coinListOrFailure.fold(
              (failure) => emit(FavoriteListFailed(giveErrorType(failure))),
              (coinList) {
            emit(FavoriteListLoaded(coinList));
          });
        } else {
          emit(const FavoriteListFailed(ErrorType.noInternetConnection));
        }
      }
    });
  }
}
