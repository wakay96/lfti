import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/data/repository/i_repository.dart';

class WorkoutScreenProvider extends ChangeNotifier {
  IRepository _repository;

  WorkoutScreenProvider() {
    _repository = GetIt.I<IRepository>();
  }

  List<Workout> get workouts {
    return _repository.getAllWorkouts();
  }
}
