import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/data/repository/i_repository.dart';

class WorkoutScreenProvider extends ChangeNotifier {
  IRepository _repository = GetIt.I<IRepository>();
  List<Workout> _workouts = [];

  List<Workout> get workouts => _workouts;

  void initializeData() {
    _workouts = _repository.getAllWorkouts();
    notifyListeners();
  }
}
