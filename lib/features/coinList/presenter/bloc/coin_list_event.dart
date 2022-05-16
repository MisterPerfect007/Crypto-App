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