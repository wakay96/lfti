import 'package:lfti/data/models/workout.dart';
import 'date_time_info.dart';

class Session {
  String id;
  DateTimeInfo datePerformed;
  Duration duration;
  Workout workout;

  Session({
    this.id,
    this.datePerformed,
    this.duration,
    this.workout,
  });
}
