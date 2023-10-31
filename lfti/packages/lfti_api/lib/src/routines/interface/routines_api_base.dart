/// {@template todos_api}
/// The interface for an API that provides access to a list of routines.
/// {@endtemplate}
library;

import 'package:lfti_api/src/type_definitions.dart';

abstract class RoutinessBaseApi {
  /// {@macro routines_api}

  /// Provides a of all routines.
  Future<List<dynamic>> getRoutines();

  /// Saves a [routine].
  ///
  /// If a [routine] with the same id already exists, it will be replaced.
  /// Returns the updated [Map] List.
  Future<List<dynamic>> saveRoutine(JsonMap data);

  /// Gets routine by ID
  ///
  /// If no `routine` with the given id exists, a [RoutineNotFoundException] error is
  Future<JsonMap> getRoutineById(String id);

  /// Deletes the `todo` with the given id.
  ///
  /// If no `todo` with the given id exists, a [RoutineNotFoundException] error is
  /// thrown.
  Future<void> deleteRoutine(String id);
}
