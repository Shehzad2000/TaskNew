import 'package:attendance_management_system/Bloc/AttendanceBloc/attendance_bloc.dart';
import 'package:attendance_management_system/Bloc/LeaveApplicationBloc/leave_application_bloc.dart';
import 'package:attendance_management_system/Bloc/UserBloc/user_bloc.dart';
import 'package:attendance_management_system/Screens/LeaveApplicationScreen/LeaveApplicationScreen.dart';
import 'package:attendance_management_system/Screens/UserScreen/UserLoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screens/AdminAprovalScreen/ApprovalScreen.dart';
import 'Screens/AttendanceScreen/AttendanceDataScreen.dart';
import 'Screens/AttendanceScreen/AttendanceScreen.dart';
import 'Screens/LeaveApplicationScreen/GetLeaveApplicationScreen.dart';
import 'Screens/Profile/StudentProfile/StudentEditprofile.dart';
import 'Screens/Profile/StudentProfile/StudentProfile.dart';
import 'Screens/FetchUsersScreen/UserDataScreen.dart';
import 'Screens/ReportScreen/MainReportScreen.dart';
import 'Screens/ReportScreen/ReportScreen.dart';
import 'Screens/UserScreen/UserRegisterationScreen.dart';
import 'Screens/ViewAttendance/ViewAttendance.dart';
import 'Utility/Widgets/BottomNavBar/BottomNavBarWidget.dart';
import 'Utility/Widgets/BottomNavBar/UserNavBar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:[
      BlocProvider<UserBloc>(
          create:(BuildContext context)=>UserBloc(UserInitialState())
      ),
      BlocProvider<LeaveApplicationBloc>(
          create:(BuildContext context)=>LeaveApplicationBloc(LeaveApplicationInitialState())
      ),
      BlocProvider<AttendanceBloc>(
          create:(BuildContext context)=>AttendanceBloc(AttendanceInitialState())
      ),
    ] , child:MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  UserDataScreen(),
    ));
  }
}

