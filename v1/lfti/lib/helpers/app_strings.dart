const String LB_UNIT_TEXT = 'lb';
const String KILOGRAM_UNIT_TEXT = 'kg';
const String PERCENT_UNIT = '%';
const String CURRENT_LABEL = 'CURRENT';
const String GOAL_LABEL = 'GOAL';
const String REST_ACTIVITY_NAME = 'Rest';
const String REST_ACTIVITY_DESC = '';
const String DEFAULT_WORKOUT_NAME = 'unnamed';
const String DEFAULT_WORKOUT_DESC = '';
const String DEFAULT_EXERCISE_NAME = 'unnamed';
const String DEFAULT_EXERCISE_DESC = '';
const String DAY_UNIT = 'day';
const String MINUTE_UNIT = 'min';
const String HOUR_UNIT = 'hour';
const String SESSION_TEXT = 'session';

/// App Messages
const String GOAL_MET_MESSAGE = 'Goal Met!';
const String TIME_UP_MESSAGE = 'Time\'s up!';
const String NOT_SET_MESSAGE = 'Not set.';

/// App Bar Titles
const String DASHBOARD_HEADER_TEXT = 'dashboard';

/// Error Strings
const String EMPTY_LIST_ERROR = 'No items in List.';
const String ITEM_NOT_FOUND_ERROR = 'Item does not exist.';

class WeekdayNames {
  static const Monday = 'Monday';
  static const Tuesday = 'Tuesday';
  static const Wednesday = 'Wednesday';
  static const Thursday = 'Thursday';
  static const Friday = 'Friday';
  static const Saturday = 'Saturday';
  static const Sunday = 'Sunday';
}

class Target {
  static const Chest = 'Chest';
  static const Back = 'Back';
  static const Core = 'Core';
  static const Leg = 'Leg';
  static const Arm = 'Arm';
  static const Shoulder = 'Shoulder';
  static const Custom = 'Custom';
}

class WorkoutType {
  static const Custom = 'Custom';
  static const Superset = 'Superset';
  static const TwoMuscleGroup = 'TwoMuscleGroup';
  static const SingleMuscleFocus = 'SingleMuscleFocus';
}
