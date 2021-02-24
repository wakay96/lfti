import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class RowContent extends StatelessWidget {
  RowContent({
    this.content,
    this.subContent = '',
  });

  final String content;
  final String subContent;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: content,
          style: appStyles.whiteBLText,
        ),
        TextSpan(
          text: ' ',
        ),
        TextSpan(
          text: subContent,
          style: appStyles.whiteNMText,
        ),
      ]),
    );
  }
}
