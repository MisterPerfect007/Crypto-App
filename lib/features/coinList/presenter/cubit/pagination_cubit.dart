import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginationCubit extends Cubit<int> {
  PaginationCubit() : super(1);

  void changePage(int page) {
    print("page");
    emit(page);
  }
}
