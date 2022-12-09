import 'package:attendance_management_system/Utility/Widgets/Drawer/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../Bloc/AttendanceBloc/attendance_bloc.dart';
import '../../Model/AttendanceModel/AttendanceModel.dart';
import '../../Model/SharedPreferences/GetCounts.dart';
import '../../Utility/Constraints/TextConstraint/TextConstraint.dart';
import '../../Utility/Widgets/AppBarWidget/AppBarWidget.dart';
import '../AttendanceScreen/AttendanceScreen.dart';
class MainReportScreen extends StatefulWidget {
  const MainReportScreen({Key? key}) : super(key: key);

  @override
  State<MainReportScreen> createState() => _MainReportScreenState();
}

class _MainReportScreenState extends State<MainReportScreen> {
  AttendanceBloc? bloc;
@override
  void initState() {
  bloc=BlocProvider.of<AttendanceBloc>(context);
  bloc!.add(GetAttendanceBySpecificDateEvent(userID:"DHsmtoaJI9hG8EPj7zPb",fromDate:"4/12/2022",toDate: "5/12/2022"));
  // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var Height=MediaQuery.of(context).size.height;
    var Width=MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MyHomePage(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Height*0.1/1.3),
        child: AppBarWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: Width*0.1/8),
              child:Center(child: text("Salman Rashid",FontWeight.bold,19.0,Colors.blueGrey),),
            ),
            Row(
              children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: Width*.1/4,left: Width*.1/2),
                    child: text("From:",FontWeight.normal,17.0,Colors.black),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Width*.1/3.4,left: Width*.1/6),
                    child: text("(02-03-2022)",FontWeight.normal,17.0,Colors.blue),
                  ),
                ],
              ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Width*.1/4,left: Width*.24/2),
                      child: text("To:",FontWeight.normal,17.0,Colors.black),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Width*.1/3.4,left: Width*.1/6),
                      child: text("(02-03-2022)",FontWeight.normal,17.0,Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              indent:10,
              endIndent: 10,
              thickness: 1,
              height: MediaQuery.of(context).size.height*0.1/10,
              color: Colors.black38,
            ),
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
                      margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.4/4.6,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                      child: text("Leave:",FontWeight.normal,18.0,Colors.orangeAccent),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/8,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                      child: text("( ${GetCounts.LeaveCount} )",FontWeight.normal,18.0,Colors.blue),
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
                      margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/8,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                      child: text("Attendance Perc:",FontWeight.normal,18.0,Colors.green),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/12,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                      child: text("( ${GetCounts.percentage} )",FontWeight.normal,18.0,Colors.blue),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/8,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                      child: text("Grade:",FontWeight.normal,18.0,Colors.orangeAccent),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/8,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
                      child: text("( ${GetCounts.Grade} )",FontWeight.normal,18.0,Colors.blue),
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
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:
              BlocBuilder<AttendanceBloc, AttendanceState>(
                builder: (context, state) {
                  if(state is AttendanceLoadingState){
                    return const  Center(child:  CircularProgressIndicator());
                  }
                  else if (state is AttendanceShowDataState){
                    return ListView.builder(
                        itemCount: state.list!.length,
                        itemBuilder: (BuildContext context,int index){
                          return   Card(
                              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/8,left: MediaQuery.of(context).size.height*0.1/7,right: MediaQuery.of(context).size.height*0.1/7),
                              shadowColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.1/5),
                              ),
                              color: Colors.brown,
                              elevation: 10,
                              child:Slidable(

                                startActionPane: ActionPane(
                                  motion:const DrawerMotion(),
                                  //   dismissible: DismissiblePane(onDismissed: (){},),
                                  children: [

                                    SlidableAction(
                                      onPressed: (BuildContext context) async {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AttendanceScreen(
                                          requestModel:state.list![index],)));
                                      },
                                      backgroundColor:const Color(0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit_rounded,
                                      label: 'Edit',
                                    ),
                                  ],
                                ),
                                endActionPane:  ActionPane(
                                  motion:const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext context) async {
                                        DeletePressed(state.list![index].userID);
                                      },
                                      backgroundColor:const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),

                                  ],
                                ),

                                child: Padding(
                                  padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top+2,bottom: MediaQuery.of(context).padding.bottom+2),
                                  child: ListTile(
                                    leading:const CircleAvatar(
                                        radius: 25,
                                        child:Icon(CupertinoIcons.calendar)
                                    ),
                                    title: text(state.list![index].date.toString(),FontWeight.normal,20.0,Colors.blue),
                                    subtitle: text("Attendance",FontWeight.normal,12.0,Colors.blue),
                                    trailing: CircleAvatar(
                                      backgroundColor:(state.list![index].status=="Absent")?Colors.red:(state.list![index].status=="Present")?Colors.green:Colors.yellow,
                                      radius: 25,
                                      child:(state.list![index].status=="Absent")?Text("A"):(state.list![index].status=="Present")?Text("P"):Text("L"),
                                    ),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                    onTap: (){

                                      OpenDialog(state.list![index]);
                                    },
                                  ),
                                ),
                              )
                          );
                        }

                    );
                  }else if(state is AttendanceErrorState){
                    return const Center(child:Text("Oops,Something went wrong"));
                  }

                  return Container();

                },

              ),
            )
          ],
        ),
      ),
    );
  }
  void DeletePressed(String? ID){
    bloc!.add(
        DeleteAttendanceEvent(
            ID
        )
    );
  }
  void OnPressed(int index){
    setState(() {});
  }
  Future OpenDialog(AttendanceRequestModel model)=>showDialog(context: context, builder: (context)=>AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*.1/5)
      ),

      scrollable: true,
      content:Container(
        height: MediaQuery.of(context).size.height*(0.16),
        width: MediaQuery.of(context).size.width*.9,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text("Attendance Detail",style: TextStyle(color: Colors.black),),
              ),
              const Divider(
                color: Colors.black26,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.1/3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    /*  Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                    Container(
                        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child:const Text("Name:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                    Container(
                        margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child: Text('${model.userName}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.1/3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    /*  Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                    Container(
                        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child:const Text("Date:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                    Container(
                        margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child: Text('${model.date}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                  ],
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.1/3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    /*  Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                    Container(
                        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child:const Text("Status:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                    Container(
                        margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child: Text('${model.status}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.1/3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    /*  Container(
                   margin: EdgeInsets.only(top:15),
                   child: Icon(CupertinoIcons.pencil_outline,color: Colors.blue,size: 20,)),*/
                    Container(
                        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child:const Text("TotalPresent:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                    Container(
                        margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child: Text('${GetCounts.PresentCount}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),
                  ],
                ),
              ),





            ],
          ),
        ),
      )


  ));
}


