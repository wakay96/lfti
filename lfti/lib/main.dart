import 'package:flutter/material.dart';
import 'package:lfti/pages/routines_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          onBackground: Colors.black,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RoutinesPage(),
        // '/login': (context) => const LoginPage(),
        // '/signup': (context) => const SignupPage(),
        // '/profile': (context) => const ProfilePage(),
        // '/settings': (context) => const SettingsPage(),
        // '/about': (context) => const AboutPage(),
      },
    );
  }
}
