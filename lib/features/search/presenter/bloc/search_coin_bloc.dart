import 'package:bloc/bloc.dart';
import 'package:crypto_trends/errors/error_types.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/network/network_info.dart';
import '../../../coinList/domain/usecases/get_coin_list.dart';
import '../../domain/entity/search_coin.dart';
import '../../domain/usecases/get_search_coin.dart';

part 'search_coin_event.dart';
part 'search_coin_state.dart';

class SearchCoinBloc extends Bloc<SearchCoinEvent, SearchCoinState> {
  final GetSearchCoin getSearchCoin;
  final NetworkInfo network;
  SearchCoinBloc({
    required this.getSearchCoin,
    required this.network,
  }) : super(SearchCoinInitial()) {
    on<SearchCoinEvent>((event, emit) async {
      if (event is GetSearchCoins) {
        print(event.query);
        emit(SearchCoinLoading());
        final isConnected = await network.isConnected;
        if(!isConnected){
          emit(const SearchCoinFailure(ErrorType.noInternetConnection));
        } else{
          final coinsListOrFailure = await getSearchCoin(event.query);
          coinsListOrFailure.fold(
            (failure) => emit(const SearchCoinFailure(ErrorType.failedRequest)),
            (coinsList) => emit(SearchCoinLoaded(coinsList))
          );
        }
      }
    });
  }
}