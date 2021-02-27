import 'package:flutter/material.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/shared/tiles/activity_preview_tile.dart';

class WorkoutHistoryScreen extends StatefulWidget {
  static const String id = 'WorkoutHistoryScreen';

  @override
  _WorkoutHistoryScreenState createState() => _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    Workout _workout = data['workout'] as Workout;
    List<Exercise> _skippedExercises = data['skipped'] as List;
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
      body: ListView.builder(
        itemCount: _workout.activities.length,
        itemBuilder: (context, index) {
          var activity = _workout.activities[index];
          return Container(
            key: Key(index.toString()),
            child: ActivityPreviewTile(
              activity,
              color: inactiveCardColor,
              skipped: _skippedExercises.contains(activity),
            ),
          );
        },
      ),
    );
  }
}
