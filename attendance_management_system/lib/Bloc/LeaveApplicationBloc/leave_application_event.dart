part of 'leave_application_bloc.dart';

@override
abstract class LeaveApplicationEvent {}
class SendLeaveApprovalEvent extends LeaveApplicationEvent{
  LeaveApplicationRequestModel leaveApplicationRequestModel;
  SendLeaveApprovalEvent(this.leaveApplicationRequestModel);
}
class UpdateLeaveApprovalEvent extends LeaveApplicationEvent{
  LeaveApplicationRequestModel leaveApplicationRequestModel;
  UpdateLeaveApprovalEvent(this.leaveApplicationRequestModel);
}
class GetLeaveApprovalEvent extends LeaveApplicationEvent{

}
class GetAllLeaveApprovalEventByUserID extends LeaveApplicationEvent{
  String? id;
  GetAllLeaveApprovalEventByUserID(this.id);
}
class GetAllLeaveApprovalEvent extends LeaveApplicationEvent{
  List<LeaveApplicationRequestModel> list;
  GetAllLeaveApprovalEvent(this.list);
}