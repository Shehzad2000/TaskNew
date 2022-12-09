
import 'dart:async';

import 'package:attendance_management_system/Model/AttendanceModel/AttendanceModel.dart';
import 'package:attendance_management_system/Repo/AttendanceRepo.dart';
import 'package:bloc/bloc.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
 AttendanceRepo attendanceRepo=AttendanceRepo();
  AttendanceBloc(AttendanceInitialState attendanceInitialState) : super(AttendanceInitialState()) {
on<AddAttendanceEvent>(_onAddAttendance);
on<UpdateAttendanceEvent>(_onUpdateAttendance);
on<DeleteAttendanceEvent>(_onDeleteAttendance);
on<GetAttendanceEvent>(_onGetAttendance);
on<GetAllAttendanceByUserIDEvent>(_onGetAttendanceByUser);
on<GetAttendanceBySpecificDateEvent>(_onGetAttendanceBySpecificDateEvent);
on<GetAllAttendance>(_onGetAllAttendance);
  }

  FutureOr<void> _onAddAttendance(AddAttendanceEvent event, Emitter<AttendanceState> emit) async{
  int res=await attendanceRepo.addAttendance(event.requestModel);
  (res==200)?emit(AttendanceSuccessState()):emit(AttendanceErrorState());
  }

  FutureOr<void> _onUpdateAttendance(UpdateAttendanceEvent event, Emitter<AttendanceState> emit) async{
    int res=await attendanceRepo.updateAttendance(event.requestModel);
    (res==200)?emit(AttendanceSuccessState()):emit(AttendanceErrorState());
  }

  FutureOr<void> _onDeleteAttendance(DeleteAttendanceEvent event, Emitter<AttendanceState> emit) async{
  int res=await attendanceRepo.deleteAttendance(event.id);
  (res==200)?emit(AttendanceSuccessState()):emit(AttendanceErrorState());
  }

  FutureOr<void> _onGetAttendance(GetAttendanceEvent event, Emitter<AttendanceState> emit) async{
  AttendanceRequestModel? requestModel=await attendanceRepo.getAttendance(event.id);
  emit(AttendanceSuccessState(requestModel: requestModel));
  }


  FutureOr<void> _onGetAttendanceByUser(GetAllAttendanceByUserIDEvent event, Emitter<AttendanceState> emit) async{
  List<AttendanceRequestModel> list=await attendanceRepo.GetAllAttendanceByUserID(event.userID);
  emit(AttendanceShowDataState(list: list ));
  }

  FutureOr<void> _onGetAttendanceBySpecificDateEvent(GetAttendanceBySpecificDateEvent event, Emitter<AttendanceState> emit) async{
  List<AttendanceRequestModel>? list=await attendanceRepo.fetchReportOfUser(event.userID,event.fromDate,event.toDate);
  emit(AttendanceShowDataState(list: list));
  }

  FutureOr<void> _onGetAllAttendance(GetAllAttendance event, Emitter<AttendanceState> emit) async{
    List<AttendanceRequestModel>? list=await attendanceRepo.GetAllAttendance();
    emit(AttendanceShowDataState(list:list));
  }
}
