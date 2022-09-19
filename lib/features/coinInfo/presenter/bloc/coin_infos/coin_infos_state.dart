part of 'coin_infos_bloc.dart';

abstract class CoinInfosState extends Equatable {
  const CoinInfosState();
  
  @override
  List<Object> get props => [];
}

class CoinInfosInitial extends CoinInfosState {}

class CoinInfosLoading extends CoinInfosState {}

class CoinInfosLoaded extends CoinInfosState {
  final Coin coin;

  const CoinInfosLoaded(this.coin);

  @override
  List<Object> get props => [coin];
}

class CoinInfosFailure extends CoinInfosState {
  final ErrorType errorType;

  const CoinInfosFailure(this.errorType);

  @override
  List<Object> get props => [errorType];
}