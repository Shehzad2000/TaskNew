import 'package:attendance_management_system/Screens/LeaveApplicationScreen/LeaveApplicationScreen.dart';
import 'package:attendance_management_system/Screens/Profile/StudentProfile/StudentProfile.dart';
import 'package:attendance_management_system/Screens/UserScreen/UserLoginScreen.dart';
import 'package:attendance_management_system/Screens/ViewAttendance/ViewAttendance.dart';
import 'package:attendance_management_system/Utility/Constraints/TextConstraint/TextConstraint.dart';
import 'package:attendance_management_system/Utility/Widgets/BottomNavBar/BottomNavBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Bloc/UserBloc/user_bloc.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<FaIcon> listIcons=const [
    FaIcon(FontAwesomeIcons.home),
    FaIcon(FontAwesomeIcons.school),
    FaIcon(FontAwesomeIcons.book),
    FaIcon(FontAwesomeIcons.userGraduate),
    FaIcon(FontAwesomeIcons.chalkboardTeacher),
    FaIcon(FontAwesomeIcons.baby),
    FaIcon(FontAwesomeIcons.addressBook)
  ];
  List<String> TextList=[
    "Home",
    "LeaveAttendance",
    "MarkAttendance",
    "ViewAttendance"
    "Suck",
    "setting",
    "logout"
  ];
  List<dynamic> list=[
    BottomNavBarWidget(),
    LeaveApplicationScreen(),
    Container(),
    ViewAttendance(),
    StudentProfile(),
    Container(),
    const UserLoginScreen(),
  ];



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width-60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildMenuItems(context)
            ],
          ),
        ),

      );
  }

  Widget buildHeader(BuildContext context) =>Material(
    color: Colors.blue.shade700,
    child: InkWell(
      onTap: (){
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> StudentProfile()));
      },
      child: Container(
        color: Colors.lightBlueAccent.shade700,
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top+24,
            bottom: MediaQuery.of(context).padding.top-10
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.height*.1/1.4,
              backgroundColor: Colors.red,
              backgroundImage:const AssetImage('assets/images/z.jpg'),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height*0.1/4
            ),
            Container(
              child: text("state.requestModel!.name.toString()",FontWeight.normal,18.0,Colors.white),
            ),
            Container(
              //    margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom*0.5),
              child: text("state.requestModel!.email.toString()",FontWeight.normal,14.0,Colors.white),
            )
          ],
        ),
      ),
    ),
  );
  Widget buildMenuItems(BuildContext context)=>Container(
    color: Colors.white,
    padding:  EdgeInsets.only(left: MediaQuery.of(context).padding.left+15,
        bottom: MediaQuery.of(context).padding.bottom),
    child: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context,index){
                return (index!=4)?ListTile(
                  leading:  listIcons[index],
                  title: Text(TextList[index]),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>list[index]));
                  },
                ):(
                    (index==4)?(
                        Column(
                            children: [
                              Divider(
                                height: MediaQuery.of(context).size.height*0.1/8,
                                indent: 20,
                                thickness: 0.5,
                                endIndent: 20,
                                // color: Constants.background,
                                color: Colors.black,),
                              ListTile(
                                leading:  listIcons[index],
                                title: Text(TextList[index]),
                                onTap: (){
                                  Navigator.pop(context);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>list[index]));
                                },)
                            ]
                        )
                    ):( ListTile(
                      leading:  listIcons[index],
                      title: Text(TextList[index]),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>list[index]));
                      },))
                );
              }),
        ),
      ],
    ),
  );


}