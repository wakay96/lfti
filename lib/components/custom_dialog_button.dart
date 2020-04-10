import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";

class CustomDialogButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final Color color;
  const CustomDialogButton({
    @required this.label,
    @required this.onPressed,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: this.color,
      child: Text(
        this.label,
        style: kSmallTextStyle,
      ),
      onPressed: this.onPressed,
    );
  }
}
