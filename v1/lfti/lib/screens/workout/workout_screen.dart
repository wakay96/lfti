import 'package:flutter/material.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/rest.dart';
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
  void onReorder(int prev, int next, WorkoutScreenProvider viewModel) {
    setState(() {
      var temp = viewModel.workouts[prev];
      viewModel.workouts[prev] = viewModel.workouts[next];
      viewModel.workouts[next] = temp;
    });
  }

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
        child: ListView(
          children:
              viewModel.workouts.map((item) => WorkoutContent(item)).toList(),
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
                        style: mediumTextStyle.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Button(
                      'edit',
                      () {
                        print('${workout.name} edit was pressed');
                      },
                      color: Colors.transparent,
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
                    'Rep Count',
                    style: smallTextStyle.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Set Count',
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
        '${act.repCount}',
        style: smallTextStyle,
        textAlign: TextAlign.center,
      ),
      Text(
        '${act.setCount}',
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
      SizedBox(),
      SizedBox(),
    ]);
  }
}
