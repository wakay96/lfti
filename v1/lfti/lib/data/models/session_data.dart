import 'package:lfti/data/models/session.dart';

class SessionsData {
  List<bool> daysWorkedOutThisWeek;
  Duration currentWorkoutDuration;
  Duration targetWorkoutDuration;
  Session previousSession;
  Session nextSession;

  SessionsData({
    this.daysWorkedOutThisWeek = const [
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ],
    this.currentWorkoutDuration,
    this.targetWorkoutDuration,
    this.previousSession,
    this.nextSession,
  });
}
