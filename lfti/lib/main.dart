import 'package:flutter/material.dart';
import 'package:lfti/constants/enums.dart';
import 'package:lfti/models/exercise.dart';
import 'package:lfti/models/routine.dart';
import 'package:lfti/pages/routine_pages/routine_details_page.dart';
import 'package:lfti/pages/page_container.dart';
import 'package:lfti/pages/routine_pages/exercise_details_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lfti',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          onBackground: Colors.black,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: HomePage.path,
      routes: {
        HomePage.path: (context) => const HomePage(),
        AppSubPage.routineDetails.path: (context) {
          final Routine args =
              ModalRoute.of(context)?.settings.arguments as Routine;
          return RoutineDetailsPage(routine: args);
        },
        AppSubPage.exerciseDetails.path: (context) {
          final Exercise args =
              ModalRoute.of(context)?.settings.arguments as Exercise;
          return ExerciseDetailsPage(exercise: args);
        },
        // LoginPage.id: (context) =>  LoginPage(),
        // SignupPage.id: (context) =>  SignupPage(),
        // SettingsPage.id: (context) =>  SettingsPage(),
        // AboutPage.id: (context) =>  AboutPage(),
      },
    );
  }
}
