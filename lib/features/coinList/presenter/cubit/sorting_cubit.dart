import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SortingCubit extends Cubit<Map<String, dynamic>> {
  SortingCubit() : super({"by": 'Rank', 'desc': true});
  
  void changeSorting(Map<String, dynamic> critera){
    if(state["by"] == critera["by"]){
      emit({
        "by": critera["by"],
        "desc": !(critera["desc"] as bool)
      });
    }
    else {
      emit({
        "by": critera["by"],
        "desc": true
      });
    }
  }
}
