import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/data/repository/i_repository.dart';

class WorkoutScreenProvider extends ChangeNotifier {
  IRepository _repository;
  List<Workout> workouts;

  WorkoutScreenProvider() {
    _repository = GetIt.I<IRepository>();
    workouts = _repository.getAllWorkouts();
  }
}
