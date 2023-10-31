import 'package:lfti_api/src/type_definitions.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'exercise.g.dart';

enum MuscleGroup {
  chest('Chest'),
  back('Back'),
  legs('Legs'),
  shoulders('Shoulders'),
  tricep('Tricep'),
  bicep('Bicep'),
  abs('Abs'),
  none('None');

  final String name;
  const MuscleGroup(this.name);
}

/// {@template exercise_model}
/// A single `exercise` model.
///
/// Contains
///  - [id]: a unique identifier for the `exercise`.
/// - [name]: the name of the `exercise`.
/// - [muscleGroup]: the muscle group the `exercise` targets.
/// - [videoUrl]: the url of the `exercise` video.
/// - [description]: the description of the `exercise`.
/// - [instructions]: the instructions of the `exercise`.
/// - [tips]: the tips of the `exercise`.
/// - [reps]: the number of reps of the `exercise`.
/// - [sets]: the number of sets of the `exercise`.
/// - [seconds]: the number of seconds of the `exercise`.
/// - [minutes]: the number of minutes of the `exercise`.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Exercise]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson] respectively.
/// {@endtemplate}

@immutable
@JsonSerializable()
class Exercise extends Equatable {
  Exercise({
    String? id,
    required this.name,
    required this.muscleGroup,
    this.videoUrl,
    this.description,
    this.instructions,
    this.tips,
    this.reps,
    this.sets,
    this.seconds,
    this.minutes,
  })  : assert(
            id == null || id.isNotEmpty, 'id must either be null or not empty'),
        id = id ?? const Uuid().v4();

  final String id;
  final String name;
  final MuscleGroup muscleGroup;
  final String? videoUrl;
  final String? description;
  final String? instructions;
  final String? tips;
  final int? reps;
  final int? sets;
  final int? seconds;
  final int? minutes;

  /// Deserializes the given [JsonMap] into a [Exercise].
  static Exercise fromJson(JsonMap json) => _$ExerciseFromJson(json);

  /// Serializes this [Exercise] to a [JsonMap].
  JsonMap toJson() => _$ExerciseToJson(this);

  /// Returns a copy of this `exercise` with the given values updated.
  Exercise copyWith({
    String? name,
    MuscleGroup? muscleGroup,
    String? videoUrl,
    String? description,
    String? instructions,
    String? tips,
    int? reps,
    int? sets,
    int? seconds,
    int? minutes,
  }) {
    return Exercise(
      name: name ?? this.name,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      videoUrl: videoUrl ?? this.videoUrl,
      description: description ?? this.description,
      instructions: instructions ?? this.instructions,
      tips: tips ?? this.tips,
      reps: reps ?? this.reps,
      sets: sets ?? this.sets,
      seconds: seconds ?? this.seconds,
      minutes: minutes ?? this.minutes,
    );
  }

  @override
  List<Object?> get props => [
        name,
        muscleGroup,
        videoUrl,
        description,
        instructions,
        tips,
        reps,
        sets,
        seconds,
        minutes,
      ];
}

/// Error thrown when a [Exercise] with a given id is not found.
class ExerciseNotFoundException implements Exception {
  const ExerciseNotFoundException(this.id);

  /// The id of the [Exercise] that could not be found.
  final String id;
}
