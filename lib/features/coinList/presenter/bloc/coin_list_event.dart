part of 'coin_list_bloc.dart';

abstract class CoinListEvent extends Equatable {
  const CoinListEvent();

  @override
  List<Object> get props => [];
}

class CoinListGet extends CoinListEvent{
  final int? page;
  final Map<String, dynamic> sortingCriteria;

  const CoinListGet({this.page , required this.sortingCriteria});

  @override
  List<Object> get props => [page!, sortingCriteria];
}

class CoinListUpdate extends CoinListEvent{
  final int? page;
  final Map<String, dynamic> sortingCriteria;

  const CoinListUpdate({this.page, required this.sortingCriteria});

  @override
  List<Object> get props => [page!, sortingCriteria];
}

class CoinListSorting extends CoinListEvent{
  final List<Coin> coinList;
  final Map<String, dynamic> criteria;

  const CoinListSorting({required this.coinList, required this.criteria});

  @override
  List<Object> get props => [coinList, criteria];
}