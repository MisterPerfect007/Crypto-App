part of 'coin_list_bloc.dart';

abstract class CoinListEvent extends Equatable {
  const CoinListEvent();

  @override
  List<Object> get props => [];
}

class GetCoinList extends CoinListEvent{
  final String currency;
  final int? page;

  const GetCoinList({required this.currency, this.page});

  @override
  List<Object> get props => [currency, page!];
}

class UpdateCoinList extends CoinListEvent{
  final List<Coin> coinList;

  const UpdateCoinList({required this.coinList});

  @override
  List<Object> get props => [coinList];
}