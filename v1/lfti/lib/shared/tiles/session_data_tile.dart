import 'package:flutter/material.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/shared/tiles/expandable_detail_tile.dart';
import 'package:lfti/shared/text/overflowing_text.dart';

class SessionDataTile extends StatelessWidget {
  SessionDataTile({
    this.session,
    this.isExpanded,
    this.onTap,
  });

  final bool isExpanded;
  final Function onTap;
  final Session session;

  String getFormattedArrayEnumValues(List<dynamic> list) {
    String formattedString = '';
    list.forEach((element) {
      formattedString += (element.toString() + ', ');
    });
    // remove last comma
    return formattedString.substring(0, formattedString.length - 2);
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableDetailTile(
      isExpanded: isExpanded,
      onTap: onTap,
      label: 'Previous Session',
      icon: AppIcon.workoutIcon,
      collapsedContent:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        OverflowingText(
          text: session.workout.name,
          style: workoutMediumTextStyle,
        ),
        Text(
          getFormattedArrayEnumValues(session.workout.targetBodyParts),
          style: TextStyle(
            color: currentAppThemeTextColor,
            fontSize: SMALL_TEXT,
          ),
        ),
      ]),
      expandedContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('DATE PERFORMED', style: labelMediumTextStyle),
                Text(
                  session.datePerformed.fullDate,
                  style: workoutMediumTextStyle,
                ),
              ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TOTAL TIME', style: labelMediumTextStyle),
                  Text('${session.duration.inMinutes}',
                      style: workoutMediumTextStyle),
                ],
              ),
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PERFORMED', style: labelMediumTextStyle),
                    Text('${session.performedExercises.length}',
                        style: workoutMediumTextStyle)
                  ],
                ),
                SizedBox(width: 15.0),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('SKIPPED', style: labelMediumTextStyle),
                  Text('${session.skippedExercises.length}',
                      style: workoutMediumTextStyle)
                ]),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
