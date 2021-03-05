import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/data/repository/i_repository.dart';

class EditWorkoutScreenProvider extends ChangeNotifier {
  final IRepository _repository = GetIt.I<IRepository>();
  String _workoutId;
  Workout workout;

  void initializeData(String id) {
    _workoutId = id;
    workout = _repository.getWorkoutById(_workoutId);
    notifyListeners();
  }

  void onSubmit() {}
}
