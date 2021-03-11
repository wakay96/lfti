import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/date_time_info.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/rest.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/models/session_data.dart';
import 'package:lfti/data/models/user_data.dart';
import 'package:lfti/data/models/user_info.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/id_generator.dart';

class MockRepository implements IRepository {
  List<Workout> _userWorkouts = [
    Workout(
        name: 'Chest Superset',
        description: 'Description 1',
        targetBodyParts: [Target.Chest],
        id: IdGenerator.generateV4(),
        activities: [..._sampleActivityList]),
    Workout(
        name: 'Chest Workout',
        description: 'Description 2',
        targetBodyParts: [Target.Chest],
        id: IdGenerator.generateV4(),
        activities: _sampleActivityList),
    Workout(
        name: 'Chest Superset with Arms and Shoulders',
        description: 'Description 3',
        targetBodyParts: [Target.Chest, Target.Arm, Target.Shoulder],
        id: IdGenerator.generateV4(),
        activities: _sampleActivityList),
    Workout(
        name: 'Leg Superset with Shoulders',
        description: 'Description 4',
        targetBodyParts: [Target.Leg, Target.Shoulder],
        id: IdGenerator.generateV4(),
        activities: _sampleActivityList),
    Workout(
        name: 'Chest Superset with Arms , Core and Shoulders',
        description: 'Description 5',
        targetBodyParts: [
          Target.Chest,
          Target.Arm,
          Target.Shoulder,
          Target.Core
        ],
        id: IdGenerator.generateV4(),
        activities: _sampleActivityList),
  ];

  List<Exercise> _userExercises = [
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'E1',
        setCount: 3,
        repCount: 10,
        target: Target.Chest),
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'E2',
        setCount: 3,
        repCount: 12,
        target: Target.Back),
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'E3',
        setCount: 3,
        repCount: 15,
        target: Target.Arm),
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'E4',
        setCount: 3,
        repCount: 20,
        target: Target.Leg),
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'E5',
        setCount: 3,
        repCount: 25,
        target: Target.Shoulder),
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'E6',
        setCount: 3,
        repCount: 10,
        target: Target.Chest),
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'E7',
        setCount: 3,
        repCount: 12,
        target: Target.Back),
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'E8',
        setCount: 3,
        repCount: 15,
        target: Target.Arm),
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'E9',
        setCount: 3,
        repCount: 20,
        target: Target.Leg),
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'E10',
        setCount: 3,
        repCount: 25,
        target: Target.Shoulder)
  ];

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
        date: DateTimeInfo(DateTime(2022, 2, 21)),
        duration: Duration(minutes: 20),
        workout: Workout(
            name: 'Chest Superset with Arms and Shoulders',
            description: 'Description 1',
            targetBodyParts: [Target.Chest, Target.Arm, Target.Shoulder],
            id: IdGenerator.generateV4(),
            activities: _sampleActivityList),
        performedExercises: [
          _sampleActivityList[0],
          _sampleActivityList[4],
          _sampleActivityList[6],
        ],
        skippedExercises: [
          _sampleActivityList[2],
          _sampleActivityList[8],
        ]),
    nextSession: Session(
      date: DateTimeInfo(DateTime(
        2022,
        2,
        22,
      )),
      duration: Duration(minutes: 35),
      workout: Workout(
          name: 'Arm Day with Core',
          description: 'Description 2',
          targetBodyParts: [Target.Arm, Target.Core],
          id: IdGenerator.generateV4(),
          activities: _sampleActivityList),
    ),
  );

  static List<Activity> _sampleActivityList = [
    _sampleExercises[0],
    Rest(30, id: IdGenerator.generateV4()),
    _sampleExercises[1],
    Rest(35, id: IdGenerator.generateV4()),
    _sampleExercises[2],
    Rest(40, id: IdGenerator.generateV4()),
    _sampleExercises[3],
    Rest(60, id: IdGenerator.generateV4()),
    _sampleExercises[4],
  ];

  /// Temporary Standard workouts
  /// to be requested form server
  /// once upon startup
  static List<Activity> _sampleExercises = [
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'Supermans',
        setCount: 3,
        repCount: 10,
        target: Target.Back),
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'Push-up',
        setCount: 3,
        repCount: 12,
        target: Target.Chest),
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'Contralateral Limb Raises',
        setCount: 3,
        repCount: 15,
        target: Target.Leg),
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'Bent Knee Push-up',
        setCount: 3,
        repCount: 20,
        target: Target.Chest),
    Exercise(
        id: IdGenerator.generateV4(),
        name: 'Downward-facing Dog',
        setCount: 3,
        repCount: 25,
        target: Target.Core),
    Exercise(
        id: IdGenerator.generateV4(),
        name: ' Push-up with Single-leg Raise',
        setCount: 3,
        repCount: 25,
        target: Target.Leg),
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
      );
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
