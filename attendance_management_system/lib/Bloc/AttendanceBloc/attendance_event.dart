part of 'attendance_bloc.dart';

@override
abstract class AttendanceEvent {}
class AddAttendanceEvent extends AttendanceEvent{
  AttendanceRequestModel requestModel;
  AddAttendanceEvent(this.requestModel);
}
class UpdateAttendanceEvent extends AttendanceEvent{
  AttendanceRequestModel requestModel;
  UpdateAttendanceEvent(this.requestModel);
}
class DeleteAttendanceEvent extends AttendanceEvent{
  String? id;
  DeleteAttendanceEvent(this.id);
}
class GetAttendanceEvent extends AttendanceEvent{
  String? id;
  GetAttendanceEvent({this.id});
}
class GetAllAttendanceByUserIDEvent extends AttendanceEvent{
  String? userID;
  GetAllAttendanceByUserIDEvent({this.userID});
}
class GetAttendanceBySpecificDateEvent extends AttendanceEvent{
  String? userID,fromDate,toDate;
  GetAttendanceBySpecificDateEvent({this.userID,this.fromDate,this.toDate});
}
class GetAllAttendance extends AttendanceEvent{

}