import 'package:flutter/material.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/helpers/id_generator.dart';
import 'package:lfti/providers/screen_provider.dart';

class CreateSessionScreenProvider extends ScreenProvider {
  List<Workout> workouts = [];
  Workout? selectedWorkout;

  @override
  void initialize(BuildContext context) {
    super.initialize(context);
    workouts = repo.getAllWorkouts();
    notifyListeners();
  }

  void setSelectedWorkout(Workout? workout) {
    if (workout == null) {
      selectedWorkout = null;
    } else {
      workout = workouts.firstWhere((item) => item.id == workout!.id);
      selectedWorkout = workout;
    }
    notifyListeners();
  }

  bool isSelectedWorkout(String id) {
    if (selectedWorkout != null) {
      return id == selectedWorkout?.id;
    } else {
      return false;
    }
  }

  void save() {
    Workout workout = Workout.clone(IdGenerator.generateV4(), selectedWorkout!);
    final Session session = Session.fromWorkout(
      id: IdGenerator.generateV4(),
      schedule: [],
      workout: workout,
    );
    repo.addSession(session);
  }

  void refresh() {
    notifyListeners();
  }
}
