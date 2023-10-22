import 'dart:async';

import 'package:lfti/data/services/interface/base_repository.dart';
import 'package:lfti/packages/models/exercise.dart';
import 'package:lfti/packages/models/routine.dart';
import 'package:uuid/uuid.dart';

class RoutineRepository implements BaseRepository<Routine, Routine?> {
  static final RoutineRepository _instance = RoutineRepository._internal();
  factory RoutineRepository() => _instance;
  RoutineRepository._internal();

  final List<Routine> allRoutines = [
    Routine(
      id: const Uuid().v4(),
      name: 'Chest Workout',
      description: 'A chest workout routine for intermediate lifters',
      exercises: [
        Exercise(
          name: "Push-up",
          muscleGroup: MuscleGroup.chest,
          description: "A classic bodyweight exercise for chest muscles.",
          instructions:
              "1. Start in a plank position with your hands shoulder-width apart.\n2. Lower your body by bending your elbows, keeping your body in a straight line.\n3. Push yourself back up to the starting position.\n4. Repeat.",
          tips:
              "Keep your core engaged and maintain proper form throughout the exercise.",
          reps: 8,
          sets: 3,
        ),
        Exercise(
          name: "Incline Bench Press",
          muscleGroup: MuscleGroup.chest,
          description:
              "A variation of the bench press that targets the upper chest muscles.",
          instructions:
              "1. Lie on an incline bench with your back flat against it.\n2. Hold a barbell or dumbbells above your chest with your arms extended.\n3. Lower the weights to your chest.\n4. Push the weights back up.\n5. Repeat.",
          tips: "Keep your shoulders back and chest up for proper form.",
          reps: 8,
          sets: 3,
        ),
        Exercise(
          name: "Bench Press",
          muscleGroup: MuscleGroup.chest,
          description:
              "A classic strength-building exercise for the chest muscles.",
          instructions:
              "1. Lie on a flat bench with your back on it.\n2. Grip a barbell with your hands slightly wider than shoulder-width apart.\n3. Lower the bar to your chest.\n4. Push the barbell back up.\n5. Repeat.",
          tips:
              "Maintain a stable bench and use a spotter when lifting heavy weights.",
          reps: 8,
          sets: 3,
        ),
      ],
    ),
    Routine(
      id: const Uuid().v4(),
      name: 'Back Workout',
      description: 'A back workout routine for intermediate lifters',
      exercises: [
        Exercise(
          name: "Deadlift",
          muscleGroup: MuscleGroup.back,
          description:
              "A compound exercise targeting the lower and upper back muscles.",
          instructions:
              "1. Stand with your feet hip-width apart, a barbell in front of you.\n2. Bend at your hips and knees to lower your body and grip the barbell.\n3. Lift the barbell by extending your hips and knees, pulling your shoulders back.\n4. Lower the barbell to the ground by reversing the movement.\n5. Repeat.",
          tips:
              "Maintain a neutral spine and engage your core throughout the exercise.",
          reps: 8,
          sets: 3,
        ),
        Exercise(
          name: "Pull-up",
          muscleGroup: MuscleGroup.back,
          description:
              "A bodyweight exercise that targets the upper back and lats.",
          instructions:
              "1. Hang from a pull-up bar with your palms facing away from you.\n2. Pull your body upward until your chin is above the bar.\n3. Lower your body back down to the starting position.\n4. Repeat.",
          tips: "Focus on full range of motion and controlled movements.",
          reps: 8,
          sets: 3,
        ),
        Exercise(
          name: "Barbell Row",
          muscleGroup: MuscleGroup.back,
          description:
              "A compound exercise for the middle and upper back muscles.",
          instructions:
              "1. Stand with your feet hip-width apart, holding a barbell with an overhand grip.\n2. Bend at your hips and knees slightly, keeping your back straight.\n3. Pull the barbell toward your lower ribcage, squeezing your shoulder blades together.\n4. Lower the barbell back to the starting position.\n5. Repeat.",
          tips: "Keep your core engaged and maintain a strong posture.",
          reps: 8,
          sets: 3,
        ),
        Exercise(
          name: "Lat Pulldown",
          muscleGroup: MuscleGroup.back,
          description:
              "A machine exercise that targets the latissimus dorsi muscles.",
          instructions:
              "1. Sit at a lat pulldown machine with your thighs secured under the pads.\n2. Grip the bar with your hands wider than shoulder-width apart.\n3. Pull the bar down to your chest, squeezing your shoulder blades together.\n4. Slowly release the bar back to the starting position.\n5. Repeat.",
          tips: "Maintain proper posture and control the movement throughout.",
          reps: 8,
          sets: 3,
        ),
      ],
    ),
    Routine(
      id: const Uuid().v4(),
      name: 'Leg Workout',
      description: 'A routine for building strong legs',
      exercises: [
        Exercise(
          name: 'Squats',
          muscleGroup: MuscleGroup.legs,
          videoUrl: 'https://www.youtube.com/watch?v=ultWZbUMPL8',
          description: 'A compound exercise for building leg strength and size',
          instructions:
              '1. Stand with your feet shoulder-width apart. \n2. Lower your body as if you were sitting back into a chair. \n3. Keep your weight on your heels and your knees over your toes. \n4. Push yourself back up to the starting position. \n5. Repeat for the desired number of reps.',
          tips:
              'Engage your core and keep your chest up to maintain good form.',
          reps: 12,
          sets: 4,
        ),
        Exercise(
          name: 'Lunges',
          muscleGroup: MuscleGroup.legs,
          videoUrl: 'https://www.youtube.com/watch?v=QOVaHwm-Q6U',
          description:
              'A unilateral exercise for building leg strength and balance',
          instructions:
              '1. Stand with your feet hip-width apart. \n2. Take a big step forward with one leg. \n3. Lower your body until your front knee is at a 90-degree angle. \n4. Push yourself back up to the starting position. \n5. Repeat with the other leg. \n6. Alternate legs for the desired number of reps.',
          tips:
              'Keep your core tight and your front knee over your ankle to maintain good form.',
          reps: 10,
          sets: 3,
        ),
        Exercise(
          name: 'Deadlifts',
          muscleGroup: MuscleGroup.legs,
          videoUrl: 'https://www.youtube.com/watch?v=ytGaGIn3SjE',
          description: 'A compound exercise for building leg and back strength',
          instructions:
              '1. Stand with your feet hip-width apart. \n2. Bend down and grab the bar with an overhand grip. \n3. Keep your back straight and your core tight as you lift the bar. \n4. Lower the bar back down to the starting position. \n5. Repeat for the desired number of reps.',
          tips:
              'Engage your glutes and hamstrings to lift the weight, and keep your shoulders down and back to avoid rounding your back.',
          reps: 8,
          sets: 3,
        ),
        Exercise(
          name: 'Step-ups',
          muscleGroup: MuscleGroup.legs,
          videoUrl: 'https://www.youtube.com/watch?v=QDpJZ-EVYFA',
          description: 'An exercise for building leg strength and balance',
          instructions:
              '1. Stand in front of a bench or step. \n2. Step up onto the bench with one foot. \n3. Push through your heel to lift your body up onto the bench. \n4. Step back down with the same foot. \n5. Repeat with the other foot. \n6. Alternate feet for the desired number of reps.',
          tips:
              'Keep your core tight and your knee over your ankle to maintain good form.',
          reps: 12,
          sets: 3,
        ),
      ],
    ),
    Routine(
      id: const Uuid().v4(),
      name: 'Bicep Workout',
      description: 'A routine for building great biceps',
      exercises: [
        Exercise(
          name: 'Barbell curls',
          muscleGroup: MuscleGroup.bicep,
          videoUrl: 'https://www.youtube.com/watch?v=kwG2ipFRgfo',
          description:
              'A classic exercise for building bicep strength and size',
          instructions:
              '1. Stand with your feet shoulder-width apart and your arms straight down at your sides. \n2. Curl the barbell up to your chest, keeping your elbows close to your body. \n3. Lower the barbell back down to the starting position. \n4. Repeat for the desired number of reps.',
          tips:
              'Engage your core and keep your back straight to maintain good form.',
          reps: 8,
          sets: 3,
        ),
        Exercise(
          name: 'Dumbbell curls',
          muscleGroup: MuscleGroup.bicep,
          videoUrl: 'https://www.youtube.com/watch?v=5Msl9ZxVtJ4',
          description:
              'An exercise for building bicep strength and size with dumbbells',
          instructions:
              '1. Stand with your feet shoulder-width apart and your arms straight down at your sides, holding a dumbbell in each hand. \n2. Curl the dumbbells up to your chest, keeping your elbows close to your body. \n3. Lower the dumbbells back down to the starting position. \n4. Repeat for the desired number of reps.',
          tips:
              'Engage your core and keep your back straight to maintain good form.',
          reps: 8,
          sets: 3,
        ),
        Exercise(
          name: 'Hammer curls',
          muscleGroup: MuscleGroup.bicep,
          videoUrl: 'https://www.youtube.com/watch?v=TwD-YGVP4Bk',
          description:
              'An exercise for building bicep and forearm strength and size',
          instructions:
              '1. Stand with your feet shoulder-width apart and your arms straight down at your sides, holding a dumbbell in each hand with your palms facing in. \n2. Curl the dumbbells up to your chest, keeping your elbows close to your body. \n3. Lower the dumbbells back down to the starting position. \n4. Repeat for the desired number of reps.',
          tips:
              'Engage your core and keep your back straight to maintain good form.',
          reps: 8,
          sets: 3,
        ),
        Exercise(
          name: 'Preacher curls',
          muscleGroup: MuscleGroup.bicep,
          videoUrl: 'https://www.youtube.com/watch?v=K7Vr2v2l5VY',
          description:
              'An exercise for building bicep strength and size with a preacher bench',
          instructions:
              '1. Sit at a preacher bench with your arms straight down and your armpits resting on the pad. \n2. Curl the barbell up to your chest, keeping your elbows close to the pad. \n3. Lower the barbell back down to the starting position. \n4. Repeat for the desired number of reps.',
          tips:
              'Engage your core and keep your back straight to maintain good form.',
          reps: 8,
          sets: 3,
        ),
      ],
    ),
    Routine(
      id: const Uuid().v4(),
      name: 'Tricep Workout',
      description: 'A routine for building great triceps',
      exercises: [
        Exercise(
          name: 'Close-grip bench press',
          muscleGroup: MuscleGroup.tricep,
          videoUrl: 'https://www.youtube.com/watch?v=JGwWNGJdvx8',
          description:
              'A compound exercise for building tricep strength and size',
          instructions:
              '1. Lie on a bench with your feet flat on the floor. \n2. Grip the barbell with your hands close together. \n3. Lower the barbell down to your chest. \n4. Push the barbell back up to the starting position. \n5. Repeat for the desired number of reps.',
          tips:
              'Engage your core and keep your elbows close to your body to maintain good form.',
          reps: 8,
          sets: 3,
        ),
        Exercise(
          name: 'Tricep dips',
          muscleGroup: MuscleGroup.tricep,
          videoUrl: 'https://www.youtube.com/watch?v=32DquB9w0gk',
          description:
              'An exercise for building tricep strength and size with your bodyweight',
          instructions:
              '1. Stand facing away from a bench or chair. \n2. Place your hands on the bench or chair behind you. \n3. Lower your body down by bending your elbows. \n4. Push your body back up to the starting position. \n5. Repeat for the desired number of reps.',
          tips:
              'Engage your core and keep your shoulders down to maintain good form.',
          reps: 10,
          sets: 3,
        ),
        Exercise(
          name: 'Overhead tricep extension',
          muscleGroup: MuscleGroup.tricep,
          videoUrl: 'https://www.youtube.com/watch?v=4pJgTfjJN44',
          description:
              'An exercise for building tricep strength and size with a dumbbell',
          instructions:
              '1. Stand with your feet shoulder-width apart and hold a dumbbell with both hands. \n2. Raise the dumbbell above your head. \n3. Lower the dumbbell behind your head by bending your elbows. \n4. Raise the dumbbell back up to the starting position. \n5. Repeat for the desired number of reps.',
          tips:
              'Engage your core and keep your elbows close to your head to maintain good form.',
          reps: 10,
          sets: 3,
        ),
        Exercise(
          name: 'Tricep kickbacks',
          muscleGroup: MuscleGroup.tricep,
          videoUrl: 'https://www.youtube.com/watch?v=I33uEyxmVJk',
          description:
              'An exercise for building tricep strength and size with a dumbbell',
          instructions:
              '1. Stand with your feet shoulder-width apart and hold a dumbbell in each hand. \n2. Bend your knees slightly and hinge forward at the hips. \n3. Raise your elbows up to your sides. \n4. Extend your arms back behind you, squeezing your triceps. \n5. Lower the dumbbells back down to the starting position. \n6. Repeat for the desired number of reps.',
          tips:
              'Engage your core and keep your back straight to maintain good form.',
          reps: 12,
          sets: 3,
        ),
        Exercise(
          name: 'Skull crushers',
          muscleGroup: MuscleGroup.tricep,
          videoUrl: 'https://www.youtube.com/watch?v=BYZF8zVl5xM',
          description:
              'An exercise for building tricep strength and size with a barbell or dumbbells',
          instructions:
              '1. Lie on a bench with your feet flat on the floor. \n2. Hold a barbell or dumbbells with your hands shoulder-width apart. \n3. Lower the barbell or dumbbells down to your forehead. \n4. Push the barbell or dumbbells back up to the starting position. \n5. Repeat for the desired number of reps.',
          tips:
              'Engage your core and keep your elbows close to your head to maintain good form.',
          reps: 10,
          sets: 3,
        ),
        Exercise(
          name: 'Diamond push-ups',
          muscleGroup: MuscleGroup.tricep,
          videoUrl: 'https://www.youtube.com/watch?v=J1v2McKbkLo',
          description:
              'An exercise for building tricep strength and size with your bodyweight',
          instructions:
              '1. Get into a push-up position with your hands close together, forming a diamond shape with your fingers. \n2. Lower your body down by bending your elbows. \n3. Push your body back up to the starting position. \n4. Repeat for the desired number of reps.',
          tips:
              'Engage your core and keep your back straight to maintain good form.',
          reps: 12,
          sets: 3,
        ),
      ],
    )
  ];

  List<Exercise> allExercises = [
    Exercise(
      name: "Push-up",
      muscleGroup: MuscleGroup.chest,
      description: "A classic bodyweight exercise for chest muscles.",
      instructions:
          "1. Start in a plank position with your hands shoulder-width apart.\n2. Lower your body by bending your elbows, keeping your body in a straight line.\n3. Push yourself back up to the starting position.\n4. Repeat.",
      tips:
          "Keep your core engaged and maintain proper form throughout the exercise.",
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: "Incline Bench Press",
      muscleGroup: MuscleGroup.chest,
      description:
          "A variation of the bench press that targets the upper chest muscles.",
      instructions:
          "1. Lie on an incline bench with your back flat against it.\n2. Hold a barbell or dumbbells above your chest with your arms extended.\n3. Lower the weights to your chest.\n4. Push the weights back up.\n5. Repeat.",
      tips: "Keep your shoulders back and chest up for proper form.",
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: "Bench Press",
      muscleGroup: MuscleGroup.chest,
      description:
          "A classic strength-building exercise for the chest muscles.",
      instructions:
          "1. Lie on a flat bench with your back on it.\n2. Grip a barbell with your hands slightly wider than shoulder-width apart.\n3. Lower the bar to your chest.\n4. Push the barbell back up.\n5. Repeat.",
      tips:
          "Maintain a stable bench and use a spotter when lifting heavy weights.",
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: "Dumbbell Press",
      muscleGroup: MuscleGroup.chest,
      description:
          "An alternative to the bench press using dumbbells for chest development.",
      instructions:
          "1. Lie on a flat bench with a dumbbell in each hand, palms facing forward.\n2. Push the dumbbells up until your arms are fully extended.\n3. Lower the dumbbells back to chest level.\n4. Repeat.",
      tips: "Focus on controlled movements and proper breathing.",
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: "Incline Dumbbell Press",
      muscleGroup: MuscleGroup.chest,
      description:
          "Similar to incline bench press but using dumbbells for chest and upper chest development.",
      instructions:
          "1. Lie on an incline bench with a dumbbell in each hand.\n2. Press the dumbbells up over your chest until your arms are fully extended.\n3. Lower the dumbbells back to chest level.\n4. Repeat.",
      tips: "Keep your shoulders back and chest up throughout the exercise.",
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: "Cable Fly",
      muscleGroup: MuscleGroup.chest,
      description:
          "An isolation exercise using a cable machine to target chest muscles.",
      instructions:
          "1. Stand between two cable towers, holding a cable handle in each hand.\n2. Keep your arms slightly bent and palms facing each other.\n3. Bring your hands together in front of you, squeezing your chest.\n4. Return to the starting position.\n5. Repeat.",
      tips:
          "Focus on the mind-muscle connection and a controlled range of motion.",
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: "Decline Push-up",
      muscleGroup: MuscleGroup.chest,
      description: "A push-up variation that targets the lower chest muscles.",
      instructions:
          "1. Place your feet on an elevated surface, such as a bench.\n2. Assume a push-up position with your hands on the ground.\n3. Lower your body by bending your elbows, keeping your body in a straight line.\n4. Push yourself back up to the starting position.\n5. Repeat.",
      tips:
          "Ensure your body remains in a straight line, and your core is engaged.",
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: "Deadlift",
      muscleGroup: MuscleGroup.back,
      description:
          "A compound exercise targeting the lower and upper back muscles.",
      instructions:
          "1. Stand with your feet hip-width apart, a barbell in front of you.\n2. Bend at your hips and knees to lower your body and grip the barbell.\n3. Lift the barbell by extending your hips and knees, pulling your shoulders back.\n4. Lower the barbell to the ground by reversing the movement.\n5. Repeat.",
      tips:
          "Maintain a neutral spine and engage your core throughout the exercise.",
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: "Pull-up",
      muscleGroup: MuscleGroup.back,
      description:
          "A bodyweight exercise that targets the upper back and lats.",
      instructions:
          "1. Hang from a pull-up bar with your palms facing away from you.\n2. Pull your body upward until your chin is above the bar.\n3. Lower your body back down to the starting position.\n4. Repeat.",
      tips: "Focus on full range of motion and controlled movements.",
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: "Barbell Row",
      muscleGroup: MuscleGroup.back,
      description: "A compound exercise for the middle and upper back muscles.",
      instructions:
          "1. Stand with your feet hip-width apart, holding a barbell with an overhand grip.\n2. Bend at your hips and knees slightly, keeping your back straight.\n3. Pull the barbell toward your lower ribcage, squeezing your shoulder blades together.\n4. Lower the barbell back to the starting position.\n5. Repeat.",
      tips: "Keep your core engaged and maintain a strong posture.",
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: "Lat Pulldown",
      muscleGroup: MuscleGroup.back,
      description:
          "A machine exercise that targets the latissimus dorsi muscles.",
      instructions:
          "1. Sit at a lat pulldown machine with your thighs secured under the pads.\n2. Grip the bar with your hands wider than shoulder-width apart.\n3. Pull the bar down to your chest, squeezing your shoulder blades together.\n4. Slowly release the bar back to the starting position.\n5. Repeat.",
      tips: "Maintain proper posture and control the movement throughout.",
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: "T-Bar Row",
      muscleGroup: MuscleGroup.back,
      description:
          "An exercise using a T-Bar row machine to target the middle and upper back muscles.",
      instructions:
          "1. Straddle the T-Bar row machine and place the desired weight on it.\n2. Bend at your hips and knees, keeping your back straight.\n3. Grip the handles with an overhand grip.\n4. Pull the handles toward your lower ribcage, squeezing your shoulder blades together.\n5. Lower the handles back to the starting position.\n6. Repeat.",
      tips:
          "Maintain a strong posture and control the weight throughout the movement.",
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: "Bent Over Row",
      muscleGroup: MuscleGroup.back,
      description:
          "An exercise using dumbbells to target the upper back and lats.",
      instructions:
          "1. Stand with your feet hip-width apart, holding a dumbbell in each hand.\n2. Bend at your hips and knees slightly, keeping your back straight.\n3. Pull the dumbbells toward your lower ribcage, squeezing your shoulder blades together.\n4. Lower the dumbbells back to the starting position.\n5. Repeat.",
      tips: "Maintain a neutral spine and engage your core for stability.",
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: 'Calf raises',
      muscleGroup: MuscleGroup.legs,
      videoUrl: 'https://www.youtube.com/watch?v=2pX7wKlAtR8',
      description: 'An exercise for building calf strength and size',
      instructions:
          '1. Stand with your feet hip-width apart. \n2. Raise up onto the balls of your feet. \n3. Lower yourself back down to the starting position. \n4. Repeat for the desired number of reps.',
      tips:
          'Engage your core and keep your knees straight to maintain good form.',
      reps: 15,
      sets: 3,
    ),
    Exercise(
      name: 'Leg press',
      muscleGroup: MuscleGroup.legs,
      videoUrl: 'https://www.youtube.com/watch?v=DKG2ZJjUoWk',
      description: 'A machine exercise for building leg strength and size',
      instructions:
          '1. Sit in the leg press machine with your feet on the platform. \n2. Push the platform away from you with your feet. \n3. Lower the platform back down to the starting position. \n4. Repeat for the desired number of reps.',
      tips:
          'Engage your core and keep your back flat against the seat to maintain good form.',
      reps: 10,
      sets: 3,
    ),
    Exercise(
      name: 'Leg extensions',
      muscleGroup: MuscleGroup.legs,
      videoUrl: 'https://www.youtube.com/watch?v=YyvSfVjQeL0',
      description:
          'A machine exercise for building quadriceps strength and size',
      instructions:
          '1. Sit in the leg extension machine with your feet under the pad. \n2. Extend your legs to lift the pad up. \n3. Lower the pad back down to the starting position. \n4. Repeat for the desired number of reps.',
      tips:
          'Engage your core and keep your back flat against the seat to maintain good form.',
      reps: 12,
      sets: 3,
    ),
    Exercise(
      name: 'Hamstring curls',
      muscleGroup: MuscleGroup.legs,
      videoUrl: 'https://www.youtube.com/watch?v=0M4bwPYJFy4',
      description:
          'A machine exercise for building hamstring strength and size',
      instructions:
          '1. Lie face down on the hamstring curl machine with your feet under the pad. \n2. Curl your legs up to lift the pad up. \n3. Lower the pad back down to the starting position. \n4. Repeat for the desired number of reps.',
      tips:
          'Engage your core and keep your hips flat against the bench to maintain good form.',
      reps: 12,
      sets: 3,
    ),
    Exercise(
      name: 'Box jumps',
      muscleGroup: MuscleGroup.legs,
      videoUrl: 'https://www.youtube.com/watch?v=hxldGZ0i3pE',
      description:
          'A plyometric exercise for building leg power and explosiveness',
      instructions:
          '1. Stand in front of a box or step. \n2. Jump up onto the box with both feet. \n3. Step back down to the starting position. \n4. Repeat for the desired number of reps.',
      tips:
          'Engage your core and use your arms to help generate power for the jump.',
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: 'Wall sits',
      muscleGroup: MuscleGroup.legs,
      videoUrl: 'https://www.youtube.com/watch?v=y-wV4Venusw',
      description: 'An isometric exercise for building leg endurance',
      instructions:
          '1. Stand with your back against a wall. \n2. Lower your body down until your thighs are parallel to the ground. \n3. Hold this position for the desired amount of time.',
      tips:
          'Engage your core and keep your back flat against the wall to maintain good form.',
      seconds: 30,
      sets: 3,
    ),
    Exercise(
      name: 'Squats',
      muscleGroup: MuscleGroup.legs,
      videoUrl: 'https://www.youtube.com/watch?v=ultWZbUMPL8',
      description: 'A compound exercise for building leg strength and size',
      instructions:
          '1. Stand with your feet shoulder-width apart. \n2. Lower your body as if you were sitting back into a chair. \n3. Keep your weight on your heels and your knees over your toes. \n4. Push yourself back up to the starting position. \n5. Repeat for the desired number of reps.',
      tips: 'Engage your core and keep your chest up to maintain good form.',
      reps: 12,
      sets: 4,
    ),
    Exercise(
      name: 'Lunges',
      muscleGroup: MuscleGroup.legs,
      videoUrl: 'https://www.youtube.com/watch?v=QOVaHwm-Q6U',
      description:
          'A unilateral exercise for building leg strength and balance',
      instructions:
          '1. Stand with your feet hip-width apart. \n2. Take a big step forward with one leg. \n3. Lower your body until your front knee is at a 90-degree angle. \n4. Push yourself back up to the starting position. \n5. Repeat with the other leg. \n6. Alternate legs for the desired number of reps.',
      tips:
          'Keep your core tight and your front knee over your ankle to maintain good form.',
      reps: 10,
      sets: 3,
    ),
    Exercise(
      name: 'Deadlifts',
      muscleGroup: MuscleGroup.legs,
      videoUrl: 'https://www.youtube.com/watch?v=ytGaGIn3SjE',
      description: 'A compound exercise for building leg and back strength',
      instructions:
          '1. Stand with your feet hip-width apart. \n2. Bend down and grab the bar with an overhand grip. \n3. Keep your back straight and your core tight as you lift the bar. \n4. Lower the bar back down to the starting position. \n5. Repeat for the desired number of reps.',
      tips:
          'Engage your glutes and hamstrings to lift the weight, and keep your shoulders down and back to avoid rounding your back.',
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: 'Step-ups',
      muscleGroup: MuscleGroup.legs,
      videoUrl: 'https://www.youtube.com/watch?v=QDpJZ-EVYFA',
      description: 'An exercise for building leg strength and balance',
      instructions:
          '1. Stand in front of a bench or step. \n2. Step up onto the bench with one foot. \n3. Push through your heel to lift your body up onto the bench. \n4. Step back down with the same foot. \n5. Repeat with the other foot. \n6. Alternate feet for the desired number of reps.',
      tips:
          'Keep your core tight and your knee over your ankle to maintain good form.',
      reps: 12,
      sets: 3,
    ),
    Exercise(
      name: 'Barbell curls',
      muscleGroup: MuscleGroup.bicep,
      videoUrl: 'https://www.youtube.com/watch?v=kwG2ipFRgfo',
      description: 'A classic exercise for building bicep strength and size',
      instructions:
          '1. Stand with your feet shoulder-width apart and your arms straight down at your sides. \n2. Curl the barbell up to your chest, keeping your elbows close to your body. \n3. Lower the barbell back down to the starting position. \n4. Repeat for the desired number of reps.',
      tips:
          'Engage your core and keep your back straight to maintain good form.',
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: 'Dumbbell curls',
      muscleGroup: MuscleGroup.bicep,
      videoUrl: 'https://www.youtube.com/watch?v=5Msl9ZxVtJ4',
      description:
          'An exercise for building bicep strength and size with dumbbells',
      instructions:
          '1. Stand with your feet shoulder-width apart and your arms straight down at your sides, holding a dumbbell in each hand. \n2. Curl the dumbbells up to your chest, keeping your elbows close to your body. \n3. Lower the dumbbells back down to the starting position. \n4. Repeat for the desired number of reps.',
      tips:
          'Engage your core and keep your back straight to maintain good form.',
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: 'Hammer curls',
      muscleGroup: MuscleGroup.bicep,
      videoUrl: 'https://www.youtube.com/watch?v=TwD-YGVP4Bk',
      description:
          'An exercise for building bicep and forearm strength and size',
      instructions:
          '1. Stand with your feet shoulder-width apart and your arms straight down at your sides, holding a dumbbell in each hand with your palms facing in. \n2. Curl the dumbbells up to your chest, keeping your elbows close to your body. \n3. Lower the dumbbells back down to the starting position. \n4. Repeat for the desired number of reps.',
      tips:
          'Engage your core and keep your back straight to maintain good form.',
      reps: 8,
      sets: 3,
    ),
    Exercise(
      name: 'Preacher curls',
      muscleGroup: MuscleGroup.bicep,
      videoUrl: 'https://www.youtube.com/watch?v=K7Vr2v2l5VY',
      description:
          'An exercise for building bicep strength and size with a preacher bench',
      instructions:
          '1. Sit at a preacher bench with your arms straight down and your armpits resting on the pad. \n2. Curl the barbell up to your chest, keeping your elbows close to the pad. \n3. Lower the barbell back down to the starting position. \n4. Repeat for the desired number of reps.',
      tips:
          'Engage your core and keep your back straight to maintain good form.',
      reps: 8,
      sets: 3,
    ),
  ];

  @override
  Future<bool> add(Routine data) async {
    Timer(const Duration(seconds: 2), () => false);
    allRoutines.add(data);
    return true;
  }

  @override
  Future<bool> delete(String id) async {
    Timer(const Duration(seconds: 2), () => false);
    try {
      allRoutines.removeWhere((element) => element.id == id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Routine>> getAll() async {
    Timer(const Duration(seconds: 2), () => false);
    return allRoutines;
  }

  @override
  Future<Routine?> getById(String id) async {
    Timer(const Duration(seconds: 2), () => false);
    try {
      return allRoutines.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> update(Routine data) async {
    Timer(const Duration(seconds: 2), () => false);
    final int index =
        allRoutines.indexWhere((element) => element.id == data.id);
    try {
      allRoutines.replaceRange(index, index + 1, [data]);
      return true;
    } catch (e) {
      return false;
    }
  }
}
