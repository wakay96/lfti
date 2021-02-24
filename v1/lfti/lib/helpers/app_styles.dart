import 'package:flutter/material.dart';

/// Colors
const Color inactiveBackgroundColor = Colors.transparent;
const Color primaryInactiveColor = Color(0xFF448FA3);
const Color primaryActiveColor = Color(0xFF0197F6);
const Color tertiaryColor = Colors.grey;
const Color primaryColor = Color(0xFF02182b);
const Color dangerColor = Color(0xFFD7263D);

/// Padding
const EdgeInsets primaryContainerPadding = EdgeInsets.all(20.0);
const EdgeInsets primaryContainerSidePadding =
    EdgeInsets.only(left: 20.0, right: 20.0);

/// TextStyles
const TextStyle appBarTitleTextStyleLight = TextStyle(
  color: Colors.white,
);

const TextStyle whiteBLText = TextStyle(
  color: Colors.white,
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

const TextStyle whiteBmLText = TextStyle(
  color: Colors.white,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

const TextStyle whiteNMText = TextStyle(
  color: Colors.white,
  fontSize: 12,
);

const TextStyle whiteIMText = TextStyle(
  color: Colors.white,
  fontSize: 12,
  fontStyle: FontStyle.italic,
);

const TextStyle whiteLabelText = TextStyle(
  color: Colors.white,
  fontSize: 10,
);

const TextStyle grayLabelText = TextStyle(
  color: tertiaryColor,
  fontSize: 10,
);

/// dark text
const TextStyle darkLabelText = TextStyle(
  color: primaryColor,
  fontSize: 10,
);
const TextStyle blackBLText = TextStyle(
  color: Colors.black,
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

const TextStyle blackBmLText = TextStyle(
  color: Colors.black,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

const TextStyle blackNMText = TextStyle(
  color: Colors.black,
  fontSize: 12,
);

const TextStyle blackIMText = TextStyle(
  color: Colors.black,
  fontSize: 12,
  fontStyle: FontStyle.italic,
);

/// decorations
final activeBorder = Border.all(
  color: primaryActiveColor,
);

final inactiveBorder = Border.all(
  color: primaryInactiveColor,
);
