part of 'coininfo_bloc.dart';

abstract class CoinInfoState extends Equatable {
  const CoinInfoState();
  
  @override
  List<Object> get props => [];
}

class CoinInfoInitial extends CoinInfoState {}

class CoinInfoLoading extends CoinInfoState {}

class CoinInfoLoaded extends CoinInfoState {
  final CoinMarketChart coinMarketChart;

  const CoinInfoLoaded({required this.coinMarketChart});

  @override
  List<Object> get props => [coinMarketChart];
}

class CoinInfoFailure extends CoinInfoState {
  final ErrorType errorType;

  const CoinInfoFailure(this.errorType);

  @override
  List<Object> get props => [errorType];
}
