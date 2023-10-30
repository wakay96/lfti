import 'package:equatable/equatable.dart';
import 'package:exercises_api/exercises_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'routine.g.dart';

typedef JsonMap = Map<String, dynamic>;

/// {@template routine_model}
/// A single `routine` model`
///
/// Contains
/// - [id]: a unique identifier for the `routine`.
/// - [name]: the name of the `routine`.
/// - [description]: the description of the `routine`.
/// - [exercises]: the exercises of the `routine`.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Routine]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson] respectively.
/// {@endtemplate}

@immutable
@JsonSerializable()
class Routine extends Equatable {
  Routine({
    String? id,
    required this.name,
    required this.description,
    required this.exercises,
  })  : assert(
            id == null || id.isNotEmpty, 'id must either be null or not empty'),
        id = id ?? const Uuid().v4();

  final String id;
  final String name;
  final String description;
  final List<Exercise> exercises;

  /// Deserializes the given [JsonMap] into a [Routine].
  static Routine fromJson(JsonMap json) => _$RoutineFromJson(json);

  /// Serializes this [Exercise] to a [JsonMap].
  JsonMap toJson() => _$RoutineToJson(this);

  /// Creates a copy of this [Routine] but with the given fields replaced with
  /// the new values.
  Routine copyWith({
    String? id,
    String? name,
    String? description,
    List<Exercise>? exercises,
  }) {
    return Routine(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      exercises: exercises ?? this.exercises,
    );
  }

  @override
  List<Object?> get props => [id, name, description, exercises];
}
