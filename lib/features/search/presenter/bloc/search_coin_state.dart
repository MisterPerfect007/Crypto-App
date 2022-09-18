part of 'search_coin_bloc.dart';

abstract class SearchCoinState extends Equatable {
  const SearchCoinState();

  @override
  List<Object> get props => [];
}

class SearchCoinInitial extends SearchCoinState {}

class SearchCoinLoading extends SearchCoinState {}

class SearchCoinFailure extends SearchCoinState {
  final ErrorType errorType;

  const SearchCoinFailure(this.errorType);
}

class SearchCoinLoaded extends SearchCoinState {
  final List<SearchCoin> coinsList;
  final int requestTime;
  final String query;

  const SearchCoinLoaded({required this.coinsList, required this.requestTime, required this.query});

  @override
  List<Object> get props => [coinsList, requestTime, query];
}
