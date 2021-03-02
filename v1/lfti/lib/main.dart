import 'package:flutter/material.dart';
import 'package:lfti/screens/dashboard/dashboard_screen.dart';
import 'package:lfti/screens/workout/workout_history_screen.dart';
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
      initialRoute: WorkoutScreen.id,
      routes: {
        DashboardScreen.id: (context) => DashboardScreenBuilder(),
        WorkoutScreen.id: (context) => WorkoutScreenBuilder(),
        WorkoutHistoryScreen.id: (context) => WorkoutHistoryScreen(),
      },
    );
  }
}
