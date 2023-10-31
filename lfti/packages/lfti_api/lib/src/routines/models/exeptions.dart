/// Error thrown when a [Routine] with a given id is not found.
class RoutineNotFoundException implements Exception {
  const RoutineNotFoundException(this.message);

  /// The message of the [Routine] that could not be found.
  final String message;
}

/// Error thrown when a a dependecy is not initialized.
class UninitializedException implements Exception {
  const UninitializedException(this.message);

  final String message;
}
