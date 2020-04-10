import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";

class BottomNavigationButton extends StatelessWidget {
  final String label;
  final Function action;
  final Color color;
  BottomNavigationButton({
    @required this.label,
    @required this.action,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        color: color,
        height: kStartButtonHeight,
        child: Center(
          child: Text(
            label,
            style: kBottomButtonTextFontStyle,
          ),
        ),
      ),
    );
  }
}
