import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/helpers/id_generator.dart';
import 'package:lfti/shared/tiles/button_tile.dart';

class EditWorkoutScreen extends StatefulWidget {
  @override
  _EditWorkoutScreenState createState() => _EditWorkoutScreenState();
}

class _EditWorkoutScreenState extends State<EditWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: ReorderableListView(
        onReorder: (from, to) {
          print('from:$from to:$to');
        },
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Workout name', style: workoutMediumTextStyle),
            Text('Workout name', style: workoutMediumTextStyle),
            Text('Workout name', style: workoutMediumTextStyle),
            Text('Workout name', style: workoutMediumTextStyle),
          ],
        ),
        children: [
          Container(
            color: Colors.transparent,
            height: 75,
            key: Key(IdGenerator.generateV4()),
            child: ButtonTile(
              content: Text('Workout 1', style: workoutMediumTextStyle),
            ),
          ),
          Container(
            height: 75,
            key: Key(IdGenerator.generateV4()),
            child: ButtonTile(
              content: Text('Workout 2', style: workoutMediumTextStyle),
            ),
          ),
          Container(
            height: 75,
            key: Key(IdGenerator.generateV4()),
            child: ButtonTile(
              content: Text('Workout 3', style: workoutMediumTextStyle),
            ),
          ),
        ],
      ),
    );
  }
}
