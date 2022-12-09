
import 'package:attendance_management_system/Bloc/UserBloc/user_bloc.dart';
import 'package:attendance_management_system/Model/UserModel/UserRequestModel.dart';
import 'package:attendance_management_system/Utility/Widgets/DropDownWidgets/StatusDropdownWidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';

import '../../Utility/Constraints/ContainerConstraints/ContainerConstraints.dart';
import '../../Utility/Constraints/ContainerConstraints/InkConstraint.dart';
import '../../Utility/Constraints/Style/ButtonStyle.dart';
import '../../Utility/Constraints/Style/TextDecoration.dart';
import '../../Utility/Constraints/TextConstraint/TextConstraint.dart';
import '../../Utility/MediaQueries/UserRegisteration.dart';
import '../../Utility/Widgets/AppBarWidget/AppBarWidget.dart';
import '../../Utility/Widgets/ListTileWidget/ListTileWidget.dart';
import 'UserLoginScreen.dart';
class UserRegisteration extends StatefulWidget {
  UserRequestModel? requestModel;
   UserRegisteration({Key? key,this.requestModel}) : super(key: key);

  @override
  State<UserRegisteration> createState() => _UserRegisterationState();
}

class _UserRegisterationState extends State<UserRegisteration> {
  final _formKey =GlobalKey<FormState>();
  var usernameController=TextEditingController();
  var userEmailController=TextEditingController();
  var userPasswordController=TextEditingController();
  String? path;
 String? fileName;
  String? gender;
  String? status;
  UserBloc? userBloc;
  PlatformFile? pickedFile;
  @override
  void initState() {
    userBloc=BlocProvider.of<UserBloc>(context);
    if(widget.requestModel!=null){
      usernameController.text=widget.requestModel!.name!;
      userEmailController.text=widget.requestModel!.email!;
      userPasswordController.text=widget.requestModel!.password!;
      gender=widget.requestModel!.gender!;
      status=widget.requestModel!.status==1?"Active":"InActive";
    }
    // TODO: implement initState

  }

  Future  selectFile() async{
    final res=await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg','png']
    );
    if(res==null)return null;
    print(path=res.files.single.path);
     print(fileName=res.files.single.name);
    setState(() {
      pickedFile=res.files.first;
    });
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
          'Employee has been registered successfully',
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
      body:SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: Height,
              width: Width,
              decoration: decorationImage('assets/images/B4.jpg'),
            ),
            Container(
              margin: EdgeInsets.only(top:Height*0.2/3),
              height: Height * 0.2,
              padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: MediaQuery.of(context).padding.left+2),
              child: ListTileWidget(title:"Welcome to the",subTitle: "AM-System",),
            ),
            Center(
              child: Form(
                key:_formKey,
                  child: Column(
                    children: [
                      userNameTextField(context,Width,Height),
                      userEmailTextField(context,Width,Height),
                      userPasswordTextField(context,Width,Height),
                      userGenderTextField(context,Width,Height),
                      userPictureTextField(context,Width,Height),
                      userStatusTextField(context,Width,Height),
                      userSignUpButton(context,Width,Height),
                      GestureDetector(
                        child: Container(
                            margin:  EdgeInsets.only(
                                top: MediaQuery.of(context).size.height*0.1/10, left: 0),
                            child: text(
                                "Already have an account?SignIn:-",
                                FontWeight.normal,
                                17.0,
                                Colors.white)),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                const UserLoginScreen())),
                      ),

                    ],
                  )
              ),
            )

          ],
        ),
      )
    ),
);
  }

 Widget userNameTextField(BuildContext context,var width,var height) {
  return Container(
    margin:EdgeInsets.only(top: height*0.3),
    width: width*0.95,
    child: TextFormField(
      controller:usernameController,
      validator: MultiValidator([
          RequiredValidator(errorText: "Kindly, Enter your name here..."),
        MinLengthValidator(3, errorText: "Kindly,Enter complete name")
      ]),
      decoration: buildInputDecoration("Name", 0, true,null),
    ),

  );
 }

  Widget userEmailTextField(BuildContext context,var width,var height) {
    return Container(
      margin: EdgeInsets.only(top: height*.1/7),
      width: width*.95,
      child: TextFormField(
        controller:userEmailController,
        validator: MultiValidator([
          RequiredValidator(errorText: "Kindly, Enter your Email here..."),
          EmailValidator(errorText: "Kindly,Enter your correct email here...")
        ]),
        decoration: buildInputDecoration("Email", 0, true, null),
      ),
    );
  }

  Widget userPasswordTextField(BuildContext context,var width,var height) {
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

  Widget userGenderTextField(BuildContext context,var width,var height) {
    return Column(
      children: [
        Container(
          margin:  EdgeInsets.only(top: height*0.1/7,right: height*0.32),
          child: text("Gender",FontWeight.normal,20.0,Colors.white)
        ),
        SizedBox(
          width: width * .8,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: RadioListTile(
                  value: "Male",
                  groupValue: gender,
                  title:text("Male",FontWeight.normal,17.0,Colors.white),
                  onChanged: (newValue) => setState(
                          () => gender =
                      newValue as String?),
                  activeColor: Colors.white,
                  selected: true,
                ),
              ),
              Expanded(
                flex: 1,
                child: RadioListTile(
                  value: "Female",
                  groupValue: gender,
                  title:text("Female",FontWeight.normal,17.0,Colors.white),
                  onChanged: (newValue) => setState(
                          () => gender =
                      newValue as String?),
                  activeColor: Colors.white,
                  selected: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget userPictureTextField(BuildContext context,var width,var height) {
    return SizedBox(

      width: width*0.95,
      height: height*.1/1.3,
      child:ElevatedButton.icon(onPressed: (){
        selectFile();
      }, icon:const Icon(CupertinoIcons.doc), label:const Text("Select Image"),style: buttonStyle,)
    );
  }

  Widget userStatusTextField(BuildContext context,var width,var height) {
    return Container(
      margin: EdgeInsets.only(top: height*.1/7),
      width: width*.95,
      child: DropDown(callbackFunction: (newValue ) {
        status=newValue;
      },),
    );
  }

  Widget userSignUpButton(BuildContext context,var width,var height) {
    return Container(
      margin: EdgeInsets.only(top: height*.1/7),

      child:RaisedButton(
        onPressed: (){
          userBloc!.add(RegisterUserEvent(UserRequestModel(
            name: usernameController.text,
            email: userEmailController.text,
            password: userPasswordController.text,
            gender: gender,
            image:fileName,
            path: path,
            isAdmin: false,
            registerationDate: DateFormat.yMMMMEEEEd().format(DateTime.now()),
            status: status=="Active"?1:0
          )));

        },
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1/22),
        child: inKDecoration("SignUp"),
      )


    );
  }

}
