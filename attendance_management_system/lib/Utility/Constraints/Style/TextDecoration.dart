import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String? labelText,int color,dynamic filledColor,bool? isPasswordTextField){
return InputDecoration(
   suffixIcon: isPasswordTextField==true?GestureDetector(child:const Icon(Icons.remove_red_eye,size: 15,color:Colors.grey,),onTap: (){},):null,
  labelText: labelText,
  labelStyle: TextStyle(
    color: (color==1)?Colors.blue:Colors.white,
    fontStyle: FontStyle.italic
  ),
contentPadding:const EdgeInsets.symmetric(horizontal:10 ,vertical: 22),
    fillColor: const Color.fromRGBO(140, 126, 126, 0.4),
  filled: filledColor,
enabledBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(12.0),
  borderSide: BorderSide(color: (color==1)?Colors.blue:Colors.white)
),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color:(color==1)?Colors.blue:Colors.white),
    borderRadius: BorderRadius.circular(12.0)
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius:const BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(color:color==1?Colors.blue:Colors.white,),
  ),
  errorBorder:const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(color:Colors.redAccent,),
  ),
);

}