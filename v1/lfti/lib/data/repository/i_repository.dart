import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/user_data.dart';
import 'package:lfti/data/models/workout.dart';

abstract class IRepository {
  /// Add workout to Workout Bank
  void addWorkout(Workout workout);

  /// Add exercise to Exercise Bank
  void addExercise(Exercise exercise);

  List<Workout> getAllWorkouts();
  Workout getWorkoutById(String uuid);
  List<Exercise> getAllExercises();
  List<Exercise> getUserExercises();
  Exercise getExerciseById(String uuid);
  UserData getUserData();

  void clearUserExerciseBank();
  bool deleteExerciseById(String uuid);
  void clearUserWorkoutBank();
  bool deleteWorkoutById(String uuid);

  void updateExerciseById(String id, Exercise update);
  void updateWorkoutById(String id, Workout update);
  void updateUserData(UserData userData);
}
