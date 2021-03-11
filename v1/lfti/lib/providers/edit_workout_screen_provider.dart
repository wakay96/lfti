import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/data/repository/i_repository.dart';

class EditWorkoutScreenProvider extends ChangeNotifier {
  final IRepository _repository = GetIt.I<IRepository>();
  String _workoutId;
  Workout workout;
  TextEditingController nameTextController;
  TextEditingController descriptionTextController;

  void initializeData(String id) {
    _workoutId = id;
    workout = _repository.getWorkoutById(_workoutId);

    nameTextController = TextEditingController(text: workout.name);
    descriptionTextController =
        TextEditingController(text: workout.description);
    notifyListeners();
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Activity element = workout.activities.removeAt(oldIndex);
    workout.activities.insert(newIndex, element);
    notifyListeners();
  }

  void onUpdateActivity(Activity update) {
    try {
      Activity activity =
          workout.activities.firstWhere((element) => element.id == update.id);
      int index = workout.activities.indexOf(activity);
      workout.activities[index] = update;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void onUpdateName(String update) {
    workout.name = update;
    notifyListeners();
  }

  void onUpdateDescription(String update) {
    workout.description = update;
    notifyListeners();
  }

  void deleteActivity(String id) {
    var act = workout.activities.firstWhere((element) => element.id == id);
    workout.activities.removeAt(workout.activities.indexOf(act));
    notifyListeners();
  }

  void undoDelete(int index, Activity act) {
    workout.activities.insert(index, act);
    notifyListeners();
  }

  void onSubmit() {
    _repository.updateWorkoutById(_workoutId, workout);
  }
}
