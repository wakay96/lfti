import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart';

class OverflowingText extends StatelessWidget {
  OverflowingText({required this.text, this.style = smallTextStyle});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .65,
      child: Text(
        text,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );
  }
}
