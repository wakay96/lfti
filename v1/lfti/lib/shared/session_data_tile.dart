import 'package:flutter/material.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/shared/detail_expandable_tile.dart';
import 'package:lfti/shared/overflowing_text.dart';

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
    return DetailExpandableTile(
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
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DATE PERFORMED', style: whiteLabelText),
                  Text(
                    session.datePerformed.fullDate,
                    style: workoutMediumTextStyle,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TOTAL TIME', style: whiteLabelText),
                  Text('${session.duration.inMinutes}',
                      style: workoutMediumTextStyle),
                ],
              ),
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PERFORMED', style: whiteLabelText),
                    Text('10', style: workoutMediumTextStyle)
                  ],
                ),
                SizedBox(width: 15.0),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('SKIPPED', style: whiteLabelText),
                  Text('5', style: workoutMediumTextStyle)
                ]),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
