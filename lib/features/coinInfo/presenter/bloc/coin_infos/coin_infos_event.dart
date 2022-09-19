part of 'coin_infos_bloc.dart';

abstract class CoinInfosEvent extends Equatable {
  const CoinInfosEvent();

  @override
  List<Object> get props => [];
}

class CoinInfosGet extends CoinInfosEvent{
  final String coinId;
  final String currency;

  const CoinInfosGet({required this.coinId, required this.currency});

  @override
  List<Object> get props => [coinId];
}
