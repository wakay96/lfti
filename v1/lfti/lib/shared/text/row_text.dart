import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class RowText extends StatelessWidget {
  final String content;
  final String subContent;
  final Color color;
  RowText({
    required this.content,
    this.subContent = '',
    this.color = appStyles.currentAppThemeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: content,
          style: TextStyle(fontSize: appStyles.BODY_TEXT, color: color),
        ),
        TextSpan(text: ' '),
        TextSpan(
          text: subContent,
          style: TextStyle(fontSize: appStyles.BODY_TEXT, color: color),
        ),
      ]),
    );
  }
}
