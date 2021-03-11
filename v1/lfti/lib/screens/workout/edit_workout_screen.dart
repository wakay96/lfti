import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/providers/edit_workout_screen_provider.dart';
import 'package:lfti/shared/content/edit_exercise_content.dart';
import 'package:lfti/shared/content/edit_rest_content.dart';
import 'package:provider/provider.dart';

import '../../helpers/app_styles.dart';

class EditWorkoutScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditWorkoutScreenProvider>(
      create: (BuildContext context) => EditWorkoutScreenProvider(),
      child: EditWorkoutScreen(),
    );
  }
}

class EditWorkoutScreen extends StatefulWidget {
  static const String id = 'EditWorkoutScreen';
  final String appBarTitle = "edit workout";
  @override
  _EditWorkoutScreenState createState() => _EditWorkoutScreenState();
}

class _EditWorkoutScreenState extends State<EditWorkoutScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final Map data = ModalRoute.of(context).settings.arguments;
      final viewModel =
          Provider.of<EditWorkoutScreenProvider>(context, listen: false);
      viewModel.initializeData(data['id']);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditWorkoutScreenProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            widget.appBarTitle,
            style: largeTextStyle.copyWith(fontWeight: FontWeight.w900),
          ),
          actions: [
            IconButton(
                iconSize: 25,
                padding: primaryContainerPadding,
                tooltip: 'Save',
                color: secondaryColor,
                icon: Icon(FontAwesomeIcons.save),
                onPressed: () {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  viewModel.onSubmit();
                  Navigator.pop(context);
                })
          ],
        ),
        backgroundColor: primaryColor,
        body: viewModel.workout != null
            ? Theme(
                data: ThemeData(canvasColor: Colors.transparent),
                child: ReorderableListView.builder(
                  onReorder: viewModel.onReorder,
                  itemCount: viewModel.workout.activities.length,
                  header: Card(
                    margin: cardHorizontalSpacing,
                    color: inactiveCardColor,
                    shape: RoundedRectangleBorder(borderRadius: borderRadius),
                    child: Padding(
                      padding: cardPadding.copyWith(right: 50),
                      child: Column(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                                onChanged: (update) =>
                                    viewModel.onUpdateName(update),
                                minLines: 1,
                                maxLines: 3,
                                cursorColor: tertiaryColor,
                                controller: viewModel.nameTextController,
                                style: workoutMediumTextStyle),
                            SizedBox(height: 10.0),
                            Text('Description', style: labelSmallTextStyle),
                            TextField(
                                onChanged: (update) =>
                                    viewModel.onUpdateDescription(update),
                                minLines: 1,
                                maxLines: 3,
                                cursorColor: tertiaryColor,
                                controller: viewModel.descriptionTextController,
                                style: workoutMediumTextStyle),
                          ],
                        ),
                        SizedBox(height: 15.0),
                      ]),
                    ),
                  ),
                  itemBuilder: (context, index) {
                    var activity = viewModel.workout.activities[index];
                    return Dismissible(
                      key: ValueKey(activity.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                          alignment: Alignment.centerRight,
                          color: dangerColor,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Icon(Icons.delete,
                                color: currentAppThemeTextColor),
                          )),
                      onDismissed: (direction) {
                        viewModel.deleteActivity(activity.id);
                        ScaffoldMessenger.of(context)
                          ..showSnackBar(
                            SnackBar(
                              backgroundColor: primaryColor,
                              content: Text(
                                  'Successfully Deleted "${activity.name}"',
                                  style: mediumTextStyle),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () =>
                                    viewModel.undoDelete(index, activity),
                              ),
                            ),
                          );
                      },
                      child: EditActivityTile(
                        activity,
                        (update) => viewModel.onUpdateActivity(update),
                        color: inactiveCardColor,
                      ),
                    );
                  },
                ),
              )
            : Container());
  }
}

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
      padding: EdgeInsets.all(8.0),
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
                              isTargetEditable: false,
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
