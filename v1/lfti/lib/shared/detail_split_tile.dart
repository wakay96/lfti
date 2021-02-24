import 'package:flutter/material.dart';
import 'package:lfti/shared/tile_button.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class DetailSplitTile extends StatelessWidget {
  DetailSplitTile({
    this.title = '',
    this.label1 = 'CURRENT',
    this.label2 = 'GOAL',
    @required this.content1,
    @required this.content2,
    this.onTap,
    this.isActive = false,
  });

  final String title;
  final String label1;
  final String label2;
  final Widget content1;
  final Widget content2;
  final Function onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title.toUpperCase(),
          style: appStyles.grayLabelText,
        ),
        SizedBox(height: 3.0),
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TileButton(
                isActive: isActive,
                label: label1,
                content: content1,
              ),
              SizedBox(width: 10.0),
              TileButton(
                isActive: isActive,
                label: label2,
                content: content2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
