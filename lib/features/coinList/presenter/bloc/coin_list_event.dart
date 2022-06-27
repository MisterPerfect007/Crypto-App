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

  const CoinListUpdate({required this.currency, this.page});

  @override
  List<Object> get props => [currency, page!];
}

class CoinListSorting extends CoinListEvent{
  final Map<String, dynamic> criteria;

  const CoinListSorting({required this.criteria});

  @override
  List<Object> get props => [criteria];
}