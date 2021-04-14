import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/providers/activity/exercise_screen_provider.dart';
import 'package:provider/provider.dart';

class ExerciseScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExerciseScreenProvider(),
      child: ExerciseScreen(),
    );
  }
}

class ExerciseScreen extends StatefulWidget {
  static const String id = 'SelectActivityScreen';
  static const String title = 'Exercises';
  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      final ExerciseScreenProvider model =
          Provider.of<ExerciseScreenProvider>(context, listen: false);
      model.initialize(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ExerciseScreenProvider model =
        Provider.of<ExerciseScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(ExerciseScreen.title),
      ),
      body: CustomScrollView(
        slivers: [
          ExerciseList(
            activities: model.chestExercises.activities,
            headerText: model.chestExercises.name,
          ),
          ExerciseList(
            activities: model.legExercises.activities,
            headerText: model.legExercises.name,
          ),
          ExerciseList(
            activities: model.shoulderExercises.activities,
            headerText: model.shoulderExercises.name,
          ),
          ExerciseList(
            activities: model.backExercises.activities,
            headerText: model.backExercises.name,
          ),
          ExerciseList(
            activities: model.coreExercises.activities,
            headerText: model.coreExercises.name,
          ),
          ExerciseList(
            activities: model.customExercises.activities,
            headerText: model.customExercises.name,
          ),
          ExerciseList(
            activities: model.armExercises.activities,
            headerText: model.armExercises.name,
          ),
        ],
      ),
    );
  }
}

class ExerciseList extends StatelessWidget {
  const ExerciseList({
    required this.activities,
    required this.headerText,
  });

  final List<Activity> activities;
  final String headerText;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 0)
            return Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide()),
              ),
              child: ListTile(
                title: Text(
                  headerText,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  icon: Icon(FontAwesomeIcons.angleRight),
                  onPressed: () {
                    print('Sort');
                  },
                ),
              ),
            );
          final act = activities[index - 1];
          return Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide()),
            ),
            child: ListTile(
              dense: true,
              title: Text(act.name),
            ),
          );
        },
        childCount: activities.length + 1,
      ),
    );
  }
}
