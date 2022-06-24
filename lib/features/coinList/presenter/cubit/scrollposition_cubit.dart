import 'package:bloc/bloc.dart';


class ScrollPositionCubit extends Cubit<double> {
  ScrollPositionCubit() : super(0.0);

  void onScroll(double newPosition){
    emit(newPosition);
  }
}
