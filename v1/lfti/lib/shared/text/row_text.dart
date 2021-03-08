import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class RowText extends StatelessWidget {
  final String content;
  final String subContent;
  final Color color;
  RowText({
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
          style: TextStyle(fontSize: appStyles.DETAILS, color: color),
        ),
        TextSpan(text: ' '),
        TextSpan(
          text: subContent.toUpperCase(),
          style: TextStyle(fontSize: appStyles.BODY_TEXT, color: color),
        ),
      ]),
    );
  }
}
