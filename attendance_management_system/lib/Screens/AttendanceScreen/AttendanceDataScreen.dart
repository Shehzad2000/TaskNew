import 'dart:async';

import 'package:attendance_management_system/Bloc/AttendanceBloc/attendance_bloc.dart';
import 'package:attendance_management_system/Bloc/UserBloc/user_bloc.dart';
import 'package:attendance_management_system/Model/AttendanceModel/AttendanceModel.dart';
import 'package:attendance_management_system/Model/SharedPreferences/GetCounts.dart';
import 'package:attendance_management_system/Model/UserModel/UserRequestModel.dart';
import 'package:attendance_management_system/Screens/AttendanceScreen/AttendanceScreen.dart';
import 'package:attendance_management_system/Screens/UserScreen/UserRegisterationScreen.dart';
import 'package:attendance_management_system/Utility/Widgets/AttendanceListWidget/AttendanceList.dart';
import 'package:attendance_management_system/Utility/Widgets/IconButtonWidget/IconButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../Utility/Constraints/TextConstraint/TextConstraint.dart';
import '../../Utility/Widgets/AppBarWidget/AppBarWidget.dart';

class AttendanceDataScreen extends StatefulWidget {
  String? userID;
  AttendanceDataScreen({Key? key,this.userID}) : super(key: key);

  @override
  State<AttendanceDataScreen> createState() => _AttendanceDataScreenState();
}

class _AttendanceDataScreenState extends State<AttendanceDataScreen> {
  AttendanceBloc? bloc;
  @override
  void initState() {
    bloc=BlocProvider.of<AttendanceBloc>(context);
    bloc!.add(GetAllAttendanceByUserIDEvent(userID:widget.userID));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.1/1.3),
          child:const AppBarWidget()),
      body:SingleChildScrollView(
        child: Column(
          children: [
          Row(
            children: [
              Row(
                children: [
                  Container(
                  alignment: Alignment.topLeft,
                  margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/4,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                  child: text("Total Entries:",FontWeight.normal,18.0,Colors.black38),
        ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/10,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                    child: text("( ${GetCounts.TotalEntries} )",FontWeight.normal,18.0,Colors.blue),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.3/4,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                    child: text("Absent:",FontWeight.normal,18.0,Colors.redAccent),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/8,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                    child: text("( ${GetCounts.AbsentCount} )",FontWeight.normal,18.0,Colors.blue),
                  ),
                ],
              ),

            ],
          ),
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/1.4,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                      child: text("Present:",FontWeight.normal,18.0,Colors.green),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/8,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                      child: text("( ${GetCounts.PresentCount} )",FontWeight.normal,18.0,Colors.blue),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.3/4,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                      child: text("Leave:",FontWeight.normal,18.0,Colors.orangeAccent),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/4,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                      child: text("( ${GetCounts.LeaveCount} )",FontWeight.normal,18.0,Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              alignment: Alignment.topCenter,
              margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/4,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
              child: Center(child: text("Here you got Attendance list:-",FontWeight.normal,18.0,Colors.black38)),
            ),
            Divider(
              indent:20,
              endIndent: 20,
              thickness: 2,
              height: MediaQuery.of(context).size.height*0.1/10,
              color: Colors.orangeAccent,
            ),
          AttendanceList(userID: widget.userID,)
          ],
        ),
      ),


      //    bottomNavigationBar:Theme(data: Theme.of(context).copyWith(iconTheme:const IconThemeData(color: Colors.white)),child:navbar2()),

    );
  }

}
