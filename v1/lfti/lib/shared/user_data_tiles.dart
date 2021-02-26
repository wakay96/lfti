import 'package:flutter/material.dart';
import 'package:lfti/shared/row_content.dart';
import 'package:lfti/shared/tile_button.dart';

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
            child: TileButton(
              isActive: isActive,
              onTap: onTap,
              label: labels[0],
              content: RowContent(
                content: contents[0],
                subContent: unit,
                color: color,
              ),
            ),
          ),
          Expanded(
            child: TileButton(
              isActive: isActive,
              onTap: onTap,
              icon: icons == null ? null : icons[0],
              label: labels[1],
              content: RowContent(
                content: contents[1],
                subContent: unit,
                color: color,
              ),
            ),
          ),
        ]);
  }
}
