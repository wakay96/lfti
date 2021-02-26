import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/providers/workout_screen_provider.dart';
import 'package:lfti/shared/nav_bar.dart';
import 'package:provider/provider.dart';

class WorkoutScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WorkoutScreenProvider>(
      create: (BuildContext context) => WorkoutScreenProvider(),
      child: WorkoutScreen(),
    );
  }
}

class WorkoutScreen extends StatefulWidget {
  static const String id = "WorkoutScreen";
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(WORKOUT_SCREEN_APPBAR_TEXT).build(context),
      body: Container(),
    );
  }
}
