import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constraints/TextConstraint/TextConstraint.dart';
class ProfileListTile extends StatelessWidget {
  String? title,subTitle;
  ProfileListTile({Key? key,this.title,this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          child:Icon(CupertinoIcons.heart)
      ),
      title: text(title.toString(),FontWeight.normal,17.0,Colors.blue),
      subtitle:  text(subTitle.toString(),FontWeight.normal,12.0,Colors.blue),
      trailing: IconButton(
          icon: Icon(CupertinoIcons.arrow_right_circle_fill),
        iconSize: 25,
        color: Colors.blue, onPressed: () {  },
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onTap: (){

      },
    );
  }
}
