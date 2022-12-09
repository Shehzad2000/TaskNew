import 'dart:async';

import 'package:attendance_management_system/Bloc/UserBloc/user_bloc.dart';
import 'package:attendance_management_system/Model/UserModel/UserRequestModel.dart';
import 'package:attendance_management_system/Screens/AttendanceScreen/AttendanceDataScreen.dart';
import 'package:attendance_management_system/Screens/UserScreen/UserRegisterationScreen.dart';
import 'package:attendance_management_system/Utility/Widgets/IconButtonWidget/IconButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../Utility/Constraints/TextConstraint/TextConstraint.dart';
import '../../Utility/Widgets/AppBarWidget/AppBarWidget.dart';

class UserDataScreen extends StatefulWidget {

  UserDataScreen({Key? key}) : super(key: key);

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  UserBloc? userBloc;
  @override
  void initState() {
    userBloc=BlocProvider.of<UserBloc>(context);
  userBloc!.add(GetUsersEvent());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserRegisteration()));
        },
        child:const Icon(Icons.add),
      ),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.1/1.3),
          child:const AppBarWidget()),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin:  EdgeInsets.only(left:MediaQuery.of(context).size.height*0.1/4,top: MediaQuery.of(context).size.height*0.1/7,bottom: MediaQuery.of(context).size.height*0.1/7),
              child: Center(child: text("Here you got User list:-",FontWeight.normal,18.0,Colors.black38)),
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
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if(state is UserLoadingState){
                    return const  Center(child:  CircularProgressIndicator());
                  }
                  else if (state is UserShowDataState){
                    return ListView.builder(
                        itemCount: state.list!.length,
                        itemBuilder: (BuildContext context,int index){
                          return   Card(
                              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/8,left: MediaQuery.of(context).size.height*0.1/7,right: MediaQuery.of(context).size.height*0.1/7),
                              shadowColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.1/5),
                              ),
                              color: Colors.white,
                              elevation: 10,
                              child:Slidable(

                                startActionPane: ActionPane(
                                  motion:const DrawerMotion(),
                                  //   dismissible: DismissiblePane(onDismissed: (){},),
                                  children: [

                                    SlidableAction(
                                      onPressed: (BuildContext context) async {
                                      },
                                      backgroundColor:const Color(0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit_rounded,
                                      label: 'Edit',
                                    ),
                                    SlidableAction(
                                      onPressed: (BuildContext context) async {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                        AttendanceDataScreen(userID: state.list![index].userID,)
                                        ));
                                      },
                                      backgroundColor:Colors.deepOrangeAccent,
                                      foregroundColor: Colors.white,
                                      icon: CupertinoIcons.calendar,
                                      label: 'Attendance List',
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
                                        child:Icon(CupertinoIcons.heart)
                                    ),
                                    title: text(state.list![index].name.toString(),FontWeight.normal,20.0,Colors.blue),
                                    subtitle: text("UserRecord(click on me)",FontWeight.normal,12.0,Colors.blue),
                                    trailing: IconButtonWidget(iconData:CupertinoIcons.text_justify,color:Colors.blue,size: 25.0,onPressed: null,),
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
                  }else if(state is UserErrorState){
                    return const Center(child:Text("Oops,Something went wrong"));
                  }

                  return Container();

                },

              ),
            )
          ],
        ),
      ),


  //    bottomNavigationBar:Theme(data: Theme.of(context).copyWith(iconTheme:const IconThemeData(color: Colors.white)),child:navbar2()),

    );
  }
  void DeletePressed(String? ID){
    userBloc!.add(
        DeleteUserEvent(
            userID: ID
        )
    );
  }
  void OnPressed(int index){
    setState(() {});
  }
  Future OpenDialog(UserRequestModel model)=>showDialog(context: context, builder: (context)=>AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*.1/5)
      ),

      scrollable: true,
      content:Container(
        height: MediaQuery.of(context).size.height*(0.4/1.6),
        width: MediaQuery.of(context).size.width*.9,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text("User Detail",style: TextStyle(color: Colors.black),),
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
                        child: Text('${model.name}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

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
                        child:const Text("Email:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                    Container(
                        margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child: Text('${model.email}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

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
                        child:const Text("Contact:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                    Container(
                        margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child: Text('0334234245',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

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
                        child:const Text("Gender:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),)),
                    Container(
                        margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1/13,left: MediaQuery.of(context).size.height*0.1/13),
                        child: Text('${model.gender}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

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
                        child: Text('${model.registerationDate}',style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

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
                        child: Text('${model.status}'==1?"Active":"InActive",style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

                  ],
                ),
              ),






            ],
          ),
        ),
      )


  ));
}
