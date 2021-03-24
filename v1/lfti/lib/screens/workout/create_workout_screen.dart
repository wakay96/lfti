import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/providers/workout/create_workout_screen_provider.dart';
import 'package:provider/provider.dart';

class CreateWorkoutScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateWorkoutScreenProvider>(
      create: (context) => CreateWorkoutScreenProvider(),
      child: CreateWorkoutScreen(),
    );
  }
}

class CreateWorkoutScreen extends StatefulWidget {
  static final String id = 'CreateWorkoutScreen';
  static final String title = 'add new workout';

  @override
  _CreateWorkoutScreenState createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      final CreateWorkoutScreenProvider model =
          Provider.of<CreateWorkoutScreenProvider>(context, listen: false);
      model.initialize(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CreateWorkoutScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(CreateWorkoutScreen.title), actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: model.save,
            icon: Icon(FontAwesomeIcons.save),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: dangerColor,
        onPressed: () {
          print('add exercise');
        },
        child: Icon(
          FontAwesomeIcons.plus,
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) =>
            model.onReorderActivities(oldIndex, newIndex),
        header: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(),
            ),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                      controller: model.nameController,
                      decoration: InputDecoration(labelText: 'Name')),
                  TextFormField(
                      controller: model.descriptionController,
                      decoration: InputDecoration(labelText: 'Description')),
                ],
              ),
            ),
          ),
        ),
        children: _getActivityTiles(),
      ),
    );
  }

  List<Widget> _getActivityTiles() {
    final model = Provider.of<CreateWorkoutScreenProvider>(context);
    final List<dynamic> activities = model.activities;
    return activities.map((act) {
      final name = act.name;
      return Container(
        key: UniqueKey(),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: InkWell(
          onTap: () {
            print('Add Exercise');
          },
          child: ListTile(
            title: Text(name),
            leading: act is Exercise ? AppIcon.inactiveWorkout : AppIcon.rest,
            trailing: Icon(FontAwesomeIcons.bars),
          ),
        ),
      );
    }).toList();
  }
}
