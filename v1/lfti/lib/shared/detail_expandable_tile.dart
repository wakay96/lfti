import 'package:flutter/material.dart';
import 'package:lfti/shared/tile_button.dart';

class DetailExpandableTile extends StatelessWidget {
  final String label;
  final Widget expandedContent;
  final Function onTap;
  final bool isExpanded;
  final Widget collapsedContent;
  final Widget icon;

  DetailExpandableTile({
    this.label = '',
    this.icon,
    this.onTap,
    this.isExpanded = false,
    @required this.collapsedContent,
    @required this.expandedContent,
  });

  @override
  Widget build(BuildContext context) {
    return TileButton(
      onTap: onTap,
      label: label,
      icon: icon,
      content: isExpanded ? expandedContent : collapsedContent,
    );
  }
}
