import 'dart:io';

import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/date_time_info.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/models/session_data.dart';
import 'package:lfti/data/models/user_data.dart';
import 'package:lfti/data/models/user_info.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/helpers/app_enums.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/id_generator.dart';
import 'package:uuid/uuid.dart';

class MockRepository implements IRepository {
  List<Workout> _userWorkouts = [];
  List<Exercise> _userExercises = [];

  static UserData _userData = UserData(
    currentWeight: 153.5,
    targetWeight: 180.0,
    currentBodyFat: 21.2,
    targetBodyFat: 16,
    height: 67,
  );
  static UserInfo _userInfo = UserInfo(
      id: IdGenerator.generateV4(),
      firstName: 'Richmond',
      lastName: 'Escalona',
      email: 'iam@johnescalona.com');
  static SessionsData _sessionData = SessionsData(
    daysWorkedOutThisWeek: [false, false, true, false, true, false, false],
    currentWorkoutDuration: Duration(minutes: 30),
    targetWorkoutDuration: Duration(minutes: 60),
    previousSession: Session(
      datePerformed: DateTimeInfo(DateTime(2, 21, 2022)),
      duration: Duration(minutes: 20),
      workoutPerformed: Workout(
          name: 'W1',
          description: 'Description 1',
          targetBodyParts: [Target.Chest, Target.Arm, Target.Shoulder],
          id: IdGenerator.generateV4(),
          days: [WeekdayNames.Monday],
          activities: [..._sampleExercises]),
    ),
    nextSession: Session(
      datePerformed: DateTimeInfo(DateTime(2, 22, 2022)),
      duration: Duration(minutes: 20),
      workoutPerformed: Workout(
          name: 'W2',
          description: 'Description 2',
          targetBodyParts: [Target.Arm],
          id: IdGenerator.generateV4(),
          days: [WeekdayNames.Tuesday, WeekdayNames.Thursday],
          activities: [..._sampleExercises]),
    ),
  );

  /// Temporary Standard workouts
  /// to be requested form server
  /// once upon startup
  static List<Activity> _sampleExercises = [
    Exercise(name: 'RE1', setCount: 3, repCount: 10, target: Target.Chest),
    Exercise(name: 'RE2', setCount: 3, repCount: 12, target: Target.Back),
    Exercise(name: 'RE3', setCount: 3, repCount: 15, target: Target.Arm),
    Exercise(name: 'RE4', setCount: 3, repCount: 20, target: Target.Leg),
    Exercise(name: 'RE5', setCount: 3, repCount: 25, target: Target.Shoulder),
  ];

  static List<Workout> _sampleWorkouts = [
    Workout(
        id: IdGenerator.generateV4(),
        name: 'W1',
        description: 'W1 Description',
        targetBodyParts: [Target.Chest],
        days: [WeekdayNames.Monday],
        activities: [..._sampleExercises]),
    Workout(
        id: IdGenerator.generateV4(),
        name: 'W2',
        description: 'W2 Description',
        targetBodyParts: [Target.Leg],
        days: [WeekdayNames.Tuesday, WeekdayNames.Wednesday],
        activities: [..._sampleExercises]),
    Workout(
        id: IdGenerator.generateV4(),
        name: 'W3',
        description: 'W3 Description',
        targetBodyParts: [Target.Arm],
        days: [WeekdayNames.Thursday, WeekdayNames.Friday],
        activities: [..._sampleExercises]),
  ];

  @override
  void addExercise(Exercise exercise) {
    _userExercises.add(exercise);
  }

  @override
  void addWorkout(Workout workout) {
    _userWorkouts.add(workout);
  }

  @override
  UserData getUserData() {
    return _userData;
  }

  @override
  UserInfo getUserInfo() {
    return _userInfo;
  }

  /// Returns all available exercises
  /// only use for search functionality
  /// when adding activities for a workout
  @override
  List<Exercise> getAllExercises() {
    return [
      ..._sampleExercises,
      ..._userExercises,
    ];
  }

  @override
  List<Exercise> getUserExercises() {
    return _userExercises;
  }

  @override
  List<Workout> getAllWorkouts() {
    return _userWorkouts;
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
    var allExercises = getUserExercises();
    if (allExercises.isEmpty) {
      throw Exception(EMPTY_LIST_ERROR);
    } else {
      return allExercises.firstWhere(
        (item) => (item.id == id),
        orElse: () => throw Exception(ITEM_NOT_FOUND_ERROR),
      );
    }
  }

  @override
  SessionsData getSessionData() {
    return _sessionData;
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
          days: update.days);
    } catch (e) {
      throw e;
    }
  }

  @override
  void updateUserData(UserData update) {
    _userData = update;
  }

  @override
  void updateSessionData(SessionsData update) {
    _sessionData = update;
  }
}
