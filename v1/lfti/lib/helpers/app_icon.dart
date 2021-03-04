import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class AppIcon {
  static const weightIcon = FaIcon(
    FontAwesomeIcons.weight,
    color: appStyles.weightThemeColor,
    size: 35,
  );

  static const bodyFatIcon = FaIcon(
    FontAwesomeIcons.fire,
    color: appStyles.bodyFatThemeColor,
    size: 35,
  );

  static const workoutIcon = FaIcon(
    FontAwesomeIcons.running,
    color: appStyles.workoutThemeColor,
    size: 35,
  );

  static const previousWorkoutIcon = FaIcon(
    FontAwesomeIcons.walking,
    color: appStyles.workoutThemeColor,
    size: 35,
  );

  static const skippedWorkoutIcon = FaIcon(
    FontAwesomeIcons.running,
    color: appStyles.skippedWorkoutColor,
    size: 35,
  );

  static const restIcon = FaIcon(
    FontAwesomeIcons.bed,
    color: appStyles.restThemeColor,
    size: 30,
  );

  static const timeIcon = FaIcon(
    FontAwesomeIcons.solidClock,
    color: appStyles.timeThemeColor,
    size: 30,
  );
}
