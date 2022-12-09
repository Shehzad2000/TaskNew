import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utility/Constraints/TextConstraint/TextConstraint.dart';
import '../../Utility/Widgets/AppBarWidget/AppBarWidget.dart';

class GetLeaveApplication extends StatefulWidget {
  const GetLeaveApplication({Key? key}) : super(key: key);

  @override
  State<GetLeaveApplication> createState() => _GetLeaveApplicationState();
}

class _GetLeaveApplicationState extends State<GetLeaveApplication> {
  @override
  Widget build(BuildContext context) {
    var Height=MediaQuery.of(context).size.height;
    var Width=MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.1/1.3),
            child:const AppBarWidget()),
        body:SingleChildScrollView(
          child: Column(

            children: [
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
                        title: text("22-02-2022",FontWeight.normal,20.0,Colors.blue),
                        subtitle: text("Wednesday",FontWeight.normal,12.0,Colors.blue),
                        trailing:const CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 25,
                          child: Text("A"),
                        ),
                      ),
                    ),
                  )
              ),

            ],
          ),)
    );
  }
}
