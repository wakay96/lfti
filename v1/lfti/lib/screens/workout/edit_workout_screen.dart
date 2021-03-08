import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/providers/edit_workout_screen_provider.dart';
import 'package:lfti/screens/workout/workout_screen.dart';
import 'package:lfti/shared/tiles/edit_activity_tile.dart';
import 'package:provider/provider.dart';

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
      viewModel.initializeData(data['workout'].id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditWorkoutScreenProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Container(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                viewModel.onSubmit();
                Navigator.pushNamed(context, WorkoutScreen.id);
              },
              child: Text(
                'save changes',
                style: appBarTitleTextStyleLight,
              ),
            ),
          ),
          centerTitle: false,
        ),
        backgroundColor: primaryColor,
        body: viewModel.workout != null
            ? Theme(
                data: ThemeData(canvasColor: Colors.transparent),
                child: Padding(
                  padding: primaryContainerSidePadding,
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
                              Text('Name', style: labelSmallTextStyle),
                              TextField(
                                  onChanged: (update) =>
                                      viewModel.onUpdateName(update),
                                  minLines: 1,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: viewModel.nameTextController.text,
                                    hintStyle: labelMediumTextStyle,
                                    alignLabelWithHint: true,
                                    fillColor: Colors.grey,
                                  ),
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
                                  decoration: InputDecoration(
                                    hintText: viewModel
                                        .descriptionTextController.text,
                                    hintStyle: labelMediumTextStyle,
                                    alignLabelWithHint: true,
                                    fillColor: Colors.grey,
                                  ),
                                  cursorColor: tertiaryColor,
                                  controller:
                                      viewModel.descriptionTextController,
                                  style: workoutMediumTextStyle),
                            ],
                          ),
                          SizedBox(height: 15.0),
                        ]),
                      ),
                    ),
                    itemBuilder: (context, index) {
                      var activity = viewModel.workout.activities[index];
                      return Container(
                        key: Key(index.toString()),
                        child: EditActivityTile(
                          activity,
                          (update) => viewModel.onUpdateActivity(update),
                          color: inactiveCardColor,
                        ),
                      );
                    },
                  ),
                ),
              )
            : Container());
  }
}
