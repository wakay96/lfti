import 'package:lfti/models/exercise.dart';

class Routine {
  final String? id;
  final String name;
  final String description;
  final List<Exercise> exercises;

  const Routine({
    this.id,
    required this.name,
    required this.description,
    required this.exercises,
  });

  factory Routine.fromJson(Map<String, dynamic> json) {
    final exercisesJson = json['exercises'] as List<dynamic>?;
    final exercises = exercisesJson
            ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return Routine(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      exercises: exercises,
      id: json['id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> exercisesJson =
        exercises.map((e) => e.toJson()).toList();
    return {
      'id': id,
      'name': name,
      'description': description,
      'exercises': exercisesJson,
    };
  }

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
}
