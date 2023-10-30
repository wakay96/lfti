import 'package:exercises_api/exercises_api.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lfti/pages/routine_pages/add_routine.dart';
import 'package:lfti/pages/routine_pages/exercise_list_page.dart';
import 'package:lfti/pages/routine_pages/routine_details_page.dart';
import 'package:lfti/pages/home_page.dart';
import 'package:lfti/pages/routine_pages/exercise_details_page.dart';
import 'package:lfti/pages/routine_pages/add_exercise_details_page.dart';
import 'package:lfti/pages/session_page.dart';
import 'package:routines_api/routines_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
      builder: EasyLoading.init(),
      initialRoute: HomePage.path,
      routes: {
        HomePage.path: (context) => const HomePage(),
        AddRoutinePage.path: (context) => const AddRoutinePage(),
        ExerciseListPage.path: (context) => const ExerciseListPage(),
        RoutineDetailsPage.path: (context) {
          final Routine args =
              ModalRoute.of(context)?.settings.arguments as Routine;
          return RoutineDetailsPage(routine: args);
        },
        ExerciseDetailsPage.path: (context) {
          final Exercise args =
              ModalRoute.of(context)?.settings.arguments as Exercise;
          return ExerciseDetailsPage(exercise: args);
        },
        AddExerciseDetailsPage.path: (context) {
          final Exercise args =
              ModalRoute.of(context)?.settings.arguments as Exercise;
          return AddExerciseDetailsPage(exercise: args);
        },
        SessionPage.path: (context) {
          final Routine args =
              ModalRoute.of(context)?.settings.arguments as Routine;
          return SessionPage(routine: args);
        },
        // LoginPage.id: (context) =>  LoginPage(),
        // SignupPage.id: (context) =>  SignupPage(),
        // SettingsPage.id: (context) =>  SettingsPage(),
        // AboutPage.id: (context) =>  AboutPage(),
      },
    );
  }
}
