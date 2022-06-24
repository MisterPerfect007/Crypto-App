import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sorting_state.dart';

class SortingCubit extends Cubit<Map<String, dynamic>> {
  SortingCubit() : super({"by": 'rank', 'isUp': true});
  
  void changeSorting(Map<String, dynamic> critera){
    if(state["by"] == critera["by"]){
      emit({
        "by": critera["by"],
        "isUp": !critera["isUp"]
      });
    }
  }
}
