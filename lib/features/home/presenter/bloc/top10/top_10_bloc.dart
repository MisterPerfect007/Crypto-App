import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'top_10_event.dart';
part 'top_10_state.dart';

class Top_10Bloc extends Bloc<Top_10Event, Top_10State> {
  Top_10Bloc() : super(Top_10Initial()) {
    on<Top_10Event>((event, emit) {
      // TODO: implement event handler
    });
  }
}
