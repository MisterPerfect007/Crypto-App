part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class SetFavorite extends FavoriteEvent{
  final List<String> ids;

  const SetFavorite(this.ids);

  @override
  List<Object> get props => [ids];
}