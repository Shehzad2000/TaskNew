import 'package:attendance_management_system/Bloc/LeaveApplicationBloc/leave_application_bloc.dart';
import 'package:attendance_management_system/Utility/Constraints/Style/TextDecoration.dart';
import 'package:attendance_management_system/Utility/Widgets/Drawer/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../Model/LeaveApplicationModel/LeaveApplicationRequestModel.dart';
import '../../Utility/Constraints/TextConstraint/TextConstraint.dart';
import '../../Utility/Widgets/AppBarWidget/AppBarWidget.dart';
class LeaveAppData extends StatefulWidget {
  LeaveApplicationRequestModel?  requestModel;
  LeaveAppData({Key? key,this.requestModel}) : super(key: key);

  @override
  State<LeaveAppData> createState() => _LeaveAppDataState();
}

class _LeaveAppDataState extends State<LeaveAppData> {
  var descriptionController=TextEditingController();
  @override
  void initState() {
    descriptionController.text=widget.requestModel!.description!;
    // TODO: implement initState
    super.initState();
  }
LeaveApplicationBloc? bloc;
  @override
  Widget build(BuildContext context) {
    var Height=MediaQuery.of(context).size.height;
    var Width=MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MyHomePage(),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Width*0.2/1.3),
          child: AppBarWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: Height*0.1/6),
              child: Center(
                child: text("Here is the details of approval",FontWeight.normal,18.0,Colors.grey),
              ),
            ),
            const Divider(
              color: Colors.orangeAccent,
              thickness: 2,
              indent: 15.0,
              endIndent: 15.0,
              height: 14,
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: Width*0.1/2,top: Width*.1/10),
                    child: text("Type:",FontWeight.bold,19.0,Colors.black)),

                Container(
                    margin: EdgeInsets.only(left: Width*0.1/4,top: Width*.1/10),
                    child: text(widget.requestModel!.type.toString(),FontWeight.normal,18.0,Colors.blue)),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: Width*0.1/2,top: Width*.1/3),
                    child: text("Name:",FontWeight.bold,19.0,Colors.black)),

                Container(
                    margin: EdgeInsets.only(left: Width*0.1/4,top: Width*.1/3),
                    child: text("Muhammad Shehzad",FontWeight.normal,18.0,Colors.blue)),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: Width*0.1/2,top: Width*.1/3),
                    child: text("Email:",FontWeight.bold,19.0,Colors.black)),

                Container(
                    margin: EdgeInsets.only(left: Width*0.1/4,top: Width*.1/3),
                    child: text("m.shehzad2483@gmail.com",FontWeight.normal,18.0,Colors.blue)),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: Width*0.1/2,top: Width*.1/3),
                    child: text("Contact:",FontWeight.bold,19.0,Colors.black)),

                Container(
                    margin: EdgeInsets.only(left: Width*0.1/4,top: Width*.1/3),
                    child: text("03352534344",FontWeight.normal,18.0,Colors.blue)),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: Width*0.1/2,top: Width*.1/3),
                    child: text("Department:",FontWeight.bold,19.0,Colors.black)),

                Container(
                    margin: EdgeInsets.only(left: Width*0.1/4,top: Width*.1/3),
                    child: text("BioTechnology",FontWeight.normal,18.0,Colors.blue)),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: Width*0.1/2,top: Width*.1/3),
                    child: text("Duration:",FontWeight.bold,19.0,Colors.black)),

                Container(
                    margin: EdgeInsets.only(left: Width*0.1/4,top: Width*.1/3),
                    child: text(widget.requestModel!.duration.toString(),FontWeight.normal,18.0,Colors.blue)),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: Width*0.1/2,top: Width*.1/3),
                    child: text("FromDate:",FontWeight.bold,19.0,Colors.black)),

                Container(
                    margin: EdgeInsets.only(left: Width*0.1/4,top: Width*.1/3),
                    child: text(widget.requestModel!.fromDate.toString(),FontWeight.normal,18.0,Colors.blue)),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: Width*0.1/2,top: Width*.1/3),
                    child: text("ToDate:",FontWeight.bold,19.0,Colors.black)),

                Container(
                    margin: EdgeInsets.only(left: Width*0.1/4,top: Width*.1/3),
                    child: text(widget.requestModel!.toDate.toString(),FontWeight.normal,18.0,Colors.blue)),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: Width*0.1/2,top: Width*.1/3),
                    child: text("Status:",FontWeight.bold,19.0,Colors.black)),

                Container(
                    margin: EdgeInsets.only(left: Width*0.1/4,top: Width*.1/3),
                    child: text(widget.requestModel!.status.toString(),FontWeight.normal,18.0,Colors.blue)),
              ],
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: Height*.1/7,left:Width*0.1/2),
                  width: Width*.90,
                  child: TextFormField(
                    maxLines: 8,
                    readOnly: true,
                    controller:descriptionController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Enter the reason of your leave here..."),
                    ]),
                    decoration: buildInputDecoration("Description", 1, false, null),
                  ),
                )

              ],
            ),

          ],
        ),
      ),
    );
  }
}
