import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/providers/session/new_session_screen_provider.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile(
      {Key? key,
      required this.act,
      required this.model,
      required this.isSelected,
      required this.index})
      : super(key: key);

  final Activity act;
  final NewSessionScreenProvider model;
  final bool isSelected;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(act.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => model.deleteActivity(act),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide()),
        ),
        child: ListTile(
            title: Text(act.name),
            leading: act is Exercise ? AppIcon.inactiveWorkout : AppIcon.rest,
            trailing: ReorderableDragStartListener(
              index: index,
              child: Icon(FontAwesomeIcons.gripLines),
            ),
            tileColor: model.editMode
                ? Theme.of(context).cardColor
                : Theme.of(context).canvasColor,
            onTap: () {
              isSelected
                  ? model.resetSelectedActivity()
                  : model.setSelectedActivity(act.id);
            }),
      ),
      background: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            color: dangerColor,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(10.0),
          child: AppIcon.trash),
    );
  }
}
