import 'dart:math';

import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/rest.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/models/user.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/id_generator.dart';

class SampleData {
  late List<Exercise> _chestExercises,
      _armExercises,
      _legExercises,
      _shoulderExercises,
      _backExercises,
      _coreExercises = [];
  late List<Workout> _workouts = [];
  late List<Session> _sessions = [];
  late User _user;
  late Session _prevSession;
  late Session _nextSession;

  SampleData() {
    /// User Data Start ///
    _user = User(
      id: IdGenerator.generateV4(),
      firstName: 'Richmond',
      lastName: 'Escalona',
      email: 'me@johnescalona.com',
      height: 5.583,
      currentBodyFat: 21.1,
      targetBodyFat: 16.0,
      currentWeight: 155.0,
      targetWeight: 180,
    );

    /// User Data End ///

    /// Exercises Start ///
    ///
    _chestExercises = [
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Incline Dumbbell Bench Press',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Dumbbell Bench Press',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Decline Dumbbell Bench Press',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Push Up',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Diamond Push Up',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Incline Barbel Bench Press',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Barbell Bench Press',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Decline Barbel Bench Press',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Close-Grip Bench Press',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Cable Cross-Over',
      ),
    ];

    _shoulderExercises = [
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Barbell Overhead Shoulder Press',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Seated Dumbbell Shoulder Press',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Front Raise',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Bent-Over Dumbbell Lateral Raise',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Dumbbell Lateral Raise',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Push Press',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Reverse Cable Crossover',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'One-Arm Cable Lateral Raise',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Standing Barbell Shrugs',
      ),
    ];

    _armExercises = [
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Hammer Curl',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Dip',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Close-Grip Curl',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Chin Up',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Suspension Trainer Triceps Extension',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Diamond Pushup',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Triceps Extension',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'EZ-Bar Preacher Curl',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Reverse Curl',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Wide-Grip Curl',
      )
    ];

    _backExercises = [
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Barbell Deadlift',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Bent-Over Barbell Row',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Wide-Grip Pull-Up',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Standing T-Bar Row',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Wide-Grip Seated Cable Row',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Reverse-Grip Smith Machine Row',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Close-Grip Pull-Down',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Single-Arm Dumbbell Row',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Decline Bench Dumbbell Pull-Over',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Single-Arm Smith Machine Row',
      ),
    ];

    _legExercises = [
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Barbell Bulgarian Split Squat',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Seated Dumbbell Calf Raise',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Romanian Deadlift',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Goblet Squat',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Barbell Side Lunge',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Good Morning',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Battle Ropes Reverse Lunge',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Kettlebell Pistol Squat',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Hip Thruster',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Single Leg Curl',
      ),
    ];

    _coreExercises = [
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Ball push-away',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Hanging knee raise',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Dumbbell plank drag',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Leg Raise',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Sit Ups',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Dead Bug',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Wall Plank',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Side Plank',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Flutter Kicks',
      ),
      Exercise(
        id: IdGenerator.generateV4(),
        name: 'Reverse Crunch',
      ),
    ];

    /// Exercises End ///

    /// Workout Start ///
    ///

    _workouts = [
      Workout(
          id: IdGenerator.generateV4(),
          activities: getActivities(Target.Chest),
          targetBodyParts: [Target.Chest],
          name: 'Chest Day',
          description:
              'Lorem ipsum dolor sit aet, consectetur adipiscing elit iscing elit.'),
      Workout(
          id: IdGenerator.generateV4(),
          activities: getActivities(Target.Leg),
          targetBodyParts: [Target.Leg],
          name: 'Leg Day',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elitet, consectetur adipiscing elit.'),
      Workout(
          id: IdGenerator.generateV4(),
          activities: getActivities(Target.Back),
          targetBodyParts: [Target.Back],
          name: 'Back Day',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.isplakitengteng '),
      Workout(
          id: IdGenerator.generateV4(),
          activities: getActivities(Target.Arm),
          targetBodyParts: [Target.Arm],
          name: 'Arm Day',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elisplakitengteng it.'),
      Workout(
          id: IdGenerator.generateV4(),
          activities: getActivities(Target.Shoulder),
          targetBodyParts: [Target.Shoulder],
          name: 'Shoulder Day',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscingisplakitengteng  elit.'),
      Workout(
          id: IdGenerator.generateV4(),
          activities: getActivities(Target.Core),
          targetBodyParts: [Target.Core],
          name: 'Core Day',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscisplakitengteng ing elit.'),
    ];

    /// Workout End ///

    /// Session Start ///
    ///

    _sessions = [
      Session(
          id: IdGenerator.generateV4(),
          schedule: [WeekdayNames.Monday],
          workout: _workouts[0]),
      Session(
          id: IdGenerator.generateV4(),
          schedule: [WeekdayNames.Tuesday],
          workout: _workouts[1]),
      Session(
          id: IdGenerator.generateV4(),
          schedule: [WeekdayNames.Wednesday],
          workout: _workouts[2]),
      Session(
          id: IdGenerator.generateV4(),
          schedule: [WeekdayNames.Thursday],
          workout: _workouts[3]),
      Session(
          id: IdGenerator.generateV4(),
          schedule: [WeekdayNames.Friday],
          workout: _workouts[4]),
      Session(
          id: IdGenerator.generateV4(),
          schedule: [WeekdayNames.Saturday],
          workout: _workouts[5]),
    ];

    _prevSession = Session(
        id: _sessions[0].id,
        schedule: _sessions[0].schedule,
        workout: _sessions[0].workout,
        duration: Duration(minutes: 45),
        performedExercises: [
          _workouts[0].activities[0],
          _workouts[0].activities[2],
          _workouts[0].activities[4],
          _workouts[0].activities[6],
          _workouts[0].activities[8],
        ],
        skippedExercises: [
          _workouts[0].activities[10],
        ]);

    _nextSession = Session(
      id: _sessions[1].id,
      schedule: _sessions[1].schedule,
      workout: _sessions[1].workout,
    );

    /// Session End ///
  }

  List<Activity> get chestExercises => _chestExercises;

  get armExercises => _armExercises;

  get legExercises => _legExercises;

  get shoulderExercises => _shoulderExercises;

  get backExercises => _backExercises;

  get coreExercises => _coreExercises;

  List<Workout> get workouts => _workouts;

  List<Session> get sessions => _sessions;

  User get user => _user;

  Session get prevSession => _prevSession;

  Session get nextSession => _nextSession;

  List<Activity> getActivities(String type, {int count = 8}) {
    switch (type) {
      case Target.Chest:
        return generateRandomActivitiesWithRest(chestExercises, count);
      case Target.Leg:
        return generateRandomActivitiesWithRest(legExercises, count);
      case Target.Arm:
        return generateRandomActivitiesWithRest(armExercises, count);
      case Target.Back:
        return generateRandomActivitiesWithRest(backExercises, count);
      case Target.Shoulder:
        return generateRandomActivitiesWithRest(shoulderExercises, count);
      case Target.Core:
        return generateRandomActivitiesWithRest(coreExercises, count);
      default:
        return <Activity>[];
    }
  }

  List<Activity> generateRandomActivitiesWithRest(List options, int count) {
    List<Activity> list = [];
    for (int i = 0; i < count; i++) {
      var rest = Rest(
          IdGenerator.generateV4(), Duration(seconds: Random().nextInt(120)));
      var index = Random().nextInt(options.length);
      var act = options[index] as Exercise;
      act.description =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
      act.setCount = 3;
      act.repCount = 12;
      list.add(options[index]);

      if (i < options.length - 1) list.add(rest);
    }
    return list;
  }
}
