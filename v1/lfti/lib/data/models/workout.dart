import 'dart:core';
import 'package:lfti/data/models/activity.dart';

class Workout {
  late String id;
  late List<Activity> activities;
  late List<String> targetBodyParts;
  late String name;
  String? description;

  /// Default Constructor
  Workout({
    required this.id,
    required this.activities,
    required this.targetBodyParts,
    required this.name,
    this.description,
  });

  Workout.clone(String id, Workout workout) {
    this.id = id;
    this.name = workout.name;
    this.description = workout.description;
    this.activities = workout.activities;
    this.targetBodyParts = workout.targetBodyParts;
  }
}
