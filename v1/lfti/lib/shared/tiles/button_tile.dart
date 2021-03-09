import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart';

class ButtonTile extends StatelessWidget {
  final String label;
  final Widget content;
  final bool isActive;
  final Widget icon;
  final Function onTap;
  final Color color;

  ButtonTile({
    @required this.content,
    this.label = '',
    this.isActive = false,
    this.icon,
    this.onTap,
    this.color = inactiveCardColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: buttonBorderRadius),
        color: color,
        child: Padding(
          padding: cardPadding,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    label,
                    style: labelSmallTextStyle,
                    textAlign: TextAlign.start,
                  ),
                  content,
                ]),
                icon == null ? Container() : icon,
              ]),
        ),
      ),
    );
  }
}
