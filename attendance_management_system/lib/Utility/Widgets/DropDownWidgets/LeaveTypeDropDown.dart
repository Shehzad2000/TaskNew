import 'package:attendance_management_system/Utility/Widgets/DropDownWidgets/EmployeesDropDown.dart';
import 'package:flutter/material.dart';
/*
class LeaveTypeDD extends StatefulWidget {
  Function? callbackfunction;
   LeaveTypeDD({Key? key,this.callbackfunction}) : super(key: key);

  @override
  State<LeaveTypeDD> createState() => _LeaveTypeDDState();
}

class _LeaveTypeDDState extends State<LeaveTypeDD> {
  String dropdownvalue="";

  String? value='--- Status ---';


  final items=[
    "Vacation",
    "SickLeave ",
    "Others"
  ];

  @override
  Widget build(BuildContext context) {
    var Height=MediaQuery.of(context).size.height;
    var Width=MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        height: Height*0.32/4,
        width: Width*0.95,
        padding: EdgeInsets.symmetric(horizontal: Height*0.1/8,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.blue, width: 1),
          color: Colors.white,
        ),
        child: DropdownButtonFormField<String>(
          decoration:const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none
          ),
          value: value,
          isExpanded: true,
          iconSize: 36,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.blue,
          ),
          items: items.map(BuildMenuItem).toList(),
          onChanged: (value)=>setState(() {
            widget.callbackfunction!(dropdownvalue=value!);
          }),
        ),
      ),
    );
  }
}
DropdownMenuItem<String> BuildMenuItem(String item)=>
    DropdownMenuItem(value: item,
      child: Text(
        item,
        style:const TextStyle(fontWeight: FontWeight.normal, fontSize: 16,color: Colors.blue),
      ),
    );
*/


class LeaveTypeDD extends StatefulWidget {
  LeaveTypeDD({Key? key, required this.callbackFunction}) : super(key: key);
  Function(String) callbackFunction;

  @override
  State<LeaveTypeDD> createState() => _LeaveTypeDDState();
}

class _LeaveTypeDDState extends State<LeaveTypeDD> {
  @override
  String dropdownvalue = '--- LeaveType ---';

  String? value;

  // List of items in our dropdown menu
  final items = [
    '--- LeaveType ---',
  "Vacation",
    "SickLeave ",
    "Others"

  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width*0.95,
        height: MediaQuery.of(context).size.height*0.32/4,
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.1/8, ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.blue, width: 1),
          color: Colors.white,
        ),
        child: DropdownButtonFormField<String>(
          decoration:const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none

          ),

          value: dropdownvalue,
          isExpanded: true,
          iconSize: 36,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.blue,
          ),
          // Array list of items
          items: items.map(BuildMenuItem).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (value) => setState(() => widget.callbackFunction(dropdownvalue=value!)),
        ),
      ),
    );
  }
}

DropdownMenuItem<String> BuildMenuItem(String item) => DropdownMenuItem(
  value: item,
  child: Text(
    item,
    style:const TextStyle(fontWeight: FontWeight.normal, fontSize: 16,color: Colors.blue),
  ),
);
