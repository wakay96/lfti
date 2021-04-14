import 'package:flutter/material.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/helpers/id_generator.dart';
import 'package:lfti/providers/session/new_session_screen_provider.dart';

class CreateSessionScreenProvider extends NewSessionScreenProvider {
  @override
  void initialize(BuildContext context) {
    super.initialize(context);
    id = IdGenerator.generateV4();
    Workout workout = args['data'] as Workout;
    scheduleSelection = [false, false, false, false, false, false, false];
    activities = [...workout.activities];
    name = workout.name;
    description = workout.description;
    nameController = TextEditingController(text: name);
    descriptionController = TextEditingController(text: description);
    notifyListeners();
  }
}
