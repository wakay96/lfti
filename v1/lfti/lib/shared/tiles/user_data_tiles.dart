import 'package:flutter/material.dart';
import 'package:lfti/shared/text/row_text.dart';
import 'package:lfti/shared/tiles/button_tile.dart';

class UserDataTiles extends StatelessWidget {
  const UserDataTiles(
      {@required this.isActive,
      @required this.unit,
      @required this.color,
      @required this.onTap,
      @required this.contents,
      @required this.labels,
      this.icons});

  final bool isActive;
  final String unit;
  final Color color;
  final Function onTap;
  final List<String> contents;
  final List<String> labels;
  final List<Widget> icons;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ButtonTile(
              isActive: isActive,
              onTap: onTap,
              label: labels[0] == null ? '' : labels[0],
              content: RowText(
                content: contents[0] == null ? '-' : contents[0],
                subContent: unit,
                color: color,
              ),
            ),
          ),
          Expanded(
            child: ButtonTile(
              isActive: isActive,
              onTap: onTap,
              icon: icons == null ? null : icons[0],
              label: labels[1] == null ? '' : labels[1],
              content: RowText(
                content: contents[1] == null ? '-' : contents[1],
                subContent: unit,
                color: color,
              ),
            ),
          ),
        ]);
  }
}
