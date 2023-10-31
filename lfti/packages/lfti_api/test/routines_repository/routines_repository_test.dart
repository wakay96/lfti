import 'package:get/instance_manager.dart';
import 'package:lfti_api/src/exercises/models/exercise.dart';
import 'package:lfti_api/src/routines/interface/base_routines_api.dart';
import 'package:lfti_api/src/routines/models/routine.dart';
import 'package:lfti_api/src/routines/routine_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import 'routines_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RoutinesApi>()])
void main() {
  setUpAll(() {
    Get.put<RoutinesApi>(MockRoutinesApi());
  });

  group('add', () {
    test('should add new routine', () async {
      final Routine r1 = Routine(
        id: '1',
        name: 'routine 1',
        description: 'routine 1 description',
        exercises: [
          Exercise(
            name: 'Bench Press',
            muscleGroup: MuscleGroup.chest,
            reps: 12,
            sets: 3,
          ),
          Exercise(
            name: 'Dumbell Fly',
            muscleGroup: MuscleGroup.chest,
            reps: 12,
            sets: 3,
          )
        ],
      );

      final result = await RoutineRepository().add(r1);
      expect(result, equals([r1]));
    });
  });

  group('delete', () {
    test('routine exists, should delete routine', () async {
      final Routine routine = Routine(
        id: '1',
        name: 'routine 1',
        description: 'routine 1 description',
        exercises: [
          Exercise(
            name: 'Bench Press',
            muscleGroup: MuscleGroup.chest,
            reps: 12,
            sets: 3,
          ),
          Exercise(
            name: 'Dumbell Fly',
            muscleGroup: MuscleGroup.chest,
            reps: 12,
            sets: 3,
          )
        ],
      );

      final result = await RoutineRepository().delete(routine.id);
      expect(result, isEmpty);
    });
  });
}
