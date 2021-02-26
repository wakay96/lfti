import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/workout.dart';
import 'date_time_info.dart';

class Session {
  String id;
  DateTimeInfo datePerformed;
  Duration duration;
  Workout workout;
  List<Exercise> performedExercises;
  List<Exercise> skippedExercises;

  Session({
    this.id,
    this.datePerformed,
    this.duration,
    this.workout,
    this.performedExercises = const <Exercise>[],
    this.skippedExercises = const <Exercise>[],
  });
}
