import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class AppIcon {
  static const weight = FaIcon(
    FontAwesomeIcons.weight,
    color: appStyles.weightThemeColor,
    size: 35,
  );

  static const bodyFat = FaIcon(
    FontAwesomeIcons.fire,
    color: appStyles.bodyFatThemeColor,
    size: 35,
  );

  static const activeWorkout = FaIcon(
    FontAwesomeIcons.running,
    color: appStyles.workoutThemeColor,
    size: 35,
  );

  static const inactiveWorkout = FaIcon(
    FontAwesomeIcons.running,
    color: appStyles.tertiaryColor,
    size: 35,
  );

  static const previousWorkout = FaIcon(
    FontAwesomeIcons.walking,
    color: appStyles.workoutThemeColor,
    size: 35,
  );

  static const skippedWorkout = FaIcon(
    FontAwesomeIcons.running,
    color: appStyles.skippedWorkoutColor,
    size: 35,
  );

  static const rest = FaIcon(
    FontAwesomeIcons.bed,
    color: appStyles.restThemeColor,
    size: 30,
  );

  static const time = FaIcon(
    FontAwesomeIcons.solidClock,
    color: appStyles.timeThemeColor,
    size: 30,
  );

  static const inactiveDashboard = FaIcon(
    FontAwesomeIcons.home,
    color: appStyles.tertiaryColor,
    size: 30,
  );

  static const activeDashboard = FaIcon(
    FontAwesomeIcons.home,
    color: appStyles.workoutThemeColor,
    size: 30,
  );
}
