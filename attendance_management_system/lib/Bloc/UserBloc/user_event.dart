part of 'user_bloc.dart';

@override
abstract class UserEvent {}
class RegisterUserEvent extends UserEvent{
  UserRequestModel userRequestModel;
  RegisterUserEvent(this.userRequestModel);
}
class UpdateUserEvent extends UserEvent{
UserRequestModel? userRequestModel;
UpdateUserEvent(this.userRequestModel);
}
class DeleteUserEvent extends UserEvent{
  String? userID;
  DeleteUserEvent({this.userID});
}
class GetUserEvent extends UserEvent{
  String id;
  GetUserEvent(this.id);
}
class GetUsersEvent extends UserEvent{
  List<UserRequestModel>? list;
  GetUsersEvent({this.list});
}
class UserSignInEvent extends UserEvent{
  UserRequestModel userRequestModel;
  UserSignInEvent(this.userRequestModel);
}