import 'dart:async';

import 'package:attendance_management_system/Model/LeaveApplicationModel/LeaveApplicationRequestModel.dart';
import 'package:attendance_management_system/Repo/LeaveApplicationRepo.dart';
import 'package:bloc/bloc.dart';


part 'leave_application_event.dart';
part 'leave_application_state.dart';

class LeaveApplicationBloc extends Bloc<LeaveApplicationEvent, LeaveApplicationState> {
  LeaveApplicationRepo LeaveRepo=LeaveApplicationRepo();
  LeaveApplicationBloc(LeaveApplicationInitialState leaveApplicationInitialState) : super(LeaveApplicationInitialState()) {
  on<SendLeaveApprovalEvent>(_onSendLeaveApproval);
  on<UpdateLeaveApprovalEvent>(_onUpdateLeaveApproval);
  on<GetAllLeaveApprovalEvent>(_onGetAllLeaveApproval);
  on<GetAllLeaveApprovalEventByUserID>(_onGetAllLeaveApprovalByID);
  }

  FutureOr<void> _onSendLeaveApproval(SendLeaveApprovalEvent event, Emitter<LeaveApplicationState> emit) async{
    int res=await LeaveRepo.sendLeaveApplication(event.leaveApplicationRequestModel);
    (res==200)?emit(LeaveApplicationSuccessState()):emit(LeaveApplicationErrorState());
  }

  FutureOr<void> _onUpdateLeaveApproval(UpdateLeaveApprovalEvent event, Emitter<LeaveApplicationState> emit) async{
  int res=await LeaveRepo.updateLeaveApplication(event.leaveApplicationRequestModel);
  (res==200)?emit(LeaveApplicationSuccessState()):emit(LeaveApplicationErrorState());
  }

  FutureOr<void> _onGetAllLeaveApproval(GetAllLeaveApprovalEvent event, Emitter<LeaveApplicationState> emit) async{
  List<LeaveApplicationRequestModel> list=await LeaveRepo.getAllLeaveApplication();
  emit(LeaveApplicationShowDataState(list));
  }


  FutureOr<void> _onGetAllLeaveApprovalByID(GetAllLeaveApprovalEventByUserID event, Emitter<LeaveApplicationState> emit) async{
 List<LeaveApplicationRequestModel> list=await LeaveRepo.getAllLeaveApprovalEventByUserID(event.id);
 emit(LeaveApplicationShowDataState(list));
  }
}
