import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/shared/workout_list.dart';
import 'edit_session_screen.dart';

class SelectSessionWorkoutScreen extends StatelessWidget {
  static final String id = 'CreateSessionScreen';
  static final String title = 'Create Session';

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
            Navigator.pushNamed(
              context,
              EditSessionScreen.id,
              arguments: {'data': workout},
            );
          }),
    );
  }
}
