import 'dart:async';

import 'package:attendance_management_system/Bloc/AttendanceBloc/attendance_bloc.dart';
import 'package:attendance_management_system/Model/UserModel/UserRequestModel.dart';
import 'package:attendance_management_system/Repo/UserRepo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepo userRepo=UserRepo();
  UserBloc(UserInitialState userInitialState) : super(UserInitialState()) {
    on<RegisterUserEvent>(_onRegisterUser);
    on<GetUserEvent>(_onGetUserDetail);
    on<UpdateUserEvent>(_onUserUpdate);
    on<GetUsersEvent>(_onGetUsersDetail);
    on<UserSignInEvent>(_onUserSignIn);
  }

  FutureOr<void> _onRegisterUser(RegisterUserEvent event, Emitter<UserState> emit) async{
    int res=await userRepo.signUp(event.userRequestModel);
    (res==200)?emit(UserSuccessState()):emit(UserErrorState());
  }

  FutureOr<void> _onGetUserDetail(GetUserEvent event, Emitter<UserState> emit) async{
    UserRequestModel? requestModel=await userRepo.getUserDetail(event.id);
    emit(UserShowDataState(requestModel: requestModel));
  }

  FutureOr<void> _onUserSignIn(UserSignInEvent event, Emitter<UserState> emit) async{
    int res=await userRepo.signIn(event.userRequestModel);
    (res==200)?emit(UserSuccessState()):emit(UserErrorState());
  }

  FutureOr<void> _onGetUsersDetail(GetUsersEvent event, Emitter<UserState> emit) async{
    List<UserRequestModel>? list=await userRepo.getAllUserDetails();
    emit(UserShowDataState(list: list));
  }

  FutureOr<void> _onUserUpdate(UpdateUserEvent event, Emitter<UserState> emit) async{
    int res=await userRepo.updateUserDetail(event.userRequestModel!);
    (res==200)?emit(UserSuccessState()):emit(UserErrorState());
  }
}
