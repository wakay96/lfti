import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class RowContent extends StatelessWidget {
  RowContent({
    this.content,
    this.subContent,
  });

  final String content;
  final String subContent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Text(
          content,
          style: appStyles.whiteBLText,
        ),
        Text(
          subContent,
          style: appStyles.whiteNMText,
        ),
      ],
    );
  }
}
