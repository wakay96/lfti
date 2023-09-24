import 'package:flutter/material.dart';
import 'package:lfti/constants/enums.dart';
import 'package:lfti/models/exercise.dart';

class ExerciseDetailsPage extends StatelessWidget {
  static final String path = AppSubPage.exerciseDetails.path;

  final Exercise exercise;

  const ExerciseDetailsPage({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (exercise.description != null)
              Text(
                exercise.description!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            if (exercise.instructions != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Instructions:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            if (exercise.instructions != null) Text(exercise.instructions!),
            if (exercise.tips != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Tips:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            if (exercise.tips != null) Text(exercise.tips!),
            if (exercise.reps != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Reps: ${exercise.reps}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            if (exercise.sets != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Sets: ${exercise.sets}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            if (exercise.seconds != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Duration: ${exercise.seconds} seconds',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            if (exercise.minutes != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Duration: ${exercise.minutes} minutes',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
