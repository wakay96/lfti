import 'package:flutter/material.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/rest.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/shared/text/overflowing_text.dart';
import 'package:lfti/shared/text/row_text.dart';

class ActivityPreviewTile extends StatelessWidget {
  final Activity activity;
  final Color color;
  final bool skipped;

  ActivityPreviewTile(this.activity, {this.color, this.skipped});

  Widget getIcon(Activity activity, bool skipped) {
    Widget icon;
    if (activity is Exercise) {
      icon = skipped ? AppIcon.skippedWorkoutIcon : AppIcon.workoutIcon;
    } else {
      icon = AppIcon.restIcon;
    }
    return Container(
      padding: EdgeInsets.all(10.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget icon = getIcon(activity, skipped);
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: Padding(
          padding: cardPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    activity is Exercise
                        ? ExerciseContent(activity)
                        : RestContent(activity)
                  ],
                ),
              ),
              getIcon(activity, skipped)
            ],
          )),
    );
  }
}

class ExerciseContent extends StatelessWidget {
  final Exercise activity;
  final Widget icon;
  ExerciseContent(this.activity, {this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OverflowingText(
          text: '${activity.name}',
          style: exerciseMediumTextStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Sets', style: labelSmallTextStyle),
                  Text('${activity.setCount}', style: exerciseMediumTextStyle),
                ]),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Reps', style: labelSmallTextStyle),
                  Text('${activity.repCount}', style: exerciseMediumTextStyle),
                ]),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Target', style: labelSmallTextStyle),
                  Text('${activity.target}', style: exerciseMediumTextStyle),
                ]),
              ]),
            ),
          ],
        ),
      ],
    );
  }
}

class RestContent extends StatelessWidget {
  final Rest activity;

  RestContent(this.activity);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        OverflowingText(
            text: '${activity.name}',
            style: restMediumTextStyle.copyWith(
              fontWeight: FontWeight.bold,
            )),
        Text('Time', style: labelSmallTextStyle),
        RowText(
          content: '${activity.duration.inSeconds.toString()}',
          subContent: 'sec',
          color: weightThemeColor,
        ),
      ]),
    ]);
  }
}
