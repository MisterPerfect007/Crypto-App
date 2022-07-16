import 'package:bloc/bloc.dart';

import '../widgets/timeSlots/time_slots_parent.dart';

class TimeSlotCubit extends Cubit<String> {
  TimeSlotCubit() : super(timeSlotList[0]);

  void changeTimeSlot(String slot){
    emit(slot);
  }
  @override
  void onChange(Change<String> change) {
    super.onChange(change);
  }
}
