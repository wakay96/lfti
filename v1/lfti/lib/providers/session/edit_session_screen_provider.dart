import 'package:flutter/material.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/helpers/string_formatter.dart';
import 'package:lfti/providers/screen_provider.dart';

class EditSessionScreenProvider extends ScreenProvider {
  List<Activity> activities = [];
  String schedule = '';
  String? name;
  String? description;
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
    } else {
      throw Exception('No session with ${args!['id']} found.');
    }
  }

  void saveChanges() {
    editMode = false;
    notifyListeners();
  }

  void enableEditMode() {
    editMode = true;
    notifyListeners();
  }
}
