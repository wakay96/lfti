import 'package:lfti/models/exercise.dart';
import 'package:lfti/models/routine.dart';

abstract class BaseRepository {
  List<Routine> fetchAllRoutines();
}

class Repository implements BaseRepository {
  static final Repository _instance = Repository._internal();
  factory Repository() => _instance;
  Repository._internal();

  final List<Routine> allRoutines = [
    const Routine(
      name: 'Chest Workout',
      description: 'A chest workout routine for intermediate lifters',
      exercises: [
        Exercise(
          name: 'Barbell Bench Press',
          description:
              'A compound exercise that targets the chest, shoulders, and triceps',
          instructions:
              'Lie on a bench with your feet flat on the ground, grip the bar with your hands shoulder-width apart, lower the bar to your chest, then push the bar back up.',
          tips:
              'Keep your back flat on the bench and your elbows close to your body.',
          reps: 8,
          sets: 4,
          seconds: 0,
          minutes: 0,
        ),
        Exercise(
          name: 'Incline Dumbbell Press',
          description: 'An isolation exercise that targets the upper chest',
          instructions:
              'Lie on an incline bench with your feet flat on the ground, hold a dumbbell in each hand, lower the dumbbells to your chest, then push the dumbbells back up.',
          tips: 'Keep your elbows close to your body and your wrists straight.',
          reps: 10,
          sets: 3,
          seconds: 0,
          minutes: 0,
        ),
        Exercise(
          name: 'Cable Fly',
          description: 'An isolation exercise that targets the chest',
          instructions:
              'Stand in the middle of a cable machine, hold the handles with your palms facing down, bring your hands together in front of your chest, then slowly release back to the starting position.',
          tips: 'Keep your elbows slightly bent and your shoulders down.',
          reps: 12,
          sets: 3,
          seconds: 0,
          minutes: 0,
        ),
      ],
    ),
    const Routine(
      name: 'Back Workout',
      description: 'A back workout routine for intermediate lifters',
      exercises: [
        Exercise(
          name: 'Deadlifts',
          description:
              'A compound exercise that targets the back, legs, and core',
          instructions:
              'Stand with your feet shoulder-width apart, grip the bar with your hands shoulder-width apart, lift the bar off the ground by extending your hips and knees, then lower the bar back down to the ground.',
          tips: 'Keep your back straight and your shoulders down.',
          reps: 8,
          sets: 4,
          seconds: 0,
          minutes: 0,
        ),
        Exercise(
          name: 'Pull-ups',
          description: 'A compound exercise that targets the back and biceps',
          instructions:
              'Hang from a bar with your hands shoulder-width apart, pull your body up until your chin is above the bar, then lower your body back down.',
          tips: 'Keep your body straight and your elbows close to your body.',
          reps: 10,
          sets: 3,
          seconds: 0,
          minutes: 0,
        ),
        Exercise(
          name: 'Seated Cable Rows',
          description: 'An isolation exercise that targets the back and biceps',
          instructions:
              'Sit on a bench in front of a cable machine, hold the handles with your palms facing down, pull the handles towards your body, then release back to the starting position.',
          tips: 'Keep your back straight and your shoulders down.',
          reps: 12,
          sets: 3,
          seconds: 0,
          minutes: 0,
        ),
      ],
    )
  ];

  @override
  List<Routine> fetchAllRoutines() => allRoutines;
}
