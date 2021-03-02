import 'package:flutter/material.dart';
import 'package:lfti/screens/dashboard/dashboard_screen.dart';
import 'package:lfti/screens/workout/workout_history_screen.dart';
import 'package:lfti/screens/workout/workout_view_screen.dart';
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
      initialRoute: WorkoutViewScreen.id,
      routes: {
        DashboardScreen.id: (context) => DashboardScreenBuilder(),
        WorkoutViewScreen.id: (context) => WorkoutViewScreenBuilder(),
        WorkoutHistoryScreen.id: (context) => WorkoutHistoryScreen(),
      },
    );
  }
}
