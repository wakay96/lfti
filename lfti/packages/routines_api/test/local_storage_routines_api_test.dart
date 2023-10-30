import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:routines_api/src/local_storage_routines_api.dart';
import 'package:routines_api/src/models/exeptions.dart';
import 'package:routines_api/src/models/routine.dart';
import 'package:test/test.dart';

typedef JsonMap = Map<String, dynamic>;

void main() {
  late LocalStorage plugin;

  final JsonMap routine_1 = {
    "id": "routine_id_1",
    "name": "Chest Workout",
    "description": "A chest workout routine for intermediate lifters",
    "exercises": [
      {
        "name": "Push-up",
        "muscleGroup": "chest",
        "description": "A classic bodyweight exercise for chest muscles.",
        "instructions":
            "1. Start in a plank position with your hands shoulder-width apart.\n2. Lower your body by bending your elbows, keeping your body in a straight line.\n3. Push yourself back up to the starting position.\n4. Repeat.",
        "tips":
            "Keep your core engaged and maintain proper form throughout the exercise.",
        "reps": 8,
        "sets": 3
      },
      {
        "name": "Incline Bench Press",
        "muscleGroup": "chest",
        "description":
            "A variation of the bench press that targets the upper chest muscles.",
        "instructions":
            "1. Lie on an incline bench with your back flat against it.\n2. Hold a barbell or dumbbells above your chest with your arms extended.\n3. Lower the weights to your chest.\n4. Push the weights back up.\n5. Repeat.",
        "tips": "Keep your shoulders back and chest up for proper form.",
        "reps": 8,
        "sets": 3
      },
      {
        "name": "Bench Press",
        "muscleGroup": "chest",
        "description":
            "A classic strength-building exercise for the chest muscles.",
        "instructions":
            "1. Lie on a flat bench with your back on it.\n2. Grip a barbell with your hands slightly wider than shoulder-width apart.\n3. Lower the bar to your chest.\n4. Push the barbell back up.\n5. Repeat.",
        "tips":
            "Maintain a stable bench and use a spotter when lifting heavy weights.",
        "reps": 8,
        "sets": 3
      }
    ]
  };
  final JsonMap routine_2 = {
    "id": "routine_id_2",
    "name": "Back Workout",
    "description": "A back workout routine for intermediate lifters",
    "exercises": [
      {
        "name": "Deadlift",
        "muscleGroup": "back",
        "description":
            "A compound exercise targeting the lower and upper back muscles.",
        "instructions":
            "1. Stand with your feet hip-width apart, a barbell in front of you.\n2. Bend at your hips and knees to lower your body and grip the barbell.\n3. Lift the barbell by extending your hips and knees, pulling your shoulders back.\n4. Lower the barbell to the ground by reversing the movement.\n5. Repeat.",
        "tips":
            "Maintain a neutral spine and engage your core throughout the exercise.",
        "reps": 8,
        "sets": 3
      },
      {
        "name": "Pull-up",
        "muscleGroup": "back",
        "description":
            "A bodyweight exercise that targets the upper back and lats.",
        "instructions":
            "1. Hang from a pull-up bar with your palms facing away from you.\n2. Pull your body upward until your chin is above the bar.\n3. Lower your body back down to the starting position.\n4. Repeat.",
        "tips": "Focus on full range of motion and controlled movements.",
        "reps": 8,
        "sets": 3
      },
      {
        "name": "Barbell Row",
        "muscleGroup": "back",
        "description":
            "A compound exercise for the middle and upper back muscles.",
        "instructions":
            "1. Stand with your feet hip-width apart, holding a barbell with an overhand grip.\n2. Bend at your hips and knees slightly, keeping your back straight.\n3. Pull the barbell toward your lower ribcage, squeezing your shoulder blades together.\n4. Lower the barbell back to the starting position.\n5. Repeat.",
        "tips": "Keep your core engaged and maintain a strong posture.",
        "reps": 8,
        "sets": 3
      },
      {
        "name": "Lat Pulldown",
        "muscleGroup": "back",
        "description":
            "A machine exercise that targets the latissimus dorsi muscles.",
        "instructions":
            "1. Sit at a lat pulldown machine with your thighs secured under the pads.\n2. Grip the bar with your hands wider than shoulder-width apart.\n3. Pull the bar down to your chest, squeezing your shoulder blades together.\n4. Slowly release the bar back to the starting position.\n5. Repeat.",
        "tips": "Maintain proper posture and control the movement throughout.",
        "reps": 8,
        "sets": 3
      }
    ]
  };

  group('getRoutineById', () {
    late LocalStorageRoutinesApi api;
    setUp(() async {
      plugin = LocalStorage(LocalStorageRoutinesApi.key);
      await plugin.clear();
      await plugin.setItem(routine_1['id'], routine_1);
      await plugin.setItem(routine_2['id'], routine_2);
      api = LocalStorageRoutinesApi(plugin: plugin);
    });

    test('Should return Routine when found', () async {
      final routine = await api.getRoutineById('routine_id_1');
      expect(routine, isNotNull);
    });

    test('Should throw RoutineNotFoundException when routine dne', () {
      expect(
        () async => await api.getRoutineById('_404_'),
        throwsA(isA<RoutineNotFoundException>()),
      );
    });
  });

  group('getRoutines', () {
    late LocalStorageRoutinesApi api;

    setUp(() async {
      plugin = LocalStorage(LocalStorageRoutinesApi.key);
      await plugin.clear();
      api = LocalStorageRoutinesApi(plugin: plugin);
    });

    test('Should return all routines', () async {
      final List<JsonMap> data = [
        routine_1,
        routine_2,
      ];
      await plugin.setItem(LocalStorageRoutinesApi.subKey, data);

      final routines = await api.getRoutines();

      final expected = data.map((json) => Routine.fromJson(json)).toList();
      expect(routines, equals(expected));
    });

    test('Should return empty if recieved null', () async {
      expect(await api.getRoutines(), isEmpty);
    });

    test('Should return empty if routines are empty', () async {
      await plugin.setItem(LocalStorageRoutinesApi.subKey, []);

      final routines = await api.getRoutines();
      expect(routines, isEmpty);
    });
  });

  group('deleteRoutine', () {
    late LocalStorageRoutinesApi api;

    setUp(() async {
      plugin = LocalStorage(LocalStorageRoutinesApi.key);
      await plugin.clear();
      await plugin
          .setItem(LocalStorageRoutinesApi.subKey, [routine_1, routine_2]);
      api = LocalStorageRoutinesApi(plugin: plugin);
    });

    test('Should delete routine', () async {
      await api.deleteRoutine('routine_id_1');
      final routines = await api.getRoutines();
      expect(routines, hasLength(1));
    });

    test('Should throw RoutineNotFoundException if routine dne', () async {
      expect(
        () async => await api.deleteRoutine('_404_'),
        throwsA(isA<RoutineNotFoundException>()),
      );
    });
  });

  group('saveRoutine', () {
    late LocalStorageRoutinesApi api;

    setUp(() async {
      plugin = LocalStorage(LocalStorageRoutinesApi.key);
      await plugin.clear();
      api = LocalStorageRoutinesApi(plugin: plugin);
    });

    test('Should return updated list & persist', () async {
      final Routine routine = Routine(
        id: 'sample_id',
        name: 'Thursday Routine',
        description: 'Shoulder day',
        exercises: [],
      );

      final returnValue = await api.pushRoutine(routine);

      expect(returnValue, equals([routine]));

      final jsonData = await plugin.getItem(LocalStorageRoutinesApi.subKey);
      expect(jsonData, [routine.toJson()]);
    });

    test('Should update existing routine, return updated list & persist',
        () async {
      final Routine routine = Routine(
        id: 'sample_id',
        name: 'Thursday Routine',
        description: 'Shoulder day',
        exercises: [],
      );

      await api.pushRoutine(routine);
      final updated = routine.copyWith(name: 'Updated Routine');
      final returnValue = await api.pushRoutine(updated);

      expect(returnValue, equals([updated]));

      final jsonData = await plugin.getItem(LocalStorageRoutinesApi.subKey);
      expect(jsonData, [updated.toJson()]);
    });
  });
}
