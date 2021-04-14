import 'package:flutter/material.dart';
import 'package:lfti/screens/activity/select_exercise_screen.dart';
import 'package:lfti/screens/session/create_session_screen.dart';
import 'package:lfti/screens/session/session_workout_screen.dart';
import 'package:lfti/screens/session/edit_session_screen.dart';
import 'package:lfti/screens/session/session_screen.dart';
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
      initialRoute: ExerciseScreen.id,
      routes: {
        SessionScreen.id: (context) => SessionScreenBuilder(),
        EditSessionScreen.id: (context) => EditSessionScreenBuilder(),
        SelectSessionWorkoutScreen.id: (context) =>
            SelectSessionWorkoutScreen(),
        CreateSessionScreen.id: (context) => CreateSessionScreenBuilder(),
        ExerciseScreen.id: (context) => ExerciseScreenBuilder()
      },
    );
  }
}
