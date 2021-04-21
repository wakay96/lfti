import 'package:flutter/material.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/rest.dart';
import 'package:lfti/shared/dismissible_tile.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({
    Key? key,
    required this.act,
    required this.isSelected,
    required this.index,
    this.onTap,
    this.leading,
    this.trailing,
    this.active = false,
    this.onDismiss,
  });

  final Activity act;
  final bool isSelected;
  final int index;
  final Widget? leading;
  final Function? onTap;
  final bool active;
  final Function? onDismiss;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: _getTile(context),
    );
  }

  Widget _getTile(BuildContext context) {
    if (active) {
      final Widget tile = Tooltip(
        message: act.name,
        child: Column(
          children: [
            Visibility(
              visible: !isSelected,
              child: Divider(
                color: Theme.of(context).backgroundColor,
                height: 0,
                indent: 10,
                endIndent: 10,
              ),
            ),
            ListTile(
              title: Text(
                act.name,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: _getActivityDetails(act),
              leading: leading,
              trailing: trailing,
              tileColor: active
                  ? Theme.of(context).cardColor
                  : Theme.of(context).canvasColor,
              onTap: () {
                if (onTap != null) onTap!();
              },
              enabled: onTap != null,
              selected: isSelected,
              selectedTileColor: Theme.of(context).canvasColor,
              dense: true,
            )
          ],
        ),
      );

      if (onDismiss == null) {
        return tile;
      }

      return DismissibleTile(
        key: ValueKey(act.id),
        onDismiss: () => onDismiss!(act),
        child: tile,
      );
    }

    // Inactive Tile
    return Tooltip(
      message: act.name,
      child: ListTile(
        title: Text(
          act.name,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: false,
        subtitle: _getActivityDetails(act),
        leading: leading,
        tileColor: Theme.of(context).canvasColor,
        selected: false,
        dense: true,
      ),
    );
  }

  Widget? _getActivityDetails(Activity act) {
    if (act is Rest) {
      return Text('Duration: ${act.duration.inSeconds} sec');
    }

    if (act is Exercise) {
      if (act.setCount == null || act.setCount == null) return null;
      return Row(
        children: <Widget>[
          Text('Sets: ${act.setCount}'),
          SizedBox(width: 4.0),
          Text('Reps: ${act.repCount}')
        ],
      );
    }

    return null;
  }
}
