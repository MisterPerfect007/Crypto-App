part of 'coin_list_bloc.dart';

abstract class CoinListState extends Equatable {
  const CoinListState();
  
  @override
  List<Object> get props => [];
}

class CoinListInitial extends CoinListState {}

class CoinListLoading extends CoinListState {}

class CoinListLoaded extends CoinListState {
  final bool? isUpdate;
  final List<Coin> coinList;

  const CoinListLoaded({ required this.coinList, this.isUpdate = false});

  @override
  List<Object> get props => [coinList, isUpdate!];
}

class CoinListFailure extends CoinListState{
  final ErrorType errorType;

  const CoinListFailure(this.errorType);

  @override
  List<Object> get props => [errorType];
}

//* Coin List update

class CoinListUpdateInitial extends CoinListState {}

class CoinListUpdateLoading extends CoinListState {}

class CoinListUpdateLoaded extends CoinListState {
  final List<Coin> coinList;

  const CoinListUpdateLoaded(this.coinList);

  @override
  List<Object> get props => [coinList];
}

class CoinListUpdateFailure extends CoinListState{
  final String message;

  const CoinListUpdateFailure(this.message);

  @override
  List<Object> get props => [message];
}
