import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final String label;
  final buttonAction;
  CustomButton({
    this.buttonColor = Colors.blueAccent,
    @required this.label,
    @required this.buttonAction,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: buttonColor,
      textColor: kMainBackgroundColor,
      child: Text(label, style: kMediumBoldTextStyle),
      onPressed: buttonAction,
    );
  }
}
