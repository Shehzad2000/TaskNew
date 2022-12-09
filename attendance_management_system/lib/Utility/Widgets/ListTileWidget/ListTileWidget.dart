import 'package:flutter/material.dart';
class ListTileWidget extends StatelessWidget {
  String? title,subTitle;
   ListTileWidget({Key? key,this.title,this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
         title!,
        style:const TextStyle(
            fontSize: 30,
            color: Colors.lightBlueAccent,
            shadows: [
              Shadow(
                  color: Colors.grey,
                  offset: Offset(5, 5),
                  blurRadius: 10),
            ]),
      ),
        subtitle: (subTitle!=null)?Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/15,left: MediaQuery.of(context).size.height*0.1/0.8),
          child:  Text(
            subTitle!,
            style:const TextStyle(fontSize: 21, color: Colors.blue),
          ),
        ):Container(),
    );
  }
}
