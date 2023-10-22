import 'package:lfti/packages/models/routine.dart';

/// {@template todos_api}
/// The interface for an API that provides access to a list of routines.
/// {@endtemplate}
abstract class RoutinessApi {
  /// {@macro routines_api}

  /// Provides a [Stream] of all todos.
  Stream<List<Routine>> getRoutines();

  /// Saves a [routine].
  ///
  /// If a [routine] with the same id already exists, it will be replaced.
  Future<void> saveTodo(Routine routine);

  /// Gets routine by ID
  ///
  /// If no `routine` with the given id exists, a [RoutineNotFoundException] error is
  Future<void> getRotineById(String id);

  /// Deletes the `todo` with the given id.
  ///
  /// If no `todo` with the given id exists, a [RoutineNotFoundException] error is
  /// thrown.
  Future<void> deleteRoutine(String id);
}

/// Error thrown when a [Routine] with a given id is not found.
class RoutineNotFoundException implements Exception {
  const RoutineNotFoundException(this.id);

  /// The id of the [Routine] that could not be found.
  final String id;
}
