import 'package:attendance_management_system/Model/AttendanceModel/AttendanceModel.dart';
import 'package:attendance_management_system/Model/SharedPreferences/GetCounts.dart';
import 'package:attendance_management_system/Model/SharedPreferences/SharedPreference.dart';
import 'package:attendance_management_system/Repo/AttendanceRepo.dart';
import 'package:attendance_management_system/Screens/AttendanceScreen/AttendanceScreen.dart';
import 'package:attendance_management_system/Utility/Widgets/AppBarWidget/AppBarWidget.dart';
import 'package:attendance_management_system/Utility/Widgets/Drawer/Drawer.dart';
import 'package:attendance_management_system/Utility/Widgets/OpenDialogWidget/OpenDialogWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../Bloc/AttendanceBloc/attendance_bloc.dart';
import '../../Utility/Constraints/TextConstraint/TextConstraint.dart';
class ViewAttendance extends StatefulWidget {
  const ViewAttendance({Key? key}) : super(key: key);

  @override
  State<ViewAttendance> createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
 AttendanceBloc? attendanceBloc;

  bool checkedValue=false;

AttendanceRepo repo=AttendanceRepo();

  final cron=Cron();

  ScheduledTask? checkScheduleTask;

var userID;

Future<String?> callSharedPreferences() async {
      return await SharedPreference.getString("userID");
}
 @override
  void initState() {
    // TODO: implement initState
   repo.checkData();
   attendanceBloc=BlocProvider.of<AttendanceBloc>(context);
   SharedPreference.getString("userID").then((value) {
     setState(() {
       userID=value;
       GetCounts.uID=userID;
     });
   } );

   attendanceBloc!.add(GetAllAttendanceByUserIDEvent(userID:userID));

  }
 @override
  Widget build(BuildContext context) {
    var Height=MediaQuery.of(context).size.height;
    var Width=MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            (SharedPreference.check==true)?ShowDialog():null;
          },
          child:const Icon(Icons.add),
        ),
        drawer: MyHomePage(),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Height*.1/1.3),
            child:const AppBarWidget()),
        body:SingleChildScrollView(
       child: Column(

         children: [
           BlocBuilder<AttendanceBloc, AttendanceState>(
  builder: (context, state) {
    if(state is AttendanceLoadingState)
      {
        return CircularProgressIndicator();
      }else if(state is AttendanceShowDataState){
      return SizedBox(
        height: Height,
        width: Width,
        child: ListView.builder(
          itemCount:state.list!.length ,
          itemBuilder: (BuildContext context,int index)=>
              Container(
                  margin: EdgeInsets.only(top: Height*.1/4,left: Width*.1/5),
                  height: Height*0.24/2,
                  width: Width*0.96,
                  child:Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.brown,
                    shadowColor: Colors.blue,
                    elevation: 15.0,
                    child:Padding(
                      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                      child: ListTile(
                        leading:const CircleAvatar(
                          radius: 25,
                          child: Icon(CupertinoIcons.calendar),
                        ),
                        title: text(state.list![index].date!.toString(),FontWeight.normal,20.0,Colors.blue),
                        subtitle: text("Attendance",FontWeight.normal,12.0,Colors.blue),
                        trailing: CircleAvatar(
                          backgroundColor:(state.list![index].status=="Absent")?Colors.red:(state.list![index].status=="Present")?Colors.green:Colors.yellow,
                          radius: 25,
                          child:(state.list![index].status=="Absent")?Text("A"):(state.list![index].status=="Present")?Text("P"):Text("L"),
                        ),
                      ),
                    ),
                  )
              ),
        ),
      );
    }
    return Container();
  },
)

         ],
       ),)
    );
  }
 ShowDialog() {
   showDialog(
     barrierDismissible: true,
     context: context,
     builder: (BuildContext context) {
       return OpenDailog(callbackFunction:(){
         setState(() {

         });
       });
     },
   );
 }

void scheduleTask() async{
  checkScheduleTask= cron.schedule(Schedule.parse('* */1 * * * *'), () async{

   });
}

}

