import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/screens/dashboard/dashboard_screen.dart';
import 'package:lfti/screens/workout/workout_view_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex;

  @override
  void initState() {
    _currentPageIndex = 0;
    super.initState();
  }

  void setPage(int index) {
    setState(() => _currentPageIndex = index);
  }

  List<Widget> _pages = [
    DashboardScreenBuilder(),
    WorkoutViewScreenBuilder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        shadowColor: Colors.transparent,
        title: Container(
          alignment: Alignment.bottomRight,
          child: Text(
            DASHBOARD_SCREEN_APPBAR_TEXT,
            style: appBarTitleTextStyleLight,
          ),
        ),
        centerTitle: false,
      ),
      backgroundColor: primaryColor,
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: secondaryColor.withAlpha(20),
        selectedLabelStyle: exerciseSmallTextStyle,
        unselectedItemColor: tertiaryColor,
        currentIndex: _currentPageIndex,
        onTap: (selected) => setPage(selected),
        items: [
          BottomNavigationBarItem(
            icon: AppIcon.workoutIcon,
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: AppIcon.workoutIcon, label: 'Workouts'),
        ],
      ),
    );
  }
}
