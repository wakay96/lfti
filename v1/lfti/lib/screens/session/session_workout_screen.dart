import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/screens/session/create_session_screen.dart';
import 'package:lfti/shared/workout_list.dart';

class SelectSessionWorkoutScreen extends StatelessWidget {
  static final String id = 'SelectSessionWorkoutScreen';
  static final String title = 'Workouts';

  final repo = GetIt.instance<IRepository>();
  @override
  Widget build(BuildContext context) {
    final workouts = repo.getAllWorkouts();
    return Scaffold(
      appBar: AppBar(
        title: Text(SelectSessionWorkoutScreen.title),
      ),
      body: WorkoutList(
          workouts: workouts,
          onTap: (Workout workout) {
            Navigator.pushNamed(context, CreateSessionScreen.id,
                arguments: {'data': workout});
          }),
    );
  }
}
