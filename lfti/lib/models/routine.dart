import 'package:lfti/models/exercise.dart';

class Routine {
  final String name;
  final String description;
  final List<Exercise> exercises;

  const Routine({
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
    );
  }

  Map<String, dynamic> toJson() {
    final exercisesJson = exercises.map((e) => e.toJson()).toList();
    return {
      'name': name,
      'description': description,
      'exercises': exercisesJson,
    };
  }
}
