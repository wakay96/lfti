import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class TileButton extends StatelessWidget {
  final String label;
  final Widget content;
  final bool isActive;

  TileButton({
    this.label = '',
    this.isActive = false,
    @required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: isActive
              ? appStyles.primaryActiveColor
              : appStyles.inactiveBackgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
          border: appStyles.inactiveBorder,
        ),
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              label,
              style: appStyles.whiteLabelText,
            ),
            content
          ],
        ),
      ),
    );
  }
}
