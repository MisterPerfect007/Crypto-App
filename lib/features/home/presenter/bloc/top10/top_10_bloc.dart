import 'package:bloc/bloc.dart';
import 'package:crypto_trends/core/utils/give_error_type.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/network/network_info.dart';
import '../../../../../errors/error_types.dart';
import '../../../../coinList/domain/entities/coin.dart';
import '../../../../coinList/domain/usecases/get_coin_list.dart';

part 'top_10_event.dart';
part 'top_10_state.dart';

class Top10Bloc extends Bloc<Top10Event, Top10State> {
  final NetworkInfo networkInfo;
  final GetRemoteCoinList getCoinList;
  Top10Bloc({required this.networkInfo, required this.getCoinList})
      : super(Top10Initial()) {
    on<Top10Event>((event, emit) async {
      if (event is GetTop10Coins) {
        if (!(await networkInfo.isConnected)) {
          emit(const Top10Failure(ErrorType.noInternetConnection));
        } else {
          emit(Top10Loading());
          final coinListOrFailure = await getCoinList.call(
              currency: event.currency,
              page: event.page,
              perPage: event.perPage);
          coinListOrFailure.fold(
            (l) => null,
            (coinList) => emit(Top10Loaded(coinList: coinList)),
          );
        }
        //else
        //getCoinList
        //
      }
    });
  }
}
