import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart';

class ExpandableDetailTile extends StatelessWidget {
  final String label;
  final Widget expandedContent;
  final Function onTap;
  final bool isExpanded;
  final Widget collapsedContent;
  final Widget icon;

  ExpandableDetailTile({
    this.label = '',
    this.icon,
    this.onTap,
    this.isExpanded = false,
    @required this.collapsedContent,
    @required this.expandedContent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                          label,
                          style: TextStyle(color: currentAppThemeTextColor),
                          textAlign: TextAlign.start,
                        ),
                        collapsedContent,
                      ]),
                  Container(child: icon),
                ]),
            isExpanded ? expandedContent : Container()
          ]),
        ),
      ),
    );
  }
}
