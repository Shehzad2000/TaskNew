import 'package:attendance_management_system/Bloc/AttendanceBloc/attendance_bloc.dart';
import 'package:attendance_management_system/Repo/AttendanceRepo.dart';
import 'package:attendance_management_system/Utility/Constraints/ContainerConstraints/InkConstraint.dart';
import 'package:attendance_management_system/Utility/Constraints/Style/TextDecoration.dart';
import 'package:attendance_management_system/Utility/Widgets/AppBarWidget/AppBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../Model/AttendanceModel/AttendanceModel.dart';
import '../../Utility/Widgets/DropDownWidgets/AttentenceType.dart';
import '../../Utility/Widgets/DropDownWidgets/EmployeesDropDown.dart';
import '../../Utility/Widgets/DropDownWidgets/StatusDropdownWidget.dart';
import '../../Utility/Widgets/ListTileWidget/ListTileWidget.dart';
class AttendanceScreen extends StatefulWidget {
  AttendanceRequestModel? requestModel;
  AttendanceScreen({Key? key,this.requestModel}) : super(key: key);
  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  dynamic userID;
  dynamic attendanceID;
  dynamic status;
  AttendanceBloc? bloc;
  AttendanceRepo repo=AttendanceRepo();
  String? newVal;

  var userController=TextEditingController();
  @override
  void initState() {
    bloc=BlocProvider.of<AttendanceBloc>(context);
    if(widget.requestModel!=null){
      attendanceID=widget.requestModel!.attendanceID;
     userID=widget.requestModel!.userID;
     userController.text=widget.requestModel!.userName!;
     status=widget.requestModel!.status;
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return BlocListener<AttendanceBloc, AttendanceState>(
  listener: (context, state) {
    if (state is AttendanceSuccessState) {
      var snackBar =const  SnackBar (
        content:  Text(
          'Attendance has been Marked successfully',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(10, 10),
                topRight: Radius.elliptical(10, 10))),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar
        /*const SnackBar(content: Text('')),*/
      );
    } else if (state is AttendanceErrorState) {
      var snackBar =const SnackBar(
        content: Text(
          'Oops,Something went wrong',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(10, 10),
                topRight: Radius.elliptical(10, 10))),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    // TODO: implement listener
  },
  child: Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(height*.1/1.3),
          child:const AppBarWidget()),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top:height*0.2/5),
            height: height * 0.2,
            padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: MediaQuery.of(context).padding.left+2),
            child: ListTileWidget(title:"Welcome to the",subTitle: "AM-System",),
          ),
          Center(
            child: Form(
              child: Column(
                children: [
                  (widget.requestModel!=null)?updateEmployeeWidget(context, width, height):employeesWidget(context,width,height),
                  statusWidget(context,width,height),
                  markAttendanceButton(context,width,height)
                ],
              ),
            ),
          )
        ],
      ),
    ),
);
  }

  Widget employeesWidget(BuildContext context,var width,var height) {
    return Container(
      margin:EdgeInsets.only(top: height*0.3),
      width: width*0.95,
      child:EmployeesDD(callbackFunction: (newValue){
        setState(() {
          userID=newValue;
        });
      },)
    );
  }
  Widget updateEmployeeWidget(BuildContext context,var width,var height) {
    return Container(
        margin:EdgeInsets.only(top: height*0.3),
        width: width*0.95,
        child:TextFormField(
          controller: userController,
          readOnly: true,
        decoration: buildInputDecoration("", 1, false, false),
        )
    );
  }

  Widget statusWidget(BuildContext context,var width,var height) {
    return Container(
      margin: EdgeInsets.only(top: height*.1/7),
      width: width*.95,
      child: AttendanceDropDown(callbackFunction: (newVal) {
      status=newVal;
      },),
    );
  }

  Widget markAttendanceButton(BuildContext context,var width,var height) {
    return Container(
        margin: EdgeInsets.only(top: height*.1/7),

        child:RaisedButton(
          onPressed: (){
            (widget.requestModel==null)? bloc!.add(AddAttendanceEvent(AttendanceRequestModel(
                userID: userID,
                date: DateFormat.yMMMMEEEEd().format(DateTime.now()),
                status: status
            ))): bloc!.add(UpdateAttendanceEvent(AttendanceRequestModel(
                userID: userID,
                attendanceID: attendanceID,
                date: DateFormat.yMMMMEEEEd().format(DateTime.now()),
                status: status
            )));
          },
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(80.0)),
          padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/22),
          child: inKDecoration((widget.requestModel!=null)?"Update Attendance":"Mark Attendance"),
        )


    );
  }

}
