import 'package:attendance_management_system/Bloc/UserBloc/user_bloc.dart';
import 'package:attendance_management_system/Model/SharedPreferences/GetCounts.dart';
import 'package:attendance_management_system/Model/SharedPreferences/SharedPreference.dart';
import 'package:attendance_management_system/Utility/Constraints/TextConstraint/TextConstraint.dart';
import 'package:attendance_management_system/Utility/Widgets/ListTileWidget/ListTileWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Utility/Widgets/AppBarWidget/AppBarWidget.dart';
import '../../../Utility/Widgets/ListTileWidget/ProfileListTiles.dart';
import 'StudentEditprofile.dart';

class StudentProfile extends StatefulWidget {
 const StudentProfile({Key? key}) : super(key: key);
  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  UserBloc? userBloc;
  var userID;
  @override
  void initState() {

    userBloc=BlocProvider.of<UserBloc>(context);
      userBloc!.add(GetUserEvent("637fR0qVGZ7rMkxvYAt6"));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var Height=MediaQuery.of(context).size.height;
    var Width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(Height*0.1/1.3),
          child:const AppBarWidget()
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<UserBloc,UserState>(builder: (context,state){
          if(state is UserLoadingState) {
            return const CircularProgressIndicator();
          }
          else if(state is UserShowDataState)
          {
            return Stack(
              children: [
                Column(
                  children: [

                    Center(
                      child: Container(
                        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/2),
                        height: MediaQuery.of(context).size.height*.16,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                            image: DecorationImage(image: NetworkImage(state.requestModel!.image),
                                fit: BoxFit.cover)
                        ),
                      ),
                    ),
                    Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/8),
                      child: text('${state.requestModel!.name}', FontWeight.normal, 15.0, Colors.blue),
                    ),
                    Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/16,bottom: MediaQuery.of(context).size.height*0.1/16),
                      child: text(
                          state.requestModel!.email.toString(), FontWeight.normal, 15.0,
                          Colors.blue
                      ),
                    ),
                    Divider(
                      height: MediaQuery.of(context).size.height*.1/8,
                      thickness: 1,
                    ),
                    SizedBox(
                      // margin: const EdgeInsets.only(top: 10),
                      height: Height*.19/3,
                      child: ProfileListTile(title: "Name",subTitle: state.requestModel!.name.toString()),
                    ),
                    Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                      height: MediaQuery.of(context).size.height*.19/3,
                      child: ProfileListTile(title: "Email",subTitle: state.requestModel!.email.toString()),
                    ),
                    Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                      height: MediaQuery.of(context).size.height*.19/3,
                      child: ProfileListTile(title: "Password",subTitle: state.requestModel!.password.toString()),
                    ),
                    Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                      height: MediaQuery.of(context).size.height*.19/3,
                      child: ProfileListTile(title: "Contact",subTitle: "023232323"),
                    ),
                    Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                      height: MediaQuery.of(context).size.height*.19/3,
                      child: ProfileListTile(title: "Gender",subTitle: state.requestModel!.gender.toString(),),
                    ),
                    Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/20),
                      height: MediaQuery.of(context).size.height*.19/3,
                      child: ProfileListTile(title: "status",subTitle: state.requestModel!.status==1?"Active":"InActive",),
                    ),
                    Divider(
                      height: MediaQuery.of(context).size.height*.2/3,
                    ),

                  ],

                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StudentEditProfile(
                      requestModel: state.requestModel,


                    )));
                  },
                  child:Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15, left: MediaQuery.of(context).size.height*.26),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: MediaQuery.of(context).size.height*0.1/3.8,
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height*0.1/4.2,
                        child:const Icon(CupertinoIcons.pencil, size: 30,),
                      ),
                    ),
                  ),
                ),
              ],

            );
          }
          return Container();
        },

        ),
      ),
     /* bottomNavigationBar: Theme(data: Theme.of(context).copyWith(
          iconTheme:const IconThemeData(color: Colors.white)), child: navbar2()),*/
    );
  }
}