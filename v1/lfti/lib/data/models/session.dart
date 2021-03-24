import 'package:lfti/data/models/workout.dart';
import 'activity.dart';

class Session {
  String id;
  List<String> schedule;
  Workout workout;

  /// Contains data for previous Session
  Duration? duration;
  List<Activity>? performedExercises;
  List<Activity>? skippedExercises;

  Session({
    required this.id,
    required this.schedule,
    this.duration,
    required this.workout,
    this.performedExercises,
    this.skippedExercises,
  });
}
