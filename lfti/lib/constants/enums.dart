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
  routineDetails(
    '/routineDetails',
    'Routine Details',
    Icon(Icons.fitness_center),
  ),
  exerciseDetails(
    '/exerciseDetails',
    'Exercise Details',
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
