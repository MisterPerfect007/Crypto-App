part of 'search_coin_bloc.dart';

abstract class SearchCoinEvent extends Equatable {
  const SearchCoinEvent();

  @override
  List<Object> get props => [];
}

class GetSearchCoins extends SearchCoinEvent{
  final String query;
  const GetSearchCoins(this.query);

  @override
  List<Object> get props => [query];
}