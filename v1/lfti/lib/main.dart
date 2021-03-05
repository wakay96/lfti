import 'package:flutter/material.dart';
import 'package:lfti/screens/dashboard/dashboard_screen.dart';
import 'package:lfti/screens/home/home_screen.dart';
import 'package:lfti/screens/workout/edit_workout_screen.dart';
import 'package:lfti/screens/workout/view_workout_history_screen.dart';
import 'package:lfti/screens/workout/workout_screen.dart';
import 'package:lfti/services/app_manager.dart';

void main() {
  AppManager().registerServices();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lfti',
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        DashboardScreen.id: (context) => DashboardScreenBuilder(),
        WorkoutScreen.id: (context) => WorkoutScreenBuilder(),
        EditWorkoutScreen.id: (context) => EditWorkoutScreenBuilder(),
        ViewWorkoutHistoryScreen.id: (context) => ViewWorkoutHistoryScreen(),
      },
    );
  }
}
