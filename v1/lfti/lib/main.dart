import 'package:flutter/material.dart';
import 'package:lfti/screens/session/create_session_screen.dart';
import 'package:lfti/screens/workout/create_workout_screen.dart';
import 'package:lfti/screens/session/edit_session_screen.dart';
import 'package:lfti/screens/session/session_screen.dart';
import 'package:lfti/screens/workout/edit_workout_screen.dart';
import 'package:lfti/services/app_manager.dart';

void main() {
  AppManager().registerServices();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'lfti',
      initialRoute: SessionScreen.id,
      routes: {
        SessionScreen.id: (context) => SessionScreenBuilder(),
        EditSessionScreen.id: (context) => EditSessionScreenBuilder(),
        CreateWorkoutScreen.id: (context) => CreateWorkoutScreenBuilder(),
        CreateSessionScreen.id: (context) => CreateSessionScreenBuilder(),
        EditWorkoutScreen.id: (context) => EditWorkoutScreenBuilder()
      },
    );
  }
}
