import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;
import 'package:lfti/helpers/app_styles.dart';

class ButtonTile extends StatelessWidget {
  final String label;
  final Widget content;
  final bool isActive;
  final Widget icon;
  final Function onTap;

  ButtonTile({
    @required this.content,
    this.label = '',
    this.isActive = false,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: appStyles.borderRadius),
        color: appStyles.inactiveCardColor,
        child: Padding(
          padding: cardPadding,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    label,
                    style: TextStyle(color: appStyles.currentAppThemeTextColor),
                    textAlign: TextAlign.start,
                  ),
                  content,
                ]),
                Container(child: icon),
              ]),
        ),
      ),
    );
  }
}
