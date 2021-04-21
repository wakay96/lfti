import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart';

class DismissibleTile extends StatelessWidget {
  DismissibleTile({
    required this.key,
    required this.child,
    required this.onDismiss,
  }) : super(key: key);

  final Key key;
  final Widget child;
  final Function onDismiss;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(key),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      child: child,
      background: Container(
        decoration: BoxDecoration(color: dangerColor),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(10.0),
        child: AppIcon.trash,
      ),
    );
  }
}
