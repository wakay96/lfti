import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class DetailExpandableTile extends StatefulWidget {
  final String title;
  final Widget content;

  DetailExpandableTile({
    this.title = '',
    @required this.content,
  });

  @override
  _DetailExpandableTileState createState() => _DetailExpandableTileState();
}

class _DetailExpandableTileState extends State<DetailExpandableTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// title
        Text(
          widget.title.toUpperCase(),
          style: appStyles.grayLabelText,
        ),

        SizedBox(height: 3.0),

        /// Widget content
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: appStyles.inactiveBackgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            border: appStyles.inactiveBorder,
          ),
          child: widget.content,
        ),
      ],
    );
  }
}
