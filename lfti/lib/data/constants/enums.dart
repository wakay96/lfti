import 'package:flutter/material.dart';

enum AppPage {
  log(
    '/log',
    'Log',
    Icon(Icons.timer),
  ),
  routines(
    '/routines',
    'Routines',
    Icon(Icons.fitness_center),
  ),
  statistics(
    'statistics',
    'Statistics',
    Icon(Icons.bar_chart),
  ),
  profile(
    '/profile',
    'Profile',
    Icon(Icons.person),
  );

  final String path;
  final String title;
  final Icon icon;
  const AppPage(
    this.path,
    this.title,
    this.icon,
  );
}

enum AppSubPage {
  sessionPage(
    '/sessionPage',
    'Running Session',
    Icon(Icons.directions_run_rounded),
  ),
  routineDetails(
    '/routineDetails',
    'Routine Details',
    Icon(Icons.fitness_center),
  ),
  addRoutine(
    '/addRoutine',
    'Add Routine',
    Icon(Icons.fitness_center),
  ),
  exerciseDetails(
    '/exerciseDetails',
    'Exercise Details',
    Icon(Icons.fitness_center),
  ),
  exerciseList(
    '/exerciseList',
    'Exercises',
    Icon(Icons.fitness_center),
  ),
  updateExercise(
    '/updateDetails',
    'Update Exercise',
    Icon(Icons.fitness_center),
  );

  final String path;
  final String title;
  final Icon icon;

  const AppSubPage(
    this.path,
    this.title,
    this.icon,
  );
}

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
