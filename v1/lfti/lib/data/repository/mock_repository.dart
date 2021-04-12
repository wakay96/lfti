import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/models/user.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/data/repository/data.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/helpers/id_generator.dart';

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
    _userWorkouts = [...data.workouts];
    _userSessions = [...data.sessions];
    _user = data.user;
  }

  /// ------------------------------ ADD ------------------------------ ///
  ///                                                                   ///
  @override
  void addExercise(Exercise exercise) {
    _userExercises.add(exercise);
  }

  @override
  void addWorkout(Workout workout) {
    _userWorkouts.add(workout);
  }

  @override
  void addSession(Session session) {
    session.id = IdGenerator.generateV4();
    _userSessions.add(session);
  }

  ///                                                                   ///
  /// ----------------------------- ADD ------------------------------- ///
  ///                                                                   ///
  /// ----------------------------- GET ------------------------------- ///
  ///

  @override
  User getUser() {
    return _user;
  }

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
  List<Session> getAllSessions() {
    return [..._userSessions];
  }

  /// Returns existing exercise
  /// throws Exception if DNE
  @override
  Exercise getExerciseById(String id) {
    try {
      Exercise exercise =
          _userExercises.firstWhere((item) => item.id == id) as Exercise;
      return exercise;
    } catch (e) {
      throw e;
    }
  }

  /// Returns existing Workout
  /// throws Exception if DNE
  @override
  Workout getWorkoutById(String id) {
    try {
      Workout workout = _userWorkouts.firstWhere((element) => element.id == id);
      return workout;
    } catch (e) {
      throw e;
    }
  }

  /// Returns existing Session
  /// throws Exception if DNE
  @override
  Session getSessionById(String id) {
    try {
      Session session = _userSessions.firstWhere((item) => item.id == id);
      return session;
    } catch (e) {
      throw e;
    }
  }

  ///                                                                   ///
  /// ----------------------------- GET ------------------------------- ///
  ///                                                                   ///
  /// ---------------------------- DELETE ----------------------------- ///
  ///                                                                   ///

  /// Delete existing Exercise
  /// throws Exception if DNE
  @override
  void deleteExerciseById(String id) {
    try {
      var item = getExerciseById(id);
      _userExercises.remove(item);
    } catch (e) {
      throw e;
    }
  }

  /// Delete existing Workout
  /// throws Exception if DNE
  @override
  void deleteWorkoutById(String id) {
    try {
      var item = getWorkoutById(id);
      _userWorkouts.remove(item);
    } catch (e) {
      throw e;
    }
  }

  /// Delete existing Session
  /// throws Exception if DNE
  @override
  void deleteSessionById(String id) {
    try {
      var item = getSessionById(id);
      _userSessions.remove(item);
    } catch (e) {
      throw e;
    }
  }

  ///                                                                   ///
  /// ---------------------------- DELETE ----------------------------- ///
  ///                                                                   ///
  /// ---------------------------- UPDATE ----------------------------- ///
  ///                                                                   ///

  @override
  void updateExerciseById(String id, Exercise update) {
    try {
      Exercise exercise = getExerciseById(id);
      int index = _userExercises.indexOf(exercise);
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
  void updateSessionById(String id, Session update) {
    Session newSession = update;
    newSession.id = id;
    try {
      Session? existingSession = getSessionById(id);
      int index = _userSessions.indexOf(existingSession);
      _userSessions[index] = newSession;
    } catch (e) {
      throw e;
    }
  }

  @override
  void updateUser(User update) {
    _user = update;
  }

  ///                                                                   ///
  /// ---------------------------- UPDATE ----------------------------- ///
  ///                                                                   ///
  /// ---------------------------- CLEAR ------------------------------ ///
  ///                                                                   ///

  @override
  void resetAllData() {
    clearUserExerciseBank();
    clearUserWorkoutBank();
    clearUserSessionBank();
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
  void clearUserSessionBank() {
    _userSessions.clear();
  }

  ///                                                                   ///
  /// ---------------------------- CLEAR ----------------------------- ///
}
