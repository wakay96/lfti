import 'package:flutter/material.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/shared/content/edit_exercise_content.dart';
import 'package:lfti/shared/content/edit_rest_content.dart';

class PreviewActivityTile extends StatelessWidget {
  final Activity activity;
  final Color color;
  final bool skipped;

  PreviewActivityTile(this.activity, {this.color, this.skipped});

  Widget getIcon(Activity activity, bool skipped) {
    Widget icon;
    if (activity is Exercise) {
      icon = skipped ? AppIcon.skippedWorkout : AppIcon.activeWorkout;
    } else {
      icon = AppIcon.rest;
    }
    return Container(
      padding: EdgeInsets.all(10.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        ? EditExerciseContent(
                            activity,
                            isNameEditable: false,
                            isRepsEditable: false,
                            isSetsEditable: false,
                            isTargetEditable: false,
                          )
                        : EditRestContent(
                            activity,
                            isEditable: false,
                          )
                  ],
                ),
              ),
              getIcon(activity, skipped)
            ],
          )),
    );
  }
}
