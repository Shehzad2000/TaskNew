part of 'leave_application_bloc.dart';

@override
abstract class LeaveApplicationState {}

class LeaveApplicationInitialState extends LeaveApplicationState {}
class LeaveApplicationLoadingState extends LeaveApplicationState{}
class LeaveApplicationSuccessState extends LeaveApplicationState{
  LeaveApplicationRequestModel? leaveApplicationRequestModel;
  LeaveApplicationSuccessState({this.leaveApplicationRequestModel});
}
class LeaveApplicationShowDataState extends LeaveApplicationState{
  List<LeaveApplicationRequestModel>? list;
  LeaveApplicationShowDataState(this.list);
}
class LeaveApplicationErrorState extends LeaveApplicationState{}