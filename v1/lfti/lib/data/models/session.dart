import 'package:lfti/data/models/workout.dart';
import 'activity.dart';

class Session {
  String id;
  late List<Activity> activities;
  late String name;
  List<String> schedule;
  String? description;

  /// Contains data for previous Session
  Duration? duration;
  List<Activity>? performedExercises;
  List<Activity>? skippedExercises;

  Session({
    required this.id,
    required this.schedule,
    required this.activities,
    required this.name,
    this.description,
    this.duration,
    this.performedExercises,
    this.skippedExercises,
  });

  Session.fromWorkout({
    required this.id,
    required Workout workout,
    required this.schedule,
  }) {
    name = workout.name;
    description = workout.description;
    activities = workout.activities;
  }
}
