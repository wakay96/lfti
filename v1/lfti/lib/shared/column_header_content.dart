import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class ColumnHeaderContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CHEST & BACK',
          style: appStyles.whiteBmLText,
        ),
        Text(
          'SUPERSET',
          style: appStyles.whiteNMText,
        ),
        Text(
          'chest',
          style: appStyles.whiteIMText,
        ),
      ],
    );
  }
}
