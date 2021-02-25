import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class TileButton extends StatelessWidget {
  final String label;
  final Widget content;
  final bool isActive;
  final Widget icon;
  final Function onTap;
  TileButton({
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
        color: appStyles.inactiveCardColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(color: appStyles.currentAppThemeTextColor),
                    textAlign: TextAlign.start,
                  ),
                  content,
                ],
              ),
              icon == null ? Container() : icon,
            ],
          ),
        ),
      ),
    );
  }
}
