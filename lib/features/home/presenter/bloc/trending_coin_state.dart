part of 'trending_coin_bloc.dart';

abstract class TrendingCoinsState extends Equatable {
  const TrendingCoinsState();
  
  @override
  List<Object> get props => [];
}

class TrendingCoinsInitial extends TrendingCoinsState {}

class TrendingCoinsLoading extends TrendingCoinsState {}

class TrendingCoinsLoaded extends TrendingCoinsState {
  final List<Coin> coinList;

  const TrendingCoinsLoaded({required this.coinList});
  @override
  List<Object> get props => [coinList];
}

class TrendingCoinsFailure extends TrendingCoinsState {
  final ErrorType errorType;
  const TrendingCoinsFailure(this.errorType);

  @override
  List<Object> get props => [errorType];
}
