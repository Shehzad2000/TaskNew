part of 'user_bloc.dart';

@override
abstract class UserState {}

class UserInitialState extends UserState {}
class UserLoadingState extends UserState {}
class UserSuccessState extends UserState {
UserRequestModel? requestModel;
UserSuccessState({this.requestModel});
}
class UserShowDataState extends UserState {
  List<UserRequestModel>? list;
  UserRequestModel? requestModel;
  UserShowDataState({this.list, this.requestModel});
}
class UserErrorState extends UserState {}
