part of 'favorite_list_bloc.dart';

abstract class FavoriteListState extends Equatable {
  const FavoriteListState();

  @override
  List<Object> get props => [];
}

class FavoriteListInitial extends FavoriteListState {}

class FavoriteListLoading extends FavoriteListState {}

class FavoriteListLoaded extends FavoriteListState {
  final List<Coin> coinList;
  const FavoriteListLoaded(this.coinList);

  @override
  List<Object> get props => [coinList];
}

class FavoriteListFailed extends FavoriteListState {
  final ErrorType errorType;
  const FavoriteListFailed(this.errorType);
  
  @override
  List<Object> get props => [errorType];
}
