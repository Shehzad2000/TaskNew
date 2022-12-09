import 'package:attendance_management_system/Screens/LeaveApplicationScreen/LeaveApplicationScreen.dart';
import 'package:attendance_management_system/Screens/Profile/StudentProfile/StudentProfile.dart';
import 'package:attendance_management_system/Screens/ViewAttendance/ViewAttendance.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../AppBarWidget/AppBarWidget.dart';
import '../Drawer/Drawer.dart';

class UserNavBarWidget extends StatefulWidget {
  const UserNavBarWidget({Key? key}) : super(key: key);

  @override
  State<UserNavBarWidget> createState() => _UserNavBarWidgetState();
}

class _UserNavBarWidgetState extends State<UserNavBarWidget> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    print(DateFormat.yMMMMEEEEd().format(DateTime.now()));
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            ViewAttendance(),
            LeaveApplicationScreen(),
            StudentProfile(),
            Container(color: Colors.blue,),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController!.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('home'),
              icon: Icon(Icons.calendar_month_rounded)
          ),
          BottomNavyBarItem(
              title: Text('Leave'),
              icon: Icon(Icons.post_add)
          ),
          BottomNavyBarItem(
              title: Text('User'),
              icon: Icon(Icons.account_circle_rounded)
          ),
          BottomNavyBarItem(
              title: Text('Item Four'),
              icon: Icon(Icons.settings)
          ),
        ],
      ),
    );
  }
}
