import 'package:flutter/material.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/helpers/string_formatter.dart';
import 'package:lfti/providers/workout_screen_provider.dart';
import 'package:lfti/shared/buttons/button.dart';
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
  static const String id = "WorkoutScreen";
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    WorkoutScreenProvider viewModel =
        Provider.of<WorkoutScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        shadowColor: Colors.transparent,
        title: Container(
          alignment: Alignment.bottomRight,
          child: Text(
            WORKOUT_SCREEN_APPBAR_TEXT,
            style: appBarTitleTextStyleLight,
          ),
        ),
        centerTitle: false,
      ),
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: viewModel.workouts.length,
          itemBuilder: (context, index) {
            return WorkoutContent(viewModel.workouts[index]);
          },
        ),
      ),
    );
  }
}

class WorkoutContent extends StatelessWidget {
  final Workout workout;
  WorkoutContent(this.workout);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: inactiveCardColor,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: Padding(
        padding: cardPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OverflowingText(
                  text: '${workout.name}',
                  style: mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
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
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Exercises', style: smallTextStyle),
                      Column(
                        children: getExerciseWidgets(workout.activities),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Button('edit', () {
                        print('${workout.name} edit was pressed');
                      }),
                      Button('start', () {
                        print('${workout.name} start was pressed');
                      })
                    ],
                  )
                ]),
          ],
        ),
      ),
    );
  }

  List<Widget> getExerciseWidgets(List<Activity> activities) {
    var list = <Widget>[];
    activities.forEach((item) {
      if (item is Exercise) {
        list.add(Text(
          item.name,
          style: smallTextStyle.copyWith(fontWeight: FontWeight.bold),
        ));
      }
    });
    return list;
  }
}
