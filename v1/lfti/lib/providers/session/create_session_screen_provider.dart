import 'package:flutter/material.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/id_generator.dart';
import 'package:lfti/helpers/string_formatter.dart';
import 'package:lfti/providers/screen_provider.dart';

class CreateSessionScreenProvider extends ScreenProvider {
  List<Workout> workouts = [];
  Workout? selectedWorkout;

  final List<String> dayNames = [
    WeekdayNames.Sunday,
    WeekdayNames.Monday,
    WeekdayNames.Tuesday,
    WeekdayNames.Wednesday,
    WeekdayNames.Thursday,
    WeekdayNames.Friday,
    WeekdayNames.Saturday
  ];

  final List<bool> selectedDays = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  void initialize(BuildContext context) {
    super.initialize(context);
    workouts = repo.getAllWorkouts();
    notifyListeners();
  }

  List<String> getSelectedDays() {
    List<int> indices = [];
    for (int i = 0; i < selectedDays.length; i++)
      if (selectedDays[i]) indices.add(i);
    List<String> selection = indices.map((i) => dayNames[i]).toList();
    return selection;
  }

  String getSelectedDaysText() {
    return ListToString(getSelectedDays()).parse();
  }

  void toggleDay(int i) {
    selectedDays[i] = !selectedDays[i];
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

  void saveChanges() {
    Workout workout = Workout.clone(IdGenerator.generateV4(), selectedWorkout!);
    final Session session = Session(
        id: IdGenerator.generateV4(),
        schedule: getSelectedDays(),
        workout: workout);
    repo.addSession(session);
  }

  void updateEditedWorkout(int index, Workout replacement) {
    workouts.replaceRange(index, index + 1, [replacement]);
    notifyListeners();
  }
}
