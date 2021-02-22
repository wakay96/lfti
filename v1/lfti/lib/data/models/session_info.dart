import 'package:lfti/data.models/workout.dart';

import 'date_time_info.dart';

class SessionInfo {
  List<String> daysWorkedOut = [];
  Duration durationWorkedOutToday;
  Session previousSession;
  Session currentSession;
}

class Session {
  DateTimeInfo datePerformed;
  Duration duration;
  Workout workoutPerformed;
}
