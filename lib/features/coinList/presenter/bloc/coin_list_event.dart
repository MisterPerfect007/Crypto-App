part of 'coin_list_bloc.dart';

abstract class CoinListEvent extends Equatable {
  const CoinListEvent();

  @override
  List<Object> get props => [];
}

class CoinListGet extends CoinListEvent{
  final String currency;
  final int? page;

  const CoinListGet({required this.currency, this.page});

  @override
  List<Object> get props => [currency, page!];
}

class CoinListUpdate extends CoinListEvent{
  final String currency;
  final int? page;
  final Map<String, dynamic> sortingCriteria;

  const CoinListUpdate({required this.currency, this.page, required this.sortingCriteria});

  @override
  List<Object> get props => [currency, page!, sortingCriteria];
}

class CoinListSorting extends CoinListEvent{
  final List<Coin> coinList;
  final Map<String, dynamic> criteria;

  const CoinListSorting({required this.coinList, required this.criteria});

  @override
  List<Object> get props => [coinList, criteria];
}