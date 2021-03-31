import 'package:flutter/material.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/helpers/id_generator.dart';
import 'package:lfti/providers/screen_provider.dart';

class EditWorkoutScreenProvider extends ScreenProvider {
  late String id;
  String name = '';
  String description = '';
  List<Activity> activities = [];
  bool editMode = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initialize(BuildContext context) {
    super.initialize(context);
    id = IdGenerator.generateV4();
    Workout w = args!['data'] as Workout;
    name = w.name;
    description = w.description ?? description;
    activities = w.activities;
    nameController = TextEditingController(text: name);
    descriptionController = TextEditingController(text: description);
    notifyListeners();
  }

  void toggleEditMode() {
    editMode = !editMode;
    notifyListeners();
  }

  void save() {
    Workout workout = _generateWorkout();
    repo.updateWorkoutById(id, workout);
  }

  Workout _generateWorkout() {
    final targetBodyParts = Set<String>();
    activities.forEach((element) {
      if (element is Exercise && element.target != null) {
        targetBodyParts.add(element.target!);
      }
    });
    return Workout(
        id: IdGenerator.generateV4(),
        activities: activities,
        targetBodyParts: targetBodyParts.toList(),
        name: name,
        description: description);
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    final Activity element = activities.removeAt(oldIndex);
    activities.insert(newIndex, element);
    notifyListeners();
  }

  void updateName(String val) {
    name = val;
    notifyListeners();
  }

  void updateDescription(String val) {
    description = val;
    notifyListeners();
  }
}
