import 'package:flutter/material.dart';

import '../../Constraints/TextConstraint/TextConstraint.dart';
class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        margin: EdgeInsets.only(right: 20),
        child: Center(
          child:text("AM-System",FontWeight.normal,17.0,Colors.white)
        ),
      ),
      titleTextStyle:const TextStyle(
        color: Colors.white
      ),
      actions: [
        Icon(Icons.settings,)
      ],
    );
  }
}
