import 'package:lfti/constants/enums.dart';

class Exercise {
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

  const Exercise({
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
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    const String muscleGroupKey = 'muscleGroup';
    final int index = MuscleGroup.values.indexWhere(
        (element) => element.toString() == json[muscleGroupKey] as String);
    late MuscleGroup muscleGroup;
    switch (index) {
      case 0:
        muscleGroup = MuscleGroup.chest;
        break;
      case 1:
        muscleGroup = MuscleGroup.back;
        break;
      case 2:
        muscleGroup = MuscleGroup.legs;
        break;
      case 3:
        muscleGroup = MuscleGroup.bicep;
        break;
      case 4:
        muscleGroup = MuscleGroup.tricep;
        break;
      case 5:
        muscleGroup = MuscleGroup.shoulders;
        break;
      case 6:
        muscleGroup = MuscleGroup.abs;
        break;
      default:
        muscleGroup = MuscleGroup.none;
    }

    return Exercise(
      name: json['name'] as String,
      muscleGroup: muscleGroup,
      videoUrl: json['videoUrl'] as String?,
      description:
          json['description'] == null ? '' : json['description'] as String?,
      instructions:
          json['instructions'] == null ? '' : json['instructions'] as String?,
      tips: json['tips'] == null ? '' : json['tips'] as String?,
      reps: json['reps'] == null ? 0 : json['reps'] as int?,
      sets: json['sets'] == null ? 0 : json['sets'] as int?,
      seconds: json['seconds'] == null ? 0 : json['seconds'] as int?,
      minutes: json['minutes'] == null ? 0 : json['minutes'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'muscleGroup': muscleGroup.name,
      'videoUrl': videoUrl,
      'description': description,
      'instructions': instructions,
      'tips': tips,
      'reps': reps,
      'sets': sets,
      'seconds': seconds,
      'minutes': minutes,
    };
  }
}
