import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class ColumnHeaderContent extends StatelessWidget {
  final String header;
  final String content1;
  final String content2;

  ColumnHeaderContent({
    @required this.header,
    @required this.content1,
    this.content2 = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          header,
          style: appStyles.whiteBmLText,
        ),
        Text(
          content1,
          style: appStyles.whiteNMText,
        ),
        Text(
          content2,
          style: appStyles.whiteIMText,
        ),
      ],
    );
  }
}
