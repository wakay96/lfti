import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class RowContent extends StatelessWidget {
  final String content;
  final String subContent;
  final Color color;
  RowContent({
    this.content,
    this.subContent = '',
    this.color = appStyles.currentAppThemeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: content,
          style: TextStyle(
              fontSize: appStyles.MEDIUM_TEXT,
              color: color,
              fontWeight: FontWeight.w900),
        ),
        TextSpan(text: ' '),
        TextSpan(
          text: subContent.toUpperCase(),
          style: TextStyle(fontSize: appStyles.MEDIUM_TEXT, color: color),
        ),
      ]),
    );
  }
}
