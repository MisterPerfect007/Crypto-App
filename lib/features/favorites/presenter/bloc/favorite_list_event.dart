part of 'favorite_list_bloc.dart';

abstract class FavoriteListEvent extends Equatable {
  const FavoriteListEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteList extends FavoriteListEvent {
  final List<String> ids;
  const GetFavoriteList(this.ids);

  @override
  List<Object> get props => [ids];
}
