import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scrollposition_state.dart';

class ScrollPositionCubit extends Cubit<double> {
  ScrollPositionCubit() : super(0.0);

  void onScroll(double newPosition){
    emit(newPosition);
  }
}
