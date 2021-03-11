import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/rest.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/helpers/string_formatter.dart';
import 'package:lfti/providers/workout_screen_provider.dart';
import 'package:lfti/screens/workout/edit_workout_screen.dart';
import 'package:lfti/shared/text/overflowing_text.dart';
import 'package:provider/provider.dart';

class WorkoutScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WorkoutScreenProvider>(
      create: (BuildContext context) => WorkoutScreenProvider(),
      child: WorkoutScreen(),
    );
  }
}

class WorkoutScreen extends StatefulWidget {
  static const String id = 'WorkoutScreen';
  final String appBarTitle = "workouts";
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      WorkoutScreenProvider viewModel =
          Provider.of<WorkoutScreenProvider>(context, listen: false);
      viewModel.initializeData();
    });
    super.initState();
  }

  void onEditWorkout(BuildContext context, String workoutId) async {
    await Navigator.pushNamed(context, EditWorkoutScreen.id,
        arguments: {'id': workoutId});
    WorkoutScreenProvider viewModel =
        Provider.of<WorkoutScreenProvider>(context, listen: false);
    viewModel.initializeData();
  }

  @override
  Widget build(BuildContext context) {
    WorkoutScreenProvider viewModel =
        Provider.of<WorkoutScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              iconSize: 20,
              padding: primaryContainerPadding,
              tooltip: 'Add Workout',
              color: secondaryColor,
              icon: Icon(FontAwesomeIcons.plus),
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                Navigator.pop(context);
              })
        ],
        backgroundColor: primaryColor,
        shadowColor: Colors.transparent,
        title: Text(
          widget.appBarTitle,
          style: largeTextStyle.copyWith(fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: viewModel.workouts
              .map((item) => WorkoutContent(item, onEditWorkout))
              .toList(),
        ),
      ),
    );
  }
}

class WorkoutContent extends StatelessWidget {
  final Workout workout;
  final Function onEditWorkout;
  WorkoutContent(this.workout, this.onEditWorkout);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: inactiveCardColor,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: Container(
        padding: cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OverflowingText(
                        text: '${workout.name}',
                        style: largeTextStyle.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.edit),
                      onPressed: () => onEditWorkout(context, workout.id),
                      color: secondaryColor,
                    ),
                  ],
                ),
                Text(
                  '${workout.description}',
                  style: smallTextStyle,
                ),
                Text(
                  '${ListToString(workout.targetBodyParts).parse()}',
                  style: smallTextStyle,
                ),
              ],
            ),
            Divider(),
            Table(
              columnWidths: {0: FractionColumnWidth(0.5)},
              children: [
                TableRow(children: [
                  Text(
                    'Name',
                    style: smallTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Sets',
                    style: smallTextStyle.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Reps',
                    style: smallTextStyle.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ]),
                ...workout.activities.map((item) => buildRow(item))
              ],
            )
          ],
        ),
      ),
    );
  }
}

TableRow buildRow(Activity act) {
  if (act is Exercise) {
    return TableRow(children: [
      Text(
        act.name,
        style: smallTextStyle,
      ),
      Text(
        '${act.setCount}',
        style: smallTextStyle,
        textAlign: TextAlign.center,
      ),
      Text(
        '${act.repCount}',
        style: smallTextStyle,
        textAlign: TextAlign.center,
      ),
    ]);
  } else {
    var rest = act as Rest;
    return TableRow(children: [
      Text(
        rest.name,
        style: smallTextStyle.copyWith(color: tertiaryColor),
      ),
      Container(),
      Container(),
    ]);
  }
}
