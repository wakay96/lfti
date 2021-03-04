import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/screens/dashboard/dashboard_screen.dart';
import 'package:lfti/screens/workout/workout_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex;
  List<Widget> _pages;

  @override
  void initState() {
    _currentPageIndex = 0;
    _pages = <Widget>[
      DashboardScreenBuilder(),
      WorkoutScreenBuilder(),
    ];
    super.initState();
  }

  void setPage(int index) {
    setState(() => _currentPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryColor,
        selectedLabelStyle: exerciseSmallTextStyle,
        currentIndex: _currentPageIndex,
        onTap: (selected) => setPage(selected),
        items: [
          BottomNavigationBarItem(
              icon: AppIcon.inactiveDashboard,
              activeIcon: AppIcon.activeDashboard,
              label: ''),
          BottomNavigationBarItem(
              icon: AppIcon.inactiveWorkout,
              activeIcon: AppIcon.activeWorkout,
              label: ''),
        ],
      ),
    );
  }
}
