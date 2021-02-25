import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class IconService {
  static const weightIcon = FaIcon(
    FontAwesomeIcons.weight,
    color: appStyles.weightThemeColor,
    size: 30,
  );

  static const bodyFatIcon = FaIcon(
    FontAwesomeIcons.fire,
    color: appStyles.bodyFatThemeColor,
    size: 30,
  );

  static const workoutIcon = FaIcon(
    FontAwesomeIcons.running,
    color: appStyles.workoutThemeColor,
    size: 30,
  );
}
