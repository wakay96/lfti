import 'package:lfti_api/src/type_definitions.dart';

/// {@template exercises_api}
/// The interface for an API that provides access to a list of exercises.
/// {@endtemplate}
abstract class ExercisessApi {
  /// {@macro exercises_api}

  /// Provides a [Stream] of all exercises.
  Stream<List<JsonMap>> getExercises();

  /// Saves a [exercise].
  ///
  /// If a [exercise] with the same id already exists, it will be replaced.
  Future<void> saveTodo(JsonMap data);

  /// Gets exercise by ID
  ///
  /// If no `exercise` with the given id exists, a [ExerciseNotFoundException] error is
  Future<void> getRotineById(String id);

  /// Deletes the `exercise` with the given id.
  ///
  /// If no `exercise` with the given id exists, a [ExerciseNotFoundException] error is
  /// thrown.
  Future<void> deleteExercise(String id);
}
