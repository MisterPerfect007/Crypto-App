import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginationCubit extends Cubit<int> {
  PaginationCubit() : super(1);

  void changePage(int page) {
    emit(page);
  }

  void prevPage() {
    if (state > 1) {
      emit(state - 1);
    }
  }

  void nextPage() {
    if (state < 100) {
      emit(state + 1);
    }
  }
}
