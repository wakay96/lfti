import 'package:flutter/material.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/helpers/string_formatter.dart';
import 'package:lfti/screens/workout/view_workout_history_screen.dart';
import 'package:lfti/shared/buttons/button.dart';
import 'package:lfti/shared/tiles/expandable_detail_tile.dart';
import 'package:lfti/shared/text/overflowing_text.dart';

class SessionDataTile extends StatefulWidget {
  SessionDataTile(this.session);

  final Session session;

  @override
  _SessionDataTileState createState() => _SessionDataTileState();
}

class _SessionDataTileState extends State<SessionDataTile> {
  @override
  Widget build(BuildContext context) {
    Session session = widget.session;

    return ExpandableDetailTile(
      label: 'Previous Session',
      icon: AppIcon.activeWorkout,
      collapsedContent:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        OverflowingText(
          text: session.workout.name,
          style: workoutMediumTextStyle,
        ),
        Text(
          ListToString(session.workout.targetBodyParts).parse(),
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
              session.date.fullDate,
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
                Button(
                  'View Workout',
                  () {
                    Navigator.pushNamed(context, ViewWorkoutHistoryScreen.id,
                        arguments: {
                          'workout': session.workout,
                          'skipped': session.skippedExercises
                        });
                  },
                  color: Colors.transparent,
                ),
              ]),
        ]),
      ]),
    );
  }
}
