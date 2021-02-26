import 'package:flutter/material.dart';

class OverflowingText extends StatelessWidget {
  OverflowingText({this.text, this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      child: Text(
        text,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );
  }
}
