import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";

class BottomNavigationButton extends StatelessWidget {
  final String label;
  final Function action;
  final Color color;
  final IconData icon;
  BottomNavigationButton({
    @required this.label,
    @required this.action,
    @required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        color: color,
        height: kBottomButtonHeight,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                label,
                style: kBottomButtonTextFontStyle,
              ),
              icon != null
                  ? Icon(
                      icon,
                      size: 50.0,
                      color: Colors.white,
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
