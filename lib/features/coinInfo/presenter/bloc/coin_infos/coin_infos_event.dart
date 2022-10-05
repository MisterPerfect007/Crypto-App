part of 'coin_infos_bloc.dart';

abstract class CoinInfosEvent extends Equatable {
  const CoinInfosEvent();

  @override
  List<Object> get props => [];
}

class CoinInfosGet extends CoinInfosEvent{
  final String coinId;

  const CoinInfosGet({required this.coinId});

  @override
  List<Object> get props => [coinId];
}
