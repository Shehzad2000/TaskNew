import 'package:flutter/material.dart';

Ink inKDecoration(String? text)=>Ink(
  decoration: BoxDecoration(
      gradient:const LinearGradient(colors: [Color(0xff374ABE), Color(0xff64B6FF)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(30.0)
  ),
  child: Container(
    constraints:const  BoxConstraints(maxWidth: 310.0, minHeight: 46.0),
    alignment: Alignment.center,
    child: Text(
      "$text",
      textAlign: TextAlign.center,
      style:const TextStyle(
          color: Colors.white,fontSize: 20
      ),
    ),
  ),
);