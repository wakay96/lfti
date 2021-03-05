import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final viewModel =
          Provider.of<EditWorkoutScreenProvider>(context, listen: false);
      final Map data = ModalRoute.of(context).settings.arguments;
      viewModel.initializeData(data['workout'].id);
    });
  }

  @override
  Widget build(BuildContext context) {
    EditWorkoutScreenProvider viewModel =
        Provider.of<EditWorkoutScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
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
        itemCount: viewModel.workout.activities.length,
        itemBuilder: (context, index) {
          var activity = viewModel.workout.activities[index];
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
