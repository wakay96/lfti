import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/models/user.dart';
import 'package:lfti/data/models/workout.dart';

abstract class IRepository {
  /// Add workout to Workout Bank
  void addWorkout(Workout workout);

  /// Add exercise to Exercise Bank
  void addExercise(Exercise exercise);

  /// Add session to Session Bank
  void addSession(Session session);

  List<Workout> getAllWorkouts();
  Workout getWorkoutById(String uuid);
  List<Activity> getAllActivities();
  List<Activity> getUserActivities();
  Exercise getExerciseById(String id);
  User getUser();
  List<Session> getAllSessions();
  Session? getSessionById(String id);

  void clearUserExerciseBank();
  bool deleteExerciseById(String uuid);
  void clearUserWorkoutBank();
  bool deleteWorkoutById(String uuid);

  void updateExerciseById(String id, Exercise update);
  void updateWorkoutById(String id, Workout update);
  void updateUser(User user);
}
