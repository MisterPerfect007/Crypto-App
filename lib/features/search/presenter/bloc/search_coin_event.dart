part of 'search_coin_bloc.dart';

abstract class SearchCoinEvent extends Equatable {
  const SearchCoinEvent();

  @override
  List<Object> get props => [];
}

class GetSearchCoins extends SearchCoinEvent{
  final String query;
  final int requestTime;
  const GetSearchCoins(this.query, this.requestTime);

  @override
  List<Object> get props => [query, requestTime];
}