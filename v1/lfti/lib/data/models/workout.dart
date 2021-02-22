import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/helpers/app_enums.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/id_generator.dart';

class Workout {
  String id;
  List<Activity> activities;
  List<WeekdayNames> days;
  List<Target> targetBodyParts;
  String name;
  String description;

  /// Default Constructor
  Workout({
    @required this.id,
    @required this.activities,
    @required this.days,
    @required this.targetBodyParts,
    @required this.name,
    @required this.description,
  });

  /// Empty constructor
  /// use for initializing an empty workout
  Workout.empty() {
    id = IdGenerator.generateV4();
    activities = [];
    days = [];
    targetBodyParts = [];
    name = DEFAULT_WORKOUT_NAME;
    description = DEFAULT_WORKOUT_DESC;
  }

  /// Copy Constructor
  Workout.clone(Workout workout) {
    id = IdGenerator.generateV4();
    activities = workout.activities;
    days = workout.days;
    targetBodyParts = workout.targetBodyParts;
    name = workout.name;
    description = workout.description;
  }
}