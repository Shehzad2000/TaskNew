import 'package:attendance_management_system/Bloc/AttendanceBloc/attendance_bloc.dart';
import 'package:attendance_management_system/Bloc/LeaveApplicationBloc/leave_application_bloc.dart';
import 'package:attendance_management_system/Model/LeaveApplicationModel/LeaveApplicationRequestModel.dart';
import 'package:attendance_management_system/Model/SharedPreferences/GetCounts.dart';
import 'package:attendance_management_system/Model/SharedPreferences/SharedPreference.dart';
import 'package:attendance_management_system/Utility/Constraints/ContainerConstraints/InkConstraint.dart';
import 'package:attendance_management_system/Utility/Constraints/Style/TextDecoration.dart';
import 'package:attendance_management_system/Utility/Constraints/TextConstraint/TextConstraint.dart';
import 'package:attendance_management_system/Utility/Widgets/DropDownWidgets/LeaveTypeDropDown.dart';
import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';

import '../../Utility/Widgets/ListTileWidget/ListTileWidget.dart';
import 'DetailOfLeaveApplication.dart';
class LeaveApplicationScreen extends StatefulWidget {
  const LeaveApplicationScreen({Key? key}) : super(key: key);

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
 String? typeLeave;
 var descriptionController=TextEditingController();
 var durationController=TextEditingController();
 var fromDateController=DateFormat.yMMMMEEEEd().format(DateTime.now());
 var toDateController=DateFormat.yMMMMEEEEd().format(DateTime.now());
  LeaveApplicationBloc? leaveApplicationBloc;

  var userID;
  @override
  void initState() {
    leaveApplicationBloc=BlocProvider.of<LeaveApplicationBloc>(context);
    leaveApplicationBloc!.add(GetAllLeaveApprovalEventByUserID(userID));
    SharedPreference.getString("userID").then((value) {
      setState(() {
        userID=value;
      });});
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
return  BlocListener<LeaveApplicationBloc, LeaveApplicationState>(
  listener: (context, state) {
    if (state is LeaveApplicationSuccessState) {
      var snackBar =const  SnackBar (
        content:  Text(
          'Application has been submitted successfully',
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
    } else if (state is LeaveApplicationErrorState) {
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
    body: DefaultTabController(
        length: 2,
        child: Scaffold(
        appBar: AppBar(
        //  title: Text('Flutter Tabs Demo'),
        bottom:const TabBar(
        tabs: [
    Tab(icon: FaIcon(FontAwesomeIcons.addressBook), text: "Application"),
    Tab(icon: FaIcon(FontAwesomeIcons.history), text: "History")
    ],
    ),
    ),
    body: TabBarView(
    children: [
       Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            /*Container(
              margin: EdgeInsets.only(top:height*0.2/3),
              height: height * 0.2,
              padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: MediaQuery.of(context).padding.left+2),
              child: ListTileWidget(title:"Welcome to the",subTitle: "AM-System",),
            ),*/
            Center(
              child: Form(
                child: Column(
                  children: [
                    leaveTypeWidget(context,width,height),
                    durationWidget(context,width,height),
                    fromDateWidget(context,width,height),
                    toDateWidget(context,width,height),
                    leaveDescriptionWidget(context,width,height),
                    buttonWidget(context,width,height)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
          Scaffold(
            body: SingleChildScrollView(
      child: Column(

      children: [
     BlocBuilder<LeaveApplicationBloc, LeaveApplicationState>(
  builder: (context, state) {
    if(state is LeaveApplicationLoadingState){
      return CircularProgressIndicator();
    }else if(state is LeaveApplicationShowDataState){
      return SizedBox(
        height: height,
        width: width,
        child: ListView.builder(

          itemCount: state.list!.length,
          itemBuilder: (BuildContext context,int index)=>
              GestureDetector(
                child: Container(
                    margin: EdgeInsets.only(top: height*.1/6,left: width*.1/5),
                    height: height*0.24/2,
                    width: width*0.96,
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
                          title: text((state.list![index].fromDate!).toString(),FontWeight.normal,20.0,Colors.blue),
                          subtitle: text("Description(Click on me)",FontWeight.normal,12.0,Colors.blue),
                          trailing:const CircleAvatar(
                            backgroundColor: Colors.yellow,
                            radius: 25,
                            child: Text("L"),
                          ),
                        ),
                      ),
                    )
                ),
                onTap: (){

                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LeaveAppData(
                    requestModel: state.list![index],
                  )));
                },
              ),
        ),
      );
    }else{
      return Center(child: Text("Oops,Something went wrong"),);
    }
  },
)

    ],
    ),),
          )
    ]
    )
    )
    )
),
);
  }

 Widget leaveTypeWidget(BuildContext context, double width, double height) {
   return Container(
     margin: EdgeInsets.only(top: height*.1/7),
     width: width*.95,
     child: LeaveTypeDD(callbackFunction: (newValue ) {
       typeLeave=newValue;
     },),
   );
 }

 Widget durationWidget(BuildContext context, double width, double height) {
   return Container(
     margin: EdgeInsets.only(top: height*.1/7),
     width: width*.95,
     child: TextFormField(
       controller:durationController,
       validator: MultiValidator([
         RequiredValidator(errorText: "Kindly, Enter your Duration of leave here..."),
       ]),
       decoration: buildInputDecoration("Duration of Leave", 1, false, null),
     ),
   );
 }

Widget fromDateWidget(BuildContext context, double width, double height) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: height*.1/12,left: height*.1/7) ,
          child: text("FromDate:",FontWeight.normal,18.0,Colors.black),
        ),
        Container(
          margin: EdgeInsets.only(top: height*.1/7),
          width: width*.7,
          height: height*0.1/1.3,
          child: CupertinoDateTextBox(
              initialValue: DateTime.now(),
              onDateChange: onDateChangeCallback,
              hintText: 'FromDate'),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12.0)

          ),
        ),
      ],
    );
  }

Widget toDateWidget(BuildContext context, double width, double height) {
  return Row(
    children: [
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: height*.1/12,left: height*.1/5) ,
        child: text(" ToDate   :",FontWeight.normal,18.0,Colors.black),
      ),
      Container(
        margin: EdgeInsets.only(top: height*.1/7),
        width: width*.7,
        height: height*0.1/1.3,
        child: CupertinoDateTextBox(
            initialValue: DateTime.now(),
            onDateChange: onToDateChangeCallback,
            hintText: 'ToDate'),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12.0)

        ),
      ),
    ],
  );
  }
Widget leaveDescriptionWidget(BuildContext context, double width, double height) {
    return Container(
      margin: EdgeInsets.only(top: height*.1/7),
      width: width*.95,
      child: TextFormField(
        maxLines: 5,
        controller:descriptionController,
        validator: MultiValidator([
          RequiredValidator(errorText: "Enter the reason of your leave here..."),
        ]),
        decoration: buildInputDecoration("Description", 1, false, null),
      ),
    );
  }

 Widget buttonWidget(BuildContext context, double width, double height) {
   return Container(
       margin: EdgeInsets.only(top: height*.1/7),

       child:RaisedButton(
         onPressed: (){
           leaveApplicationBloc!.add(SendLeaveApprovalEvent(LeaveApplicationRequestModel(
             type: typeLeave,
             duration: durationController.text,
             description: descriptionController.text,
             fromDate: fromDateController,
             toDate: toDateController,
             status: "Pending",
             userID: userID
           )));
         },
         shape: RoundedRectangleBorder(
             borderRadius:
             BorderRadius.circular(80.0)),
         padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/22),
         child: inKDecoration("Send Application"),
       )
   );
 }

  onDateChangeCallback(newValue) {
    setState(() {
      fromDateController=DateFormat('dd/MM/yyyy').format(newValue);
    });
  }

  onToDateChangeCallback(newValue) {
    setState(() {
      toDateController=DateFormat('dd/MM/yyyy').format(newValue);
    });
  }
}
