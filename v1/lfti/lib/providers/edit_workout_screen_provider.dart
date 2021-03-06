import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/activity.dart';
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

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      // removing the item at oldIndex will shorten the list by 1.
      newIndex -= 1;
    }
    final Activity element = workout.activities.removeAt(oldIndex);
    workout.activities.insert(newIndex, element);
    notifyListeners();
  }

  void onSubmit() {}
}
