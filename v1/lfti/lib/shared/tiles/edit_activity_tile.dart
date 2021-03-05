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

  EditActivityTile(this.activity, {this.color});
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
    return Padding(
      padding: primaryContainerSidePadding,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Card(
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
                                isTargetEditable: false,
                              )
                            : EditRestContent(activity)
                      ],
                    ),
                  ),
                  getIcon(activity)
                ],
              )),
        ),
      ),
    );
  }
}
