import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/models/user.dart';
import 'package:lfti/data/models/workout.dart';

abstract class IRepository {
  void addWorkout(Workout workout);
  void addExercise(Exercise exercise);
  void addSession(Session session);

  List<Activity> getUserActivities();
  List<Activity> getAllActivities();
  List<Workout> getAllWorkouts();
  List<Session> getAllSessions();
  List<Exercise> getExercisesByTarget(String type);

  Workout getWorkoutById(String id);
  Exercise getExerciseById(String id);
  Session getSessionById(String id);
  User getUser();

  void clearUserExerciseBank();
  void clearUserWorkoutBank();
  void clearUserSessionBank();
  void resetAllData();

  void deleteExerciseById(String id);
  void deleteWorkoutById(String id);
  void deleteSessionById(String id);

  void updateExerciseById(String id, Exercise update);
  void updateWorkoutById(String id, Workout update);
  void updateUser(User user);
  void updateSessionById(String id, Session session);
}
