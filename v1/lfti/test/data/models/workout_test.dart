import 'package:flutter_test/flutter_test.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/rest.dart';
import 'package:lfti/data/models/workout.dart';

void workoutTest() {
  group('Workout Model Class', () {
    Workout workout;
    Exercise e1 = Exercise(name: 'Ex1', setCount: 3, repCount: 10);
    Rest r1 = Rest(60);
    Rest r2 = Rest(30);

    setUp(() {
      workout = Workout.empty();
    });

    group('instantiation', () {
      test(' - name should be \'unnamed\'', () {
        expect('unnamed', workout.name);
      });

      test(' - desc should be empty', () {
        expect('', workout.description);
      });

      test(' - activities isEmpty', () {
        expect(true, workout.activities.isEmpty);
      });

      test(' - targetBodyParts isEmpty', () {
        expect(true, workout.targetBodyParts.isEmpty);
      });
    });

    group('Workout.clone()', () {
      test(' - should not be the same instance', () {
        workout.name = 'Workout';
        workout.description = 'Description of workout';
        var clone = Workout.clone(workout);
        expect(false, identical(workout, clone));
      });

      test(' - should have the same field values', () {
        workout.name = 'Workout';
        workout.description = 'Description of workout';
        var clone = Workout.clone(workout);
        expect(true, clone.activities == workout.activities);
        expect(true, clone.days == workout.days);
        expect(true, clone.targetBodyParts == workout.targetBodyParts);
        expect(true, clone.name == workout.name);
        expect(true, clone.description == workout.description);
      });
    });
  });
}
