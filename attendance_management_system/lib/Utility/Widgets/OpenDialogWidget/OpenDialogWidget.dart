import 'package:attendance_management_system/Bloc/AttendanceBloc/attendance_bloc.dart';
import 'package:attendance_management_system/Model/AttendanceModel/AttendanceModel.dart';
import 'package:attendance_management_system/Model/SharedPreferences/GetCounts.dart';
import 'package:attendance_management_system/Model/SharedPreferences/SharedPreference.dart';
import 'package:attendance_management_system/Screens/ViewAttendance/ViewAttendance.dart';
import 'package:attendance_management_system/Utility/Widgets/BottomNavBar/UserNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OpenDailog extends StatefulWidget {
Function? callbackFunction;
   OpenDailog({Key? key, this.callbackFunction}) : super(key: key);

  @override
  State<OpenDailog> createState() => _OpenDailogState();
}

class _OpenDailogState extends State<OpenDailog> {
  var checkedValue=false;

  var checkedValueL=false;

  AttendanceBloc? bloc;

  String? status;

  bool newValue=true;

  String? userID;

  @override
  void initState() {
    // TODO: implement initState
    bloc=BlocProvider.of<AttendanceBloc>(context);
    SharedPreference.getString("userID").then((value) {
      setState(() {
        userID=value;
      });});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return AlertDialog(

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*.1/5)
        ),

        scrollable: true,
        content:SizedBox(
          height: MediaQuery.of(context).size.height*(0.53/1.6),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              child:  Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text("${DateFormat.yMMMMEEEEd().format(DateTime.now())}",style: TextStyle(color: Colors.black),),
                  ),
                  const Divider(
                    color: Colors.black26,
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*1/10,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(20),
                          ), //BoxDecoration

                          /** CheckboxListTile Widget **/
                          child: CheckboxListTile(
                            title: Text("Mark Attendance"),
                            value: checkedValue,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue = newValue!;
                                status="Present";
                              });
                            },
                          ), //CheckboxListTile
                        ), //Container
                      ), //Padding
                    ), //Center
                    //SizedBox




                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*1/10,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(20),
                          ), //BoxDecoration

                          /** CheckboxListTile Widget **/
                          child: CheckboxListTile(
                            title: Text("Leave Attendance"),
                            value: checkedValueL,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValueL = newValue!;
                                status="Leave";
                              });
                            },
                          ), //CheckboxListTile
                        ), //Container
                      ), //Padding
                    ), //Center
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.13/2,
                    margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                    child: ElevatedButton.icon(onPressed: (){
                      bloc!.add(AddAttendanceEvent(AttendanceRequestModel(
                        userID:userID,
                        date:DateFormat('dd/MM/yyyy').format(DateTime.now()),
                        status:status
                      )));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserNavBarWidget()));
                    }, icon: Icon(CupertinoIcons.arrow_down_doc), label: Text("Mark")),
                  ),
                ],
              )
          ),
        )
    );
  }
}