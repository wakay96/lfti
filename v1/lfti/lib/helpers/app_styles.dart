import 'package:flutter/material.dart';

// Colors
const Color inactiveBackgroundColor = Colors.transparent;
const Color primaryInactiveColor = Color(0xFF448FA3);
const Color primaryActiveColor = Color(0xFF0197F6);
const Color primaryColor = Color(0xFFF1F0CC);

// used
const Color weightThemeColor = Color(0xFF68C5DB);
const Color bodyFatThemeColor = Color(0xFFFFE200);
const Color workoutThemeColor = primaryColor;
const Color exerciseThemeColor = workoutThemeColor;
const Color restThemeColor = weightThemeColor;
const Color dangerColor = Colors.red;

const Color secondaryColor = Color(0xFF0197F6);
const Color tertiaryColor = Color(0xAFFAFAFA);
const Color inactiveCardColor = Color(0xFF053055);

// Padding
const EdgeInsets primaryContainerPadding = EdgeInsets.all(20.0);
const EdgeInsets cardPadding = EdgeInsets.all(12.0);
const EdgeInsets primaryContainerSidePadding =
    EdgeInsets.only(left: 15.0, right: 15.0);
const EdgeInsets cardHorizontalSpacing = EdgeInsets.only(bottom: 5, top: 5);

// FONT SIZE
const double XS_TEXT = 12;
const double DETAILS = 14;
const double BODY_TEXT = 16;
const double SUBTITLE = 18;
const double TITLE = 24;
const double MAIN_TITLE = 42;

const Color lightThemeTextColor = Color(0xFF363636);
const Color darkThemeTextColor = Color(0xFFFAFAFA);
const Color currentAppThemeTextColor = darkThemeTextColor;

// Button Styles
const TextStyle currentButtonTextTheme = smallTextStyle;
const Color buttonDarkThemeActiveColor = secondaryColor;
const Color currentActiveButtonColor = buttonDarkThemeActiveColor;

// TextStyles
const TextStyle smallTextStyle = TextStyle(
  color: currentAppThemeTextColor,
  fontSize: DETAILS,
);

const TextStyle mediumTextStyle = TextStyle(
  color: currentAppThemeTextColor,
  fontSize: BODY_TEXT,
);

const TextStyle largeTextStyle = TextStyle(
  color: currentAppThemeTextColor,
  fontSize: TITLE,
);

const TextStyle workoutMediumTextStyle = TextStyle(
  color: workoutThemeColor,
  fontSize: BODY_TEXT,
);

const TextStyle exerciseLargeTextStyle = TextStyle(
  color: exerciseThemeColor,
  fontSize: TITLE,
);

const TextStyle exerciseMediumTextStyle = TextStyle(
  color: exerciseThemeColor,
  fontSize: BODY_TEXT,
);

const TextStyle exerciseSmallTextStyle = TextStyle(
  color: exerciseThemeColor,
  fontSize: DETAILS,
);

const TextStyle restMediumTextStyle = TextStyle(
  color: restThemeColor,
  fontSize: DETAILS,
);

const TextStyle activitySmallTextStyle = TextStyle(
  color: exerciseThemeColor,
  fontSize: BODY_TEXT,
);

const TextStyle buttonTextStyle = TextStyle(
  color: currentAppThemeTextColor,
  fontSize: BODY_TEXT,
);

const TextStyle labelSmallTextStyle = TextStyle(
  color: tertiaryColor,
  fontSize: XS_TEXT,
);

const TextStyle labelMediumTextStyle = TextStyle(
  color: currentAppThemeTextColor,
  fontSize: DETAILS,
);

const TextStyle uneditableMediumTextStyle = TextStyle(
    color: currentAppThemeTextColor,
    fontSize: BODY_TEXT,
    fontWeight: FontWeight.bold);

const TextStyle appBarTitleTextStyleLight = TextStyle(
  color: Colors.white,
);

/// decorations
final activeBorder = Border.all(
  color: primaryActiveColor,
);

final inactiveBorder = Border.all(
  color: primaryInactiveColor,
);

final borderRadius = BorderRadius.circular(8.0);
final buttonBorderRadius = BorderRadius.circular(6.0);

/// snackbar
final snackBarShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
);
