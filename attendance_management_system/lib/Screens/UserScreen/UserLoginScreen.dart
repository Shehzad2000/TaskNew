import 'package:attendance_management_system/Bloc/UserBloc/user_bloc.dart';
import 'package:attendance_management_system/Model/SharedPreferences/GetCounts.dart';
import 'package:attendance_management_system/Model/SharedPreferences/SharedPreference.dart';
import 'package:attendance_management_system/Model/UserModel/UserRequestModel.dart';
import 'package:attendance_management_system/Screens/FetchUsersScreen/UserDataScreen.dart';
import 'package:attendance_management_system/Screens/UserScreen/UserRegisterationScreen.dart';
import 'package:attendance_management_system/Screens/ViewAttendance/ViewAttendance.dart';
import 'package:attendance_management_system/Utility/Widgets/BottomNavBar/UserNavBar.dart';
import 'package:attendance_management_system/Utility/Widgets/CicleAvatarWidget/CircleAvatarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../Utility/Constraints/ContainerConstraints/ContainerConstraints.dart';
import '../../Utility/Constraints/ContainerConstraints/InkConstraint.dart';
import '../../Utility/Constraints/Style/TextDecoration.dart';
import '../../Utility/Constraints/TextConstraint/TextConstraint.dart';
import '../../Utility/Widgets/ListTileWidget/ListTileWidget.dart';
class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({Key? key}) : super(key: key);

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final _formKey = GlobalKey<FormState>();
var userEmailController=TextEditingController();
var userPasswordController=TextEditingController();
 UserBloc? userBloc;
 @override
  void initState() {
    userBloc=BlocProvider.of<UserBloc>(context);
   // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var Height=MediaQuery.of(context).size.height;
    var Width=MediaQuery.of(context).size.width;
    return BlocListener<UserBloc, UserState>(
  listener: (context, state) {
    if (state is UserSuccessState) {
      var snackBar =const  SnackBar (
        content:  Text(
          'You have been Login successfully',
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
      body: SingleChildScrollView(
        reverse: true,
        child: Stack(
          children: [
            Container(
              height: Height,
              width: Width,
              decoration: decorationImage('assets/images/B4.jpg'),
            ),
            Container(
              margin: EdgeInsets.only(top:Height*0.2/2),
              height: Height * 0.2,
              padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: MediaQuery.of(context).padding.left+2),
              child: ListTileWidget(title:"Welcome to the",subTitle: "AM-System",),
            ),
            Center(
              child: Container(
                margin:  EdgeInsets.only(top: Height*0.47, ),
                child:const CircleAvatarWidget(),
              ),
            ),
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    userEmailWidget(context,Height,Width),
                    userPasswordWidget(context,Height,Width),
                    forgetPasswordWidget(context,Height,Width),
                    userSignInWidget(context,Height,Width),
                    GestureDetector(
                      child: Container(
                          margin:  EdgeInsets.only(
                              top: MediaQuery.of(context).size.height*0.1/10, left: 0),
                          child: text(
                              "Don't have any account?SignUp:-",
                              FontWeight.normal,
                              17.0,
                              Colors.white)),
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                               UserRegisteration())),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
);
  }



Widget userEmailWidget(BuildContext context,var height,var width) {
  return Center(
    child: Container(
      margin: EdgeInsets.only(top: height*.63),
      width: width*.95,
      child: TextFormField(
        controller:userEmailController,
        validator: MultiValidator([
          RequiredValidator(errorText: "Kindly, Enter your Email here..."),
          EmailValidator(errorText: "Kindly,Enter your correct email here...")
        ]),
        decoration: buildInputDecoration("Email", 0, true, null),
      ),
    ),
  );
}

Widget userPasswordWidget(BuildContext context, double height, double width) {
  return Container(
    margin: EdgeInsets.only(top: height*.1/7),
    width: width*0.95,
    child: TextFormField(
      controller:userPasswordController,
      validator: MultiValidator([
        RequiredValidator(errorText: "Kindly, Enter your password here..."),
        MinLengthValidator(6, errorText: "Password should have been 6 character long")
      ]),
      decoration: buildInputDecoration("Password", 0, true, true),
    ),
  );
}

Widget userSignInWidget(BuildContext context, double height, double width) {
  return Container(
      margin: EdgeInsets.only(top: height*.1/7),

      child:RaisedButton(
        onPressed: (){
if(_formKey.currentState!.validate()){
  userBloc!.add(UserSignInEvent(UserRequestModel(
      email: userEmailController.text,
      password: userPasswordController.text
  )));
}
/*(SharedPreference.isAdmin==true)?Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserDataScreen())):*/
Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserDataScreen()));


        },

        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/22),
        child: inKDecoration("SignIn"),
      )


  );
}

Widget forgetPasswordWidget(BuildContext context, double height, double width) {
  return  InkWell(
      child: const Text('Forget Password',style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,)),
      onTap: () => ('')
  );
}


}