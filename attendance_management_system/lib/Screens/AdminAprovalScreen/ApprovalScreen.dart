import 'package:attendance_management_system/Utility/Widgets/AppBarWidget/AppBarWidget.dart';
import 'package:attendance_management_system/Utility/Widgets/Drawer/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../Utility/Constraints/Style/TextDecoration.dart';
import '../../Utility/Constraints/TextConstraint/TextConstraint.dart';
class AdminApproval extends StatefulWidget {
  const AdminApproval({Key? key}) : super(key: key);

  @override
  State<AdminApproval> createState() => _AdminApprovalState();
}

class _AdminApprovalState extends State<AdminApproval> {
  var descriptionController=TextEditingController();

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
                    child: text("Vacation",FontWeight.normal,18.0,Colors.blue)),
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
                    child: text("3",FontWeight.normal,18.0,Colors.blue)),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: Width*0.1/2,top: Width*.1/3),
                    child: text("FromDate:",FontWeight.bold,19.0,Colors.black)),

                Container(
                    margin: EdgeInsets.only(left: Width*0.1/4,top: Width*.1/3),
                    child: text("22-02-2012",FontWeight.normal,18.0,Colors.blue)),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: Width*0.1/2,top: Width*.1/3),
                    child: text("ToDate:",FontWeight.bold,19.0,Colors.black)),

                Container(
                    margin: EdgeInsets.only(left: Width*0.1/4,top: Width*.1/3),
                    child: text("01-03-2012",FontWeight.normal,18.0,Colors.blue)),
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
    controller:descriptionController,
    validator: MultiValidator([
    RequiredValidator(errorText: "Enter the reason of your leave here..."),
    ]),
    decoration: buildInputDecoration("Description", 1, false, null),
    ),
    )

              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: Width*0.1/2.1,top:Width*0.1/2),
                    width: Width*0.45,
                    child:ElevatedButton.icon(
                    onPressed: (){}, icon: Icon(CupertinoIcons.checkmark_alt_circle_fill),
                    label:  text("Approve",FontWeight.bold,18.0,Colors.white),
                    style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(Width*0.1/2)
                ),)

                ),
                Container(
                    margin: EdgeInsets.only(left: Width*0.1/10,top:Width*0.1/2),
                    width: Width*0.45,
                    child:ElevatedButton.icon(
                      onPressed: (){}, icon: Icon(CupertinoIcons.delete_right_fill),
                      label:  text("Reject",FontWeight.bold,18.0,Colors.white),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                          padding: EdgeInsets.all(Width*0.1/2)
                      ),)

                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
