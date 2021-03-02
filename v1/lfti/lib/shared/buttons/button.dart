import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart';

class Button extends StatelessWidget {
  final Function _onTap;
  final String _label;
  final Color color;

  Button(this._label, this._onTap, {this.color = currentActiveButtonColor});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: color,
      onPressed: _onTap,
      child: Text(
        '$_label',
        style: currentButtonTextTheme,
      ),
      shape: RoundedRectangleBorder(borderRadius: buttonBorderRadius),
    );
  }
}
