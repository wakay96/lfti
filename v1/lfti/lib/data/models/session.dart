import 'package:lfti/data/models/workout.dart';
import 'activity.dart';

class Session {
  String? id;
  late List<Activity> activities;
  late String name;
  List<String> schedule;
  String? description;

  /// Contains data for previous Session
  Duration? duration;
  List<Activity>? performedExercises;
  List<Activity>? skippedExercises;

  Session({
    this.id,
    required this.schedule,
    required this.activities,
    required this.name,
    this.description,
    this.duration,
    this.performedExercises,
    this.skippedExercises,
  });

  Session.fromWorkout({
    this.id,
    required Workout workout,
    required this.schedule,
  }) {
    List<Activity> act = workout.activities;
    name = workout.name;
    description = workout.description;
    activities = act;
  }
}
