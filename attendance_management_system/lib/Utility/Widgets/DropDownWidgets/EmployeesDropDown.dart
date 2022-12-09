import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/UserBloc/user_bloc.dart';

class EmployeesDD extends StatefulWidget {
  Function(String) callbackFunction;
  EmployeesDD({Key? key, required this.callbackFunction}) : super(key: key);

  @override
  State<EmployeesDD> createState() => _EmployeesDDState();
}

class _EmployeesDDState extends State<EmployeesDD> {
UserBloc? userBloc;
String? dropdownvalue;
String? val;
  // List of items in our dropdown menu

  @override
  void initState() {
userBloc=BlocProvider.of<UserBloc>(context);
userBloc!.add(GetUsersEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.only(left: MediaQuery.of(context).padding.left+10),
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.32 / 4,

          //    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.blue, width: 1)),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is UserShowDataState) {
                return ListView.builder(
                    itemCount: state.list!.length,
                    itemBuilder: (context, index) {
                      return DropdownButtonFormField<String>(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Select any field";
                          }
                        },
                        // Initial Value
                        decoration:const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none

                        ),
                        hint:const Text(
                          "--- Select Employee ---",
                          style: TextStyle(color: Colors.blue),
                        ),
                        value: dropdownvalue,
                        isExpanded: true,
                        iconSize: 36,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                        ),

                        // Array list of items
                        items: state.list!
                            .map((e) => BuildMenuItem(e.name!))
                            .toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (value) => setState(() {
                          dropdownvalue = state.list![index].name;
                          widget.callbackFunction(
                              val = state.list![index].userID!);
                        }),
                      );
                    });
              }
              return Container();
            },
          )),
    );
  }
}

DropdownMenuItem<String> BuildMenuItem(String item) => DropdownMenuItem(
  value: item,
  child: Text(
    item,
    style:const TextStyle(
        fontWeight: FontWeight.normal, fontSize: 16, color: Colors.blue),
  ),
);
