import 'package:flutter/material.dart';

var buttonStyle=ButtonStyle(
shape:MaterialStateProperty.all(RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12.0),
  side:const BorderSide(color: Colors.white)
))
);