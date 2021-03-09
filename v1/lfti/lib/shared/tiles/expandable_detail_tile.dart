import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart';

class ExpandableDetailTile extends StatefulWidget {
  final String label;
  final Widget expandedContent;
  final Widget collapsedContent;
  final Widget icon;

  ExpandableDetailTile({
    this.label = '',
    this.icon,
    @required this.collapsedContent,
    @required this.expandedContent,
  });

  @override
  _ExpandableDetailTileState createState() => _ExpandableDetailTileState();
}

class _ExpandableDetailTileState extends State<ExpandableDetailTile> {
  bool isExpanded = false;

  void toggleCollapseExpand() => setState(() => isExpanded = !isExpanded);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCollapseExpand,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        color: inactiveCardColor,
        child: Padding(
          padding: cardPadding,
          child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.label,
                          style: labelSmallTextStyle,
                          textAlign: TextAlign.start,
                        ),
                        widget.collapsedContent,
                      ]),
                  Container(child: widget.icon),
                ]),
            isExpanded ? widget.expandedContent : Container()
          ]),
        ),
      ),
    );
  }
}
