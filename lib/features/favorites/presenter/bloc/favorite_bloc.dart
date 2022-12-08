import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit) {
      if (event is SetFavorite) {
        print("===============================");
        emit(FavoriteLoaded(event.ids));
      }
    });
  }
}
