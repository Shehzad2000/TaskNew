

import 'dart:io';

import 'package:attendance_management_system/Bloc/UserBloc/user_bloc.dart';
import 'package:attendance_management_system/Model/UserModel/UserRequestModel.dart';
import 'package:attendance_management_system/Screens/Profile/StudentProfile/StudentProfile.dart';
import 'package:attendance_management_system/Utility/Constraints/ContainerConstraints/InkConstraint.dart';
import 'package:attendance_management_system/Utility/Widgets/DropDownWidgets/StatusDropdownWidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Utility/Constraints/Style/TextDecoration.dart';
import '../../../Utility/Constraints/TextConstraint/TextConstraint.dart';
import '../../../Utility/Widgets/AppBarWidget/AppBarWidget.dart';

class StudentEditProfile extends StatefulWidget {
  UserRequestModel? requestModel;
  StudentEditProfile({Key? key,this.requestModel}) : super(key: key);

  @override
  State<StudentEditProfile> createState() => _StudentEditProfileState();
}

class _StudentEditProfileState extends State<StudentEditProfile> {
  UserBloc? userBloc;
var groupValue;
  var status;
  var emailController=TextEditingController();
  var nameController=TextEditingController();
   
  var passwordController=TextEditingController();

  var contactController=TextEditingController();

  String? image;

  String? path;

  String? fileName;

  PlatformFile? pickedFile;

 var myFile;
  Future  selectFile() async{
    final res=await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg','png']
    );
    if(res==null)return null;
    print(path=res.files.single.path);
    print(fileName=res.files.single.name);
     myFile=File(path!);
    setState(() {
      pickedFile=res.files.first;
    });
  }
  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    if(widget.requestModel!=null){
      nameController.text=widget.requestModel!.name!;
      emailController.text=widget.requestModel!.email!;
      passwordController.text=widget.requestModel!.password==null?"null":widget.requestModel!.password.toString();
      groupValue=widget.requestModel!.gender!;
      status=widget.requestModel!.status==1?"Active":"InActive";
      image=widget.requestModel!.image;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*.1/1.3),
          child:const AppBarWidget()
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
    if (state is UserSuccessState) {
    var snackBar =const  SnackBar (
    content:  Text(
    'Profile has been Updated successfully',
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
    } else if (state is UserErrorState) {
      var snackBar = const SnackBar(
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
    }   // TODO: implement listener
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  (myFile!=null)?Center(
                    child: Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/2),
                      height: MediaQuery.of(context).size.height*.16,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.4,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:FileImage(myFile) ,
                              fit: BoxFit.cover)
                      ),
                    ),
                  ):Center(
                    child: Container(
                      margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/2),
                      height: MediaQuery.of(context).size.height*.16,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.4,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(widget.requestModel!.image) ,
                              fit: BoxFit.cover)
                      ),
                    ),
                  ),


                  Container(
                    margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/8),
                    child: text(widget.requestModel!.name.toString(), FontWeight.normal, 15.0, Colors.blue),
                  ),
                  Container(
                    margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/16,bottom: MediaQuery.of(context).size.height*0.1/16),
                    child: text(
                        widget.requestModel!.email!, FontWeight.normal, 15.0,
                        Colors.blue
                    ),
                  ),
                  Divider(
                    height: MediaQuery.of(context).size.height*.1/8,
                    thickness: 1,
                  ),
                  Center(
                    child: Form(
                      child: Column(
                        children: [
                          Container(
                              margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*.1/8,),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextFormField(
                                controller: nameController,
                                decoration: buildInputDecoration("Name", 1, false,false),
                              )
                          ),
                          Container(
                              margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*.1/8,),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextFormField(
                                controller: emailController,
                                decoration: buildInputDecoration("Email", 1, false,false),
                              )
                            //  child: buildTextField("Name:", "Beast Incarnet", false),
                          ),
                          Container(

                              margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*.1/8,),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextFormField(
                                controller: passwordController,
                                decoration: buildInputDecoration("Password", 1, false,false),
                              )
                          ),
                          Container(

                              margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*.1/8,),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextFormField(
                                controller: contactController,
                                decoration: buildInputDecoration("Contact", 1, false,false),
                              )
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/8,left: MediaQuery.of(context).size.height*0.1/3),
                            child: const Text('Gender:',style: TextStyle(color:Colors.blue,fontSize: 20),),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*.8,

                            child: Row(
                              children: <Widget>[

                                Expanded(
                                  flex: 1,
                                  child: RadioListTile(
                                    value: "Male",
                                    groupValue: groupValue,
                                    title: Text("Male",style: TextStyle(color:Colors.blue,fontSize: 17),),
                                    onChanged: (newValue) =>
                                        setState(() => groupValue = newValue as String?),
                                    activeColor: Colors.lightBlueAccent,
                                    selected: false,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: RadioListTile(
                                    value: "Female",
                                    groupValue: groupValue,
                                    title: Text("Female",style: TextStyle(color:Colors.blue,fontSize: 17)),
                                    onChanged: (newValue) =>
                                        setState(() => groupValue = newValue as String?),
                                    activeColor: Colors.lightBlueAccent,
                                    selected: false,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.1/8),
                              child: DropDown(
                                callbackFunction: customFunction,
                              )),

                        ],
                      ),


                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  selectFile();
                },
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15, left: MediaQuery.of(context).size.height*.26),

                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius:  MediaQuery.of(context).size.height*0.1/3.8,
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.height*0.1/4.2,
                      child:const Icon(CupertinoIcons.camera, size: 30,),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*.9,bottom: MediaQuery.of(context).size.height*0.1/10),
                  height: MediaQuery.of(context).size.height*0.26/4,
                  child:RaisedButton(
    onPressed: (){
      userBloc!.add(UpdateUserEvent(UserRequestModel(
        userID: widget.requestModel!.userID,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        gender: groupValue,
        image: image,
        path: path,
        registerationDate: widget.requestModel!.registerationDate,
        status: status=="Active"?1:0
      )));
    },
    shape: RoundedRectangleBorder(
    borderRadius:
    BorderRadius.circular(80.0)),
    padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/22),
    child: inKDecoration("Update"),
    ),
                ),
              )
            ],

          ),
        ),
      ),
    /*  bottomNavigationBar: Theme(data: Theme.of(context).copyWith(
          iconTheme:const IconThemeData(color: Colors.white)), child: navbar2()),*/
    );
  }

  void customFunction(newString){
    setState(() {
      status=newString;
    });
  }
}
/*Widget buildTextField(String labelText,String placeholder,bool isPasswordTextField){
  var isObsecurePassword;
  return Padding(
    padding: const EdgeInsets.only(bottom: 30.0),
    child: TextField(
      obscureText: isPasswordTextField?isObsecurePassword:false,
      decoration: InputDecoration(
          suffixIcon: isPasswordTextField?iconButton(Icons.remove_red_eye, Colors.grey, 15):null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          hintText: placeholder,
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey
          )
      ),
    ),
  );
}*/
