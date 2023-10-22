// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      id: json['id'] as String?,
      name: json['name'] as String,
      muscleGroup: $enumDecode(_$MuscleGroupEnumMap, json['muscleGroup']),
      videoUrl: json['videoUrl'] as String?,
      description: json['description'] as String?,
      instructions: json['instructions'] as String?,
      tips: json['tips'] as String?,
      reps: json['reps'] as int?,
      sets: json['sets'] as int?,
      seconds: json['seconds'] as int?,
      minutes: json['minutes'] as int?,
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'muscleGroup': _$MuscleGroupEnumMap[instance.muscleGroup]!,
      'videoUrl': instance.videoUrl,
      'description': instance.description,
      'instructions': instance.instructions,
      'tips': instance.tips,
      'reps': instance.reps,
      'sets': instance.sets,
      'seconds': instance.seconds,
      'minutes': instance.minutes,
    };

const _$MuscleGroupEnumMap = {
  MuscleGroup.chest: 'chest',
  MuscleGroup.back: 'back',
  MuscleGroup.legs: 'legs',
  MuscleGroup.shoulders: 'shoulders',
  MuscleGroup.tricep: 'tricep',
  MuscleGroup.bicep: 'bicep',
  MuscleGroup.abs: 'abs',
  MuscleGroup.none: 'none',
};
