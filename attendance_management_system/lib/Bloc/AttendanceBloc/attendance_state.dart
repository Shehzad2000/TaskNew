part of 'attendance_bloc.dart';

@override
abstract class AttendanceState {}

class AttendanceInitialState extends AttendanceState {}
class AttendanceLoadingState extends AttendanceState{}
class AttendanceSuccessState extends AttendanceState{
  AttendanceRequestModel? requestModel;
  AttendanceSuccessState({this.requestModel});
}
class AttendanceShowDataState extends AttendanceState{
  AttendanceRequestModel? requestModel;
  List<AttendanceRequestModel>? list;
  AttendanceShowDataState({this.list,this.requestModel});
}
class AttendanceErrorState extends AttendanceState{}
