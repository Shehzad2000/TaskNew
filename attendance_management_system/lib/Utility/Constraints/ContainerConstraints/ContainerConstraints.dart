import 'package:flutter/material.dart';

Decoration decorationImage(String? image)=>
    BoxDecoration(image: DecorationImage(image:AssetImage(image!),filterQuality:FilterQuality.high,fit:BoxFit.cover  ));