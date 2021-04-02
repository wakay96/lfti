import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class AppIcon {
  static const done = FaIcon(FontAwesomeIcons.check);
  static const play = FaIcon(FontAwesomeIcons.play);
  static const add = FaIcon(FontAwesomeIcons.plus);
  static const trash = FaIcon(FontAwesomeIcons.trash);
  static const backArrow = FaIcon(FontAwesomeIcons.angleLeft);
  static const weight = FaIcon(
    FontAwesomeIcons.weight,
    color: appStyles.weightThemeColor,
    size: 25,
  );

  static const bodyFat = FaIcon(
    FontAwesomeIcons.fire,
    color: appStyles.bodyFatThemeColor,
    size: 25,
  );

  static const activeWorkout = FaIcon(
    FontAwesomeIcons.running,
    color: appStyles.workoutThemeColor,
    size: 25,
  );

  static const inactiveWorkout = FaIcon(
    FontAwesomeIcons.dumbbell,
    color: Colors.grey,
    size: 20,
  );

  static const previousWorkout = FaIcon(
    FontAwesomeIcons.walking,
    color: appStyles.workoutThemeColor,
    size: 25,
  );

  static const rest = FaIcon(
    FontAwesomeIcons.bed,
    color: Colors.grey,
    size: 20,
  );

  static const inactiveDashboard = FaIcon(
    FontAwesomeIcons.home,
    color: appStyles.tertiaryColor,
    size: 25,
  );

  static const activeDashboard = FaIcon(
    FontAwesomeIcons.home,
    color: appStyles.workoutThemeColor,
    size: 25,
  );
}
