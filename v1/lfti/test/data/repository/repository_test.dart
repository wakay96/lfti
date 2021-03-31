import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/rest.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/models/user.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/data/repository/data.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/id_generator.dart';

void repositoryTest() {
  group('Repository Class', () {
    var getIt = GetIt.instance;
    IRepository repository;

    /// TEST DATA
    Exercise? e0;
    Exercise? e3;
    Exercise? e2;
    Exercise? e1;
    Rest r15 = Rest(IdGenerator.generateV4(), Duration(seconds: 15));
    Rest r30 = Rest(IdGenerator.generateV4(), Duration(seconds: 30));

    setUp(() {
      repository = getIt<IRepository>();
      repository.clearUserExerciseBank();
      repository.clearUserWorkoutBank();
      e0 = Exercise(
          id: IdGenerator.generateV4(),
          name: 'E0',
          setCount: 3,
          repCount: 10,
          target: Target.Chest);
      e3 = Exercise(
          id: IdGenerator.generateV4(),
          name: 'E3',
          setCount: 3,
          repCount: 12,
          target: Target.Back);
      e2 = Exercise(
          id: IdGenerator.generateV4(),
          name: 'E2',
          setCount: 3,
          repCount: 15,
          target: Target.Arm);
      e1 = Exercise(
          id: IdGenerator.generateV4(),
          name: 'E1',
          setCount: 3,
          repCount: 20,
          target: Target.Leg);
    });

    group('ADD', () {
      test('addExercise - exercises length == 1', () {
        repository = getIt<IRepository>();
        var prev = repository.getAllActivities().length;
        repository.addExercise(e1!);
        List<Activity> res = repository.getAllActivities();
        expect(prev + 1, res.length);
      });

      test('addWorkout - should add 1 workout', () {
        repository = getIt<IRepository>();
        final data = SampleData();
        int prev = data.workouts.length;
        repository.addWorkout(data.workouts[0]);
        List<Workout> res = repository.getAllWorkouts();
        expect(prev + 1, res.length);
      });

      test('addWorkout - should add 2 workout', () {
        repository = getIt<IRepository>();
        final data = SampleData();
        int prev = data.workouts.length;
        repository.addWorkout(data.workouts[0]);
        var res = repository.getAllWorkouts();
        expect(prev + 1, res.length);
      });

      test('addSession - should add 1 session', () {
        repository = getIt<IRepository>();
        var matcher = repository.getAllSessions().length;
        final data = SampleData();
        var session = data.sessions[0];
        repository.addSession(session);
        var res = repository.getAllSessions();
        expect(res.length, matcher + 1);
      });

      test('addSession - should return 2 sessions', () {
        repository = getIt<IRepository>();
        var matcher = repository.getAllSessions().length;
        final data = SampleData();
        repository.addSession(data.sessions[0]);
        repository.addSession(data.sessions[1]);
        var res = repository.getAllSessions();
        expect(res.length, matcher + 2);
      });
    });

    group('GET', () {
      group('getAllWorkouts', () {
        test(' - workouts exist, should return non-empty list', () {
          var data = SampleData();
          var w = data.workouts[0];
          repository = getIt<IRepository>();
          repository.addWorkout(w);
          repository.addWorkout(w);
          repository.addWorkout(w);
          var res = repository.getAllWorkouts();
          expect(true, res.isNotEmpty);
        });
      });

      group('getWorkoutById', () {
        test(' - workouts exist, should return found workout', () {
          repository = getIt<IRepository>();
          var woId = IdGenerator.generateV4();
          repository.addWorkout(SampleData().workouts[0]);
          repository.addWorkout(SampleData().workouts[1]);
          repository.addWorkout(Workout(
              id: woId,
              name: 'Found me',
              description: '',
              activities: [],
              targetBodyParts: []));
          repository.addWorkout(SampleData().workouts[0]);
          var res = repository.getWorkoutById(woId);
          expect(res.name, 'Found me');
        });
        test(' - no workouts, should throw exception', () {
          repository = getIt<IRepository>();
          expect(() => repository.getWorkoutById(IdGenerator.generateV4()),
              throwsA(isInstanceOf<Exception>()));
        });

        test(' - workout not found, should throw exception', () {
          repository = getIt<IRepository>();
          repository.addWorkout(SampleData().workouts[0]);
          repository.addWorkout(SampleData().workouts[1]);
          repository.addWorkout(SampleData().workouts[2]);
          expect(() => repository.getWorkoutById(IdGenerator.generateV4()),
              throwsA(isInstanceOf<Exception>()));
        });
      });

      group('getAllExercises', () {
        test(' - exercises exist, should return non-empty list', () {
          repository = getIt<IRepository>();
          repository.addExercise(e1!);
          repository.addExercise(e2!);
          repository.addExercise(e3!);
          repository.addExercise(e0!);

          var res = repository.getAllActivities();
          expect(true, res.isNotEmpty);
        });
        test(' - exercises exist, should return non-empty list of length 3',
            () {
          repository = getIt<IRepository>();
          var prev = repository.getAllActivities().length;
          repository.addExercise(e1!);
          repository.addExercise(e2!);
          repository.addExercise(e3!);
          var res = repository.getAllActivities();
          expect(prev + 3, res.length);
        });
      });

      group('getExerciseById', () {
        repository = getIt<IRepository>();
        test(' - exercise exist, should return exercise', () {
          repository.addExercise(e1!);
          var res = repository.getExerciseById(e1!.id);
          expect(res.name, e1!.name);
          expect(res.description, e1!.description);
        });
        test(' - no exercises, should throw exception', () {
          expect(() => repository.getExerciseById(IdGenerator.generateV4()),
              throwsA(isInstanceOf<Exception>()));
        });
        test(' - exercise does not exist, should throw exception', () {
          repository = getIt<IRepository>();
          repository.addExercise(e1!);
          repository.addExercise(e2!);
          repository.addExercise(e3!);
          expect(() => repository.getExerciseById(IdGenerator.generateV4()),
              throwsA(isInstanceOf<Exception>()));
        });
      });
    });

    group('DELETE', () {
      group('clearUserWorkoutBank', () {
        test(' - should delete all user defined workouts', () {
          Workout w = SampleData().workouts[0];
          repository = getIt<IRepository>();
          repository.addWorkout(SampleData().workouts[0]);
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
          repository = getIt<IRepository>();
          repository.addExercise(e1!);
          repository.addExercise(e2!);
          repository.addExercise(e3!);
          var original = repository.getAllActivities();
          repository.clearUserExerciseBank();
          expect(original.length, repository.getAllActivities().length);
        });
      });

      group('deleteExerciseById', () {
        test(' - exercise exist, should remove exercise then return item', () {
          repository = getIt<IRepository>();
          repository.addExercise(e1!);
          repository.addExercise(e2!);
          repository.addExercise(e3!);
          var res = repository.deleteExerciseById(e2!.id);
          expect(res, true);
        });

        test(' - exercise does not exist, should throw exception', () {
          repository = getIt<IRepository>();
          repository.addExercise(e1!);
          repository.addExercise(e2!);
          repository.addExercise(e3!);
          expect(() => repository.deleteExerciseById(IdGenerator.generateV4()),
              throwsA(isInstanceOf<Exception>()));
        });

        test(' - no exercises, should throw exception', () {
          repository = getIt<IRepository>();
          expect(() => repository.deleteExerciseById(e0!.id),
              throwsA(isInstanceOf<Exception>()));
        });
      });

      group('deleteWorkoutById', () {
        test(' - workout exist, should remove exercise then return item', () {
          repository = getIt<IRepository>();
          var data = SampleData();
          repository.addWorkout(data.workouts[0]);
          repository.addWorkout(data.workouts[1]);
          repository.addWorkout(data.workouts[2]);
          var res = repository.deleteWorkoutById(data.workouts[2].id);
          expect(res, true);
        });

        test(' - workout does not exist, should throw exception', () {
          repository = getIt<IRepository>();
          var data = SampleData();
          repository.addWorkout(data.workouts[0]);
          repository.addWorkout(data.workouts[1]);
          repository.addWorkout(data.workouts[2]);
          expect(() => repository.deleteWorkoutById(IdGenerator.generateV4()),
              throwsA(isInstanceOf<Exception>()));
        });

        test(' - no workouts, should throw exception', () {
          repository = getIt<IRepository>();
          var w = SampleData().workouts[0];
          expect(() => repository.deleteWorkoutById(w.id),
              throwsA(isInstanceOf<Exception>()));
        });
      });
    });

    group('UPDATE', () {
      group('updateExerciseById', () {
        repository = getIt<IRepository>();
        test(' - item exists, target should be updated', () {
          repository.addExercise(e1!);
          repository.addExercise(e2!);
          repository.addExercise(e3!);
          repository.updateExerciseById(
              e2!.id,
              Exercise(
                  id: IdGenerator.generateV4(),
                  setCount: 1,
                  repCount: 1,
                  name: "test",
                  description: 'test',
                  target: Target.Shoulder));
          Exercise res = repository.getExerciseById(e2!.id);
          expect(res.target, Target.Shoulder);
        });
        test(' - item exists, setCount should be updated', () {
          repository.addExercise(e1!);
          repository.addExercise(e2!);
          repository.addExercise(e3!);
          e2!.setCount = 1;
          repository.updateExerciseById(e2!.id, e2!);
          expect(repository.getExerciseById(e2!.id).setCount, 1);
        });
        test(' - item exists, repCount should be updated', () {
          repository.addExercise(e1!);
          repository.addExercise(e2!);
          repository.addExercise(e3!);
          e2!.repCount = 20;
          repository.updateExerciseById(e2!.id, e2!);
          expect(repository.getExerciseById(e2!.id).repCount, 20);
        });
        test(' - item does not exists, should throw exception', () {
          repository.clearUserExerciseBank();
          expect(
              () =>
                  repository.updateExerciseById(IdGenerator.generateV4(), e1!),
              throwsA(isInstanceOf<Exception>()));
        });
      });

      group('updateWorkoutById', () {
        repository = getIt<IRepository>();
        Workout? w1;
        Workout? w3;
        Workout? w2;
        setUp(() {
          w1 = SampleData().workouts[0];
          w3 = SampleData().workouts[1];
          w2 = SampleData().workouts[2];
          repository.addWorkout(w1!);
          repository.addWorkout(w2!);
          repository.addWorkout(w3!);
        });

        test(' - item exists, name should be updated', () {
          w2!.name = 'Workout 2';
          repository.updateWorkoutById(w2!.id, w2!);
          expect(repository.getWorkoutById(w2!.id).name, 'Workout 2');
        });

        test(' - item exists, description should be updated', () {
          w2!.description = 'Description 2';
          repository.updateWorkoutById(w2!.id, w2!);
          expect(
              repository.getWorkoutById(w2!.id).description, 'Description 2');
        });

        test(' - item exists, targetBodyParts should be updated', () {
          var update = [Target.Shoulder, Target.Arm, Target.Chest];
          w2!.targetBodyParts = update;
          repository.updateWorkoutById(w2!.id, w2!);
          var res = repository.getWorkoutById(w2!.id).targetBodyParts;

          for (int i = 0; i < update.length; i++) {
            expect(res[i], update[i]);
          }
        });

        test(' - item exists, activities should be updated', () {
          List<Activity> update = [e1!, r15, e2!, r30, e3!];
          w2!.activities = update;
          repository.updateWorkoutById(w2!.id, w2!);
          var res = repository.getWorkoutById(w2!.id).activities;

          for (int i = 0; i < update.length; i++) {
            expect(res[i], update[i]);
          }
        });
        test(' - item does not exist, should throw exception', () {
          expect(
              () => repository.updateWorkoutById(
                  IdGenerator.generateV4(), SampleData().workouts[0]),
              throwsA(isInstanceOf<Exception>()));
        });

        test(' - no workouts, should throw exception', () {
          repository.clearUserExerciseBank();
          expect(
              () => repository.updateWorkoutById(
                  IdGenerator.generateV4(), SampleData().workouts[0]),
              throwsA(isInstanceOf<Exception>()));
        });
      });

      group('updateUser', () {
        repository = getIt<IRepository>();
        setUp(() {
          repository.updateUser(User(
            id: IdGenerator.generateV4(),
            firstName: 'John',
            lastName: 'Escalona',
            email: 'iam@johnescalona.com',
            currentWeight: 0.0,
            targetWeight: 0.0,
            currentBodyFat: 0.0,
            targetBodyFat: 0,
            height: 0,
          ));
        });

        test(' - should update currentWeight', () {
          repository.updateUser(User(
            id: IdGenerator.generateV4(),
            firstName: 'John',
            lastName: 'Escalona',
            email: 'iam@johnescalona.com',
            currentWeight: 1.0,
            targetWeight: 0.0,
            currentBodyFat: 0.0,
            targetBodyFat: 0,
            height: 0,
          ));
          var res = repository.getUser();
          expect(res.currentWeight, 1.0);
        });
        test(' - should update targetWeight', () {
          repository.updateUser(User(
            id: IdGenerator.generateV4(),
            firstName: 'John',
            lastName: 'Escalona',
            email: 'iam@johnescalona.com',
            currentWeight: 0.0,
            targetWeight: 1.0,
            currentBodyFat: 0.0,
            targetBodyFat: 0.0,
            height: 0,
          ));
          var res = repository.getUser();
          expect(res.targetWeight, 1.0);
        });
        test(' - should update currentBodyFat', () {
          repository.updateUser(User(
            id: IdGenerator.generateV4(),
            firstName: 'John',
            lastName: 'Escalona',
            email: 'iam@johnescalona.com',
            currentWeight: 0.0,
            targetWeight: 0.0,
            currentBodyFat: 1.0,
            targetBodyFat: 0.0,
            height: 0,
          ));
          var res = repository.getUser();
          expect(res.currentBodyFat, 1.0);
        });
        test(' - should update targetBodyFat', () {
          repository.updateUser(User(
            id: IdGenerator.generateV4(),
            firstName: 'John',
            lastName: 'Escalona',
            email: 'iam@johnescalona.com',
            currentWeight: 0.0,
            targetWeight: 0.0,
            currentBodyFat: 0.0,
            targetBodyFat: 1.0,
            height: 0,
          ));
          var res = repository.getUser();
          expect(res.targetBodyFat, 1.0);
        });
        test(' - should update height', () {
          repository.updateUser(User(
            id: IdGenerator.generateV4(),
            firstName: 'John',
            lastName: 'Escalona',
            email: 'iam@johnescalona.com',
            currentWeight: 0.0,
            targetWeight: 0.0,
            currentBodyFat: 0.0,
            targetBodyFat: 0,
            height: 60,
          ));
          var res = repository.getUser();
          expect(res.height, 60);
        });
      });

      group('updateSessionById', () {
        test(' - should update session name and description', () {
          final data = SampleData();
          repository = getIt<IRepository>();
          repository.resetAllData();
          final newName = 'My new workout';
          final newDescription = 'My new Description';
          repository.addSession(data.sessions[0]);
          final newSession = Session(
            id: data.sessions[0].id,
            schedule: [],
            activities: [],
            name: newName,
            description: newDescription,
          );
          repository.updateSessionById(data.sessions[0].id, newSession);
          final res = repository.getSessionById(data.sessions[0].id)!;
          expect(res.name, newName);
          expect(res.description, newDescription);
        });
        test(' - should add new activity', () {
          final data = SampleData();
          repository = getIt<IRepository>();
          repository.resetAllData();
          repository.addSession(data.sessions[0]);
          final newSession = Session(
            id: IdGenerator.generateV4(),
            schedule: [],
            activities: [data.chestExercises[0]],
            name: '',
            description: '',
          );
          repository.updateSessionById(data.sessions[0].id, newSession);
          final res = repository.getSessionById(data.sessions[0].id)!;
          expect(res.activities.length, 1);
        });
      });
    });
  });
}
