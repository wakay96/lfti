class Exercise {
  final String name;
  final String? description;
  final String? instructions;
  final String? tips;
  final int? reps;
  final int? sets;
  final int? seconds;
  final int? minutes;

  const Exercise({
    required this.name,
    this.description,
    this.instructions,
    this.tips,
    this.reps,
    this.sets,
    this.seconds,
    this.minutes,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'] as String,
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
