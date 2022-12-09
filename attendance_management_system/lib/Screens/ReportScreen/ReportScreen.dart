import 'package:attendance_management_system/Repo/AttendanceRepo.dart';
import 'package:attendance_management_system/Utility/Constraints/TextConstraint/TextConstraint.dart';
import 'package:attendance_management_system/Utility/Widgets/AppBarWidget/AppBarWidget.dart';
import 'package:attendance_management_system/Utility/Widgets/DropDownWidgets/EmployeesDropDown.dart';
import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../Utility/Constraints/ContainerConstraints/InkConstraint.dart';
import '../../Utility/Constraints/Style/TextDecoration.dart';
import '../../Utility/Widgets/ListTileWidget/ListTileWidget.dart';
class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  var fromDateController=TextEditingController();
  var toDateController=TextEditingController();
  AttendanceRepo repo=AttendanceRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var Height=MediaQuery.of(context).size.height;
    var Width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Height*0.1/1.3),
        child: AppBarWidget(),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top:Height*0.2/3),
              height: Height * 0.2,
              padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: MediaQuery.of(context).padding.left+2),
              child: ListTileWidget(title:"Welcome to the",subTitle: "AM-System",),
            ),
            Center(
              child: Form(
                child: Column(
                  children: [
                    employeesWidget(context,Width,Height),
                    fromDateWidget(context,Width,Height),
                    toDateWidget(context,Width,Height),
                    searchButtonWidget(context,Width,Height),

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
        margin:EdgeInsets.only(top: height*0.33),
        width: width*0.95,
        child:EmployeesDD(callbackFunction: (newValue){
        },)
    );
  }

  Widget fromDateWidget(BuildContext context, double width, double height) {
    return Container(
      margin: EdgeInsets.only(top: height*0.1/6),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: height*.1/12,left: height*.1/5) ,
            child: text(" FromDate:",FontWeight.normal,18.0,Colors.black),
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
      ),
    );
  }
  Widget toDateWidget(BuildContext context, double width, double height) {
    return Container(
      margin: EdgeInsets.only(top:height*.1/6),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: height*.1/12,left: height*.1/5) ,
            child: text(" ToDate:",FontWeight.normal,18.0,Colors.black),
          ),
          Container(
            margin: EdgeInsets.only(top: height*.1/7,left: width*.1/1.8),
            width: width*.7,
            height: height*0.1/1.3,
            child:CupertinoDateTextBox(
                initialValue: DateTime.now(),
                onDateChange: onToDateChangeCallback,
                hintText: 'ToDate'),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12.0)

            ),
          ),
        ],
      ),
    );
  }
  Widget searchButtonWidget(BuildContext context,var width,var height) {
    return Container(
        margin: EdgeInsets.only(top: height*.4/7),
alignment: Alignment.bottomCenter,
        child:RaisedButton(
          onPressed: (){},
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(80.0)),
          padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/22),
          child: inKDecoration("Generate Report"),
        )


    );
  }

  onToDateChangeCallback() {
  }
}
