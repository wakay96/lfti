import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/models/user.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/data/repository/data.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/helpers/app_strings.dart';

class MockRepository implements IRepository {
  final data = SampleData();
  late List<Activity> _userExercises;
  late List<Workout> _userWorkouts;
  late List<Session> _userSessions;
  late User _user;

  MockRepository() {
    _userExercises = [
      ...data.coreExercises,
      ...data.armExercises,
      ...data.backExercises,
      ...data.chestExercises,
      ...data.legExercises,
      ...data.shoulderExercises
    ];

    _userWorkouts = data.workouts;
    _userSessions = data.sessions;
    _user = data.user;
  }

  @override
  void addExercise(Exercise exercise) {
    _userExercises.add(exercise);
  }

  @override
  void addWorkout(Workout workout) {
    _userWorkouts.add(workout);
  }

  @override
  User getUser() {
    return _user;
  }

  /// Returns all available exercises
  /// only use for search functionality
  /// when adding activities for a workout
  @override
  List<Activity> getAllActivities() {
    return [..._userExercises];
  }

  @override
  List<Activity> getUserActivities() {
    return [..._userExercises];
  }

  @override
  List<Workout> getAllWorkouts() {
    return [..._userWorkouts];
  }

  @override
  Workout getWorkoutById(String id) {
    if (_userWorkouts.isEmpty) {
      throw Exception(EMPTY_LIST_ERROR);
    }
    return _userWorkouts.firstWhere(
      (item) => (item.id == id),
      orElse: () => throw Exception(ITEM_NOT_FOUND_ERROR),
    );
  }

  @override
  Exercise getExerciseById(String id) {
    var allExercises = getUserActivities();
    if (allExercises.isEmpty) {
      throw Exception(EMPTY_LIST_ERROR);
    } else {
      return allExercises.firstWhere(
        (item) => (item.id == id),
        orElse: () => throw Exception(ITEM_NOT_FOUND_ERROR),
      ) as Exercise;
    }
  }

  @override
  void clearUserExerciseBank() {
    _userExercises.clear();
  }

  @override
  void clearUserWorkoutBank() {
    _userWorkouts.clear();
  }

  @override
  bool deleteExerciseById(String id) {
    try {
      var item = getExerciseById(id);
      _userExercises.remove(item);
      return true;
    } catch (e) {
      throw e;
    }
  }

  @override
  bool deleteWorkoutById(String id) {
    try {
      var item = getWorkoutById(id);
      _userWorkouts.remove(item);
      return true;
    } catch (e) {
      throw e;
    }
  }

  @override
  void updateExerciseById(String id, Exercise update) {
    try {
      int index = _userExercises.indexOf(getExerciseById(id));
      _userExercises[index] = Exercise(
        id: id,
        name: update.name,
        setCount: update.setCount,
        repCount: update.repCount,
        description: update.description,
        target: update.target,
      );
    } catch (e) {
      throw e;
    }
  }

  @override
  void updateWorkoutById(String id, Workout update) {
    try {
      int index = _userWorkouts.indexOf(getWorkoutById(id));
      _userWorkouts[index] = Workout(
        id: id,
        name: update.name,
        description: update.description,
        activities: update.activities,
        targetBodyParts: update.targetBodyParts,
      );
    } catch (e) {
      throw e;
    }
  }

  @override
  void updateUser(User update) {
    _user = update;
  }

  @override
  List<Session> getAllSessions() {
    return [..._userSessions];
  }

  @override
  Session getSessionById(String id) {
    return _userSessions.firstWhere((item) => item.id == id,
        orElse: () => throw Exception(ITEM_NOT_FOUND_ERROR));
  }

  @override
  void addSession(Session session) {
    _userSessions.add(session);
  }

  @override
  void resetAllData() {
    _userExercises = [];
    _userWorkouts = [];
    _userSessions = [];
  }

  @override
  void updateSessionById(String id, Session update) {
    try {
      Session session = update;
      session.id = id;
      int index = _userSessions.indexOf(getSessionById(id));
      _userSessions[index] = session;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
