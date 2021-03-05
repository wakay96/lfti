import 'package:flutter/material.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/providers/edit_workout_screen_provider.dart';
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
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    Workout _workout = data['workout'] as Workout;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        shadowColor: Colors.transparent,
        title: Container(
          alignment: Alignment.bottomRight,
          child: Text(
            widget.appBarTitle,
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
            child: EditActivityTile(
              activity,
              color: inactiveCardColor,
            ),
          );
        },
      ),
    );
  }
}
