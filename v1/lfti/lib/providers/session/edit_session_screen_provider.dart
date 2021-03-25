import 'package:flutter/material.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/helpers/string_formatter.dart';
import 'package:lfti/providers/screen_provider.dart';

class EditSessionScreenProvider extends ScreenProvider {
  List<Activity> activities = [];
  String schedule = '';
  String? name;
  String? description;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool editMode = false;

  @override
  void initialize(BuildContext context) {
    super.initialize(context);
    final session = repo.getSessionById(args!['id']);
    if (session != null) {
      name = session.workout.name;
      schedule = ListToString(session.schedule).parse();
      description = session.workout.description;
      activities = session.workout.activities;
      nameController = TextEditingController(text: name);
      descriptionController = TextEditingController(text: description);
    } else {
      throw Exception('No session with ${args!['id']} found.');
    }
    notifyListeners();
  }

  void save() {
    toggleEditMode();
    notifyListeners();
  }

  void toggleEditMode() {
    editMode = !editMode;
    notifyListeners();
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
