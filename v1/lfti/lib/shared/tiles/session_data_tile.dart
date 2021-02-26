import 'package:flutter/material.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/shared/tiles/expandable_detail_tile.dart';
import 'package:lfti/shared/text/overflowing_text.dart';

class SessionDataTile extends StatefulWidget {
  SessionDataTile(this.session);

  final Session session;

  @override
  _SessionDataTileState createState() => _SessionDataTileState();
}

class _SessionDataTileState extends State<SessionDataTile> {
  bool isExpanded = false;

  void toggleCollapseExpand() => setState(() => isExpanded = !isExpanded);

  @override
  Widget build(BuildContext context) {
    Session session = widget.session;
    return ExpandableDetailTile(
      isExpanded: isExpanded,
      onTap: toggleCollapseExpand,
      label: 'Previous Session',
      icon: AppIcon.workoutIcon,
      collapsedContent:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        OverflowingText(
          text: session.workout.name,
          style: workoutMediumTextStyle,
        ),
        Text(
          arrayToString(session.workout.targetBodyParts),
          style: TextStyle(
            color: currentAppThemeTextColor,
            fontSize: SMALL_TEXT,
          ),
        ),
      ]),
      expandedContent:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 10.0),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Date Performed', style: labelSmallTextStyle),
            Text(
              session.datePerformed.fullDate,
              style: workoutMediumTextStyle,
            ),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Time', style: labelSmallTextStyle),
              Text('${session.duration.inMinutes}',
                  style: workoutMediumTextStyle),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Performed', style: labelSmallTextStyle),
                    Text('${session.performedExercises.length}',
                        style: workoutMediumTextStyle)
                  ],
                ),
                SizedBox(width: 15.0),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Skipped', style: labelSmallTextStyle),
                  Text('${session.skippedExercises.length}',
                      style: workoutMediumTextStyle)
                ]),
                Spacer(flex: 1),
                RaisedButton(
                  color: inactiveCardColor,
                  onPressed: () => print('pressed me'),
                  child: Text('View Workout',
                      style: buttonTextStyle.copyWith(
                        color: workoutThemeColor,
                      )),
                )
              ]),
        ]),
      ]),
    );
  }

  String arrayToString(List<dynamic> list) {
    String formattedString = '';
    list.forEach((element) {
      formattedString += (element.toString() + ', ');
    });
    // remove last comma
    return formattedString.substring(0, formattedString.length - 2);
  }
}
