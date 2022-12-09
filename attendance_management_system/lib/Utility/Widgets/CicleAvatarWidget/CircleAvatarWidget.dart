import 'package:flutter/material.dart';
class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius:MediaQuery.of(context).size.height*.1/1.5,
        backgroundColor: Colors.white70,
        child: CircleAvatar(
          radius: MediaQuery.of(context).size.height*.1/1.6,
          backgroundColor: Colors.black,
          backgroundImage:const AssetImage('assets/images/z.jpg'),
        ),
      ),
    );
  }
}
