import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/shared/content/edit_rest_content.dart';
import '../content/edit_exercise_content.dart';

class EditActivityTile extends StatelessWidget {
  final Activity activity;
  final Color color;
  final Function onChanged;

  EditActivityTile(this.activity, this.onChanged, {this.color});

  Widget getIcon(Activity activity) {
    Widget icon;
    if (activity is Exercise) {
      icon = AppIcon.activeWorkout;
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Card(
        margin: cardHorizontalSpacing,
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
                              isTargetEditable: true,
                              onChanged: onChanged,
                            )
                          : EditRestContent(activity)
                    ],
                  ),
                ),
                getIcon(activity)
              ],
            )),
      ),
    );
  }
}
