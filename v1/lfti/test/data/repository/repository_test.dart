import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/date_time_info.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/rest.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/models/session_data.dart';
import 'package:lfti/data/models/user_data.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/id_generator.dart';

void repositoryTest() {
  group('Repository Class', () {
    var getIt = GetIt.instance;
    IRepository repository;

    /// TEST DATA
    Exercise e0;
    Exercise e3;
    Exercise e2;
    Exercise e1;
    Rest r15 = Rest(15);
    Rest r30 = Rest(30);
    Workout w = Workout.empty();

    setUp(() {
      repository = getIt<IRepository>();
      repository.clearUserExerciseBank();
      repository.clearUserWorkoutBank();
      e0 =
          Exercise(name: 'E0', setCount: 3, repCount: 10, target: Target.Chest);
      e3 = Exercise(name: 'E3', setCount: 3, repCount: 12, target: Target.Back);
      e2 = Exercise(name: 'E2', setCount: 3, repCount: 15, target: Target.Arm);
      e1 = Exercise(name: 'E1', setCount: 3, repCount: 20, target: Target.Leg);
    });

    group('ADD', () {
      test('addExercise - exercises length == 1', () {
        var previous = repository.getAllExercises();
        repository.addExercise(e1);
        var res = repository.getAllExercises();
        expect(1, res.length - previous.length);
      });

      test('addWorkout - should add 1 workout', () {
        repository.addWorkout(w);
        var res = repository.getAllWorkouts();
        expect(1, res.length);
      });

      test('addWorkout - should add 2 workout', () {
        repository.addWorkout(w);
        var res = repository.getAllWorkouts();
        expect(1, res.length);
      });
    });

    group('GET', () {
      group('getAllWorkouts', () {
        test(' - no workouts, should return empty list', () {
          var res = repository.getAllWorkouts();
          expect(true, res.isEmpty);
        });

        test(' - workouts exist, should return non-empty list', () {
          repository.addWorkout(w);
          repository.addWorkout(w);
          repository.addWorkout(w);
          var res = repository.getAllWorkouts();
          expect(true, res.isNotEmpty);
        });
      });

      group('getWorkoutById', () {
        test(' - workouts exist, should return found workout', () {
          var woId = IdGenerator.generateV4();
          repository.addWorkout(Workout.empty());
          repository.addWorkout(Workout.empty());
          repository.addWorkout(Workout(
              id: woId,
              name: 'Found me',
              description: '',
              activities: [],
              days: [],
              targetBodyParts: []));
          repository.addWorkout(Workout.empty());
          var res = repository.getWorkoutById(woId);
          expect(res.name, 'Found me');
        });
        test(' - no workouts, should throw exception', () {
          expect(() => repository.getWorkoutById(IdGenerator.generateV4()),
              throwsA(isInstanceOf<Exception>()));
        });

        test(' - workout not found, should throw exception', () {
          repository.addWorkout(Workout.empty());
          repository.addWorkout(Workout.empty());
          repository.addWorkout(Workout.empty());
          expect(() => repository.getWorkoutById(IdGenerator.generateV4()),
              throwsA(isInstanceOf<Exception>()));
        });
      });

      group('getAllExercises', () {
        test(' - exercises exist, should return non-empty list', () {
          repository.addExercise(e1);
          repository.addExercise(e2);
          repository.addExercise(e3);
          repository.addExercise(e0);

          var res = repository.getAllExercises();
          expect(true, res.isNotEmpty);
        });
        test(' - exercises exist, should return non-empty list of length 3',
            () {
          var previous = repository.getAllExercises();
          repository.addExercise(e1);
          repository.addExercise(e2);
          repository.addExercise(e3);

          var res = repository.getAllExercises();
          expect(3, res.length - previous.length);
        });
      });

      group('getExerciseById', () {
        test(' - exercise exist, should return exercise', () {
          repository.addExercise(e1);
          var res = repository.getExerciseById(e1.id);
          expect(res.name, e1.name);
          expect(res.description, e1.description);
        });
        test(' - no exercises, should throw exception', () {
          expect(() => repository.getExerciseById(IdGenerator.generateV4()),
              throwsA(isInstanceOf<Exception>()));
        });
        test(' - exercise does not exist, should throw exception', () {
          repository.addExercise(e1);
          repository.addExercise(e2);
          repository.addExercise(e3);
          expect(() => repository.getExerciseById(IdGenerator.generateV4()),
              throwsA(isInstanceOf<Exception>()));
        });
      });
    });

    group('DELETE', () {
      group('clearUserWorkoutBank', () {
        test(' - should delete all user defined workouts', () {
          repository.addWorkout(w);
          repository.addWorkout(w);
          repository.addWorkout(w);
          repository.addWorkout(w);
          repository.clearUserWorkoutBank();
          var res = repository.getAllWorkouts();
          expect(true, res.isEmpty);
        });
      });

      group('clearUserExerciseBank()', () {
        test(' - exercise exist, should delete all exercises', () {
          repository.addExercise(e1);
          repository.addExercise(e2);
          repository.addExercise(e3);
          var original = repository.getAllExercises();
          repository.clearUserExerciseBank();
          expect(original.length - 3, repository.getAllExercises().length);
        });
      });

      group('deleteExerciseById', () {
        test(' - exercise exist, should remove exercise then return item', () {
          repository.addExercise(e1);
          repository.addExercise(e2);
          repository.addExercise(e3);
          var res = repository.deleteExerciseById(e2.id);
          expect(res, true);
        });

        test(' - exercise does not exist, should throw exception', () {
          repository.addExercise(e1);
          repository.addExercise(e2);
          repository.addExercise(e3);
          expect(() => repository.deleteExerciseById(IdGenerator.generateV4()),
              throwsA(isInstanceOf<Exception>()));
        });

        test(' - no exercises, should throw exception', () {
          expect(() => repository.deleteExerciseById(e0.id),
              throwsA(isInstanceOf<Exception>()));
        });
      });

      group('deleteWorkoutById', () {
        test(' - workout exist, should remove exercise then return item', () {
          repository.addWorkout(Workout.empty());
          repository.addWorkout(Workout.empty());
          repository.addWorkout(w);
          repository.addWorkout(Workout.empty());
          var res = repository.deleteWorkoutById(w.id);
          expect(res, true);
        });

        test(' - workout does not exist, should throw exception', () {
          repository.addWorkout(Workout.empty());
          repository.addWorkout(Workout.empty());
          repository.addWorkout(Workout.empty());
          expect(() => repository.deleteWorkoutById(IdGenerator.generateV4()),
              throwsA(isInstanceOf<Exception>()));
        });

        test(' - no workouts, should throw exception', () {
          expect(() => repository.deleteWorkoutById(w.id),
              throwsA(isInstanceOf<Exception>()));
        });
      });
    });

    group('UPDATE', () {
      group('updateExerciseById', () {
        test(' - item exists, target should be updated', () {
          repository.addExercise(e1);
          repository.addExercise(e2);
          repository.addExercise(e3);
          repository.updateExerciseById(
              e2.id,
              Exercise(
                  setCount: 1,
                  repCount: 1,
                  name: "test",
                  description: 'test',
                  target: Target.Shoulder));
          var res = repository.getExerciseById(e2.id);
          expect(res.target, Target.Shoulder);
        });
        test(' - item exists, setCount should be updated', () {
          repository.addExercise(e1);
          repository.addExercise(e2);
          repository.addExercise(e3);
          e2.setCount = 1;
          repository.updateExerciseById(e2.id, e2);
          expect(repository.getExerciseById(e2.id).setCount, 1);
        });
        test(' - item exists, repCount should be updated', () {
          repository.addExercise(e1);
          repository.addExercise(e2);
          repository.addExercise(e3);
          e2.repCount = 20;
          repository.updateExerciseById(e2.id, e2);
          expect(repository.getExerciseById(e2.id).repCount, 20);
        });
        test(' - item does not exists, should throw exception', () {
          repository.clearUserExerciseBank();
          expect(
              () => repository.updateExerciseById(IdGenerator.generateV4(), e1),
              throwsA(isInstanceOf<Exception>()));
        });
      });

      group('updateWorkoutById', () {
        Workout w1;
        Workout w3;
        Workout w2;
        setUp(() {
          w1 = Workout.empty();
          w3 = Workout.clone(w1);
          w2 = Workout.clone(w1);
          repository.addWorkout(w1);
          repository.addWorkout(w2);
          repository.addWorkout(w3);
        });

        test(' - item exists, name should be updated', () {
          w2.name = 'Workout 2';
          repository.updateWorkoutById(w2.id, w2);
          expect(repository.getWorkoutById(w2.id).name, 'Workout 2');
        });

        test(' - item exists, description should be updated', () {
          w2.description = 'Description 2';
          repository.updateWorkoutById(w2.id, w2);
          expect(repository.getWorkoutById(w2.id).description, 'Description 2');
        });

        test(' - item exists, targetBodyParts should be updated', () {
          var update = [Target.Shoulder, Target.Arm, Target.Chest];
          w2.targetBodyParts = update;
          repository.updateWorkoutById(w2.id, w2);
          var res = repository.getWorkoutById(w2.id).targetBodyParts;

          for (int i = 0; i < update.length; i++) {
            expect(res[i], update[i]);
          }
        });

        test(' - item exists, activities should be updated', () {
          var update = [e1, r15, e2, r30, e3];
          w2.activities = update;
          repository.updateWorkoutById(w2.id, w2);
          var res = repository.getWorkoutById(w2.id).activities;

          for (int i = 0; i < update.length; i++) {
            expect(res[i], update[i]);
          }
        });
        test(' - item exists, days should be updated', () {
          var update = [
            WeekdayNames.Monday,
            WeekdayNames.Tuesday,
            WeekdayNames.Wednesday,
            WeekdayNames.Thursday
          ];
          w2.days = update;
          repository.updateWorkoutById(w2.id, w2);
          var res = repository.getWorkoutById(w2.id).days;

          for (int i = 0; i < update.length; i++) {
            expect(res[i], update[i]);
          }
        });
        test(' - item does not exist, should throw exception', () {
          expect(
              () => repository.updateWorkoutById(
                  IdGenerator.generateV4(), Workout.empty()),
              throwsA(isInstanceOf<Exception>()));
        });

        test(' - no workouts, should throw exception', () {
          repository.clearUserExerciseBank();
          expect(
              () => repository.updateWorkoutById(
                  IdGenerator.generateV4(), Workout.empty()),
              throwsA(isInstanceOf<Exception>()));
        });
      });

      group('updateUserData', () {
        setUp(() {
          repository.updateUserData(UserData(
            currentWeight: 0.0,
            targetWeight: 0.0,
            currentBodyFat: 0.0,
            targetBodyFat: 0,
            height: 0,
          ));
        });

        test(' - should update currentWeight', () {
          repository.updateUserData(UserData(
            currentWeight: 1.0,
            targetWeight: 0.0,
            currentBodyFat: 0.0,
            targetBodyFat: 0,
            height: 0,
          ));
          var res = repository.getUserData();
          expect(res.currentWeight, 1.0);
        });
        test(' - should update targetWeight', () {
          repository.updateUserData(UserData(
            currentWeight: 0.0,
            targetWeight: 1.0,
            currentBodyFat: 0.0,
            targetBodyFat: 0.0,
            height: 0,
          ));
          var res = repository.getUserData();
          expect(res.targetWeight, 1.0);
        });
        test(' - should update currentBodyFat', () {
          repository.updateUserData(UserData(
            currentWeight: 0.0,
            targetWeight: 0.0,
            currentBodyFat: 1.0,
            targetBodyFat: 0.0,
            height: 0,
          ));
          var res = repository.getUserData();
          expect(res.currentBodyFat, 1.0);
        });
        test(' - should update targetBodyFat', () {
          repository.updateUserData(UserData(
            currentWeight: 0.0,
            targetWeight: 0.0,
            currentBodyFat: 0.0,
            targetBodyFat: 1.0,
            height: 0,
          ));
          var res = repository.getUserData();
          expect(res.targetBodyFat, 1.0);
        });
        test(' - should update height', () {
          repository.updateUserData(UserData(
            currentWeight: 0.0,
            targetWeight: 0.0,
            currentBodyFat: 0.0,
            targetBodyFat: 0,
            height: 60,
          ));
          var res = repository.getUserData();
          expect(res.height, 60);
        });
      });

      group('updateSessionData', () {
        SessionsData _sessionData = SessionsData(
          daysWorkedOutThisWeek: [
            false,
            false,
            true,
            false,
            true,
            false,
            false
          ],
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
                activities: []),
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
                activities: []),
          ),
        );

        Session newSession = Session(
          id: IdGenerator.generateV4(),
          datePerformed: DateTimeInfo(DateTime(2, 21, 2022)),
          duration: Duration(minutes: 20),
          workoutPerformed: Workout(
              name: 'New Session',
              description: 'Session Description',
              targetBodyParts: [Target.Chest, Target.Arm],
              id: IdGenerator.generateV4(),
              days: [WeekdayNames.Monday],
              activities: []),
        );

        test(' - should update daysWorkedOutThisWeek', () {
          SessionsData update = _sessionData;
          update.daysWorkedOutThisWeek = [
            true,
            true,
            true,
            true,
            true,
            true,
            true
          ];
          repository.updateSessionData(update);
          var res = repository.getSessionData();
          res.daysWorkedOutThisWeek.forEach((element) => expect(element, true));
        });

        test(' - should update currentWorkoutDuration', () {
          SessionsData update = _sessionData;
          update.currentWorkoutDuration = Duration(minutes: 5);
          repository.updateSessionData(update);
          var res =
              repository.getSessionData().currentWorkoutDuration.inMinutes;
          expect(res, 5);
        });

        test(' - should update targetWorkoutDuration', () {
          SessionsData update = _sessionData;
          update.targetWorkoutDuration = Duration(minutes: 5);
          repository.updateSessionData(update);
          var res = repository.getSessionData().targetWorkoutDuration.inMinutes;
          expect(res, 5);
        });

        test(' - should update previousSession', () {
          SessionsData update = _sessionData;
          String newId = IdGenerator.generateV4();
          newSession.id = newId;
          update.previousSession = newSession;
          repository.updateSessionData(update);
          var res = repository.getSessionData().previousSession.id;
          expect(res, newId);
        });

        test(' - should update nextSession', () {
          String newId = IdGenerator.generateV4();
          SessionsData update = _sessionData;
          newSession.id = newId;
          update.nextSession = newSession;
          repository.updateSessionData(update);
          var res = repository.getSessionData().nextSession.id;
          expect(res, newId);
        });
      });

      group('updateUserData', () {
        UserData newUserData;
        setUp(() {
          newUserData = UserData(
            currentWeight: 120.5,
            targetWeight: 122.5,
            height: 67.0,
            currentBodyFat: 21.0,
            targetBodyFat: 16.0,
          );
        });
        test(' - should update currentWeight', () {
          newUserData.currentWeight = 100.0;
          repository.updateUserData(newUserData);
          expect(repository.getUserData().currentWeight, 100.0);
        });
        test(' - should update targetWeight', () {
          newUserData.targetWeight = 100.0;
          repository.updateUserData(newUserData);
          expect(repository.getUserData().targetWeight, 100.0);
        });
        test(' - should update height', () {
          newUserData.height = 100.0;
          repository.updateUserData(newUserData);
          expect(repository.getUserData().height, 100.0);
        });
        test(' - should update currentBodyFat', () {
          newUserData.currentBodyFat = 20.0;
          repository.updateUserData(newUserData);
          expect(repository.getUserData().currentBodyFat, 20.0);
        });
        test(' - should update targetBodyFat', () {
          newUserData.targetBodyFat = 16.6;
          repository.updateUserData(newUserData);
          expect(repository.getUserData().targetBodyFat, 16.6);
        });
      });
    });
  });
}
