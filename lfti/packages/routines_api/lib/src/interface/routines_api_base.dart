import 'package:routines_api/src/models/routine.dart';

/// {@template todos_api}
/// The interface for an API that provides access to a list of routines.
/// {@endtemplate}
abstract class RoutinessBaseApi {
  /// {@macro routines_api}

  /// Provides a of all routines.
  Future<List<Routine>> getRoutines();

  /// Saves a [routine].
  ///
  /// If a [routine] with the same id already exists, it will be replaced.
  /// Returns the updated [Routine] List.
  Future<List<Routine>> saveRoutine(Routine routine);

  /// Gets routine by ID
  ///
  /// If no `routine` with the given id exists, a [RoutineNotFoundException] error is
  Future<Routine> getRoutineById(String id);

  /// Deletes the `todo` with the given id.
  ///
  /// If no `todo` with the given id exists, a [RoutineNotFoundException] error is
  /// thrown.
  Future<void> deleteRoutine(String id);
}
