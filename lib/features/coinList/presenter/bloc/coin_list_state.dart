part of 'coin_list_bloc.dart';

abstract class CoinListState extends Equatable {
  const CoinListState();
  
  @override
  List<Object> get props => [];
}

class CoinListInitial extends CoinListState {}

class CoinListLoading extends CoinListState {}

class CoinListLoaded extends CoinListState {
  final List<Coin> coinList;

  const CoinListLoaded(this.coinList);

  @override
  List<Object> get props => [coinList];
}

class CoinListFailure extends CoinListState{
  final String message;

  const CoinListFailure(this.message);

  @override
  List<Object> get props => [message];
}
