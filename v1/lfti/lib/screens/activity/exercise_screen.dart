import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lfti/data/models/activity_list_data.dart';
import 'package:lfti/providers/activity/exercise_screen_provider.dart';
import 'package:lfti/shared/activity_tile.dart';
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
        title: Text(
          ExerciseScreen.title,
        ),
      ),
      body: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final ActivityListData activityListData = model.data[index];
              return ExpansionTile(
                title: Text(
                  activityListData.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                children: activityListData.activities.map((act) {
                  return Column(
                    children: [
                      Divider(
                        color: Theme.of(context).backgroundColor,
                        height: 0,
                        indent: 10,
                        endIndent: 10,
                      ),
                      ActivityTile(
                          act: act,
                          isSelected: model.isSelected(act.id),
                          index: index,
                          active: model.editMode,
                          onTap: () {
                            model.toggleActivity(act.id);
                          }),
                    ],
                  );
                }).toList(),
                backgroundColor: Theme.of(context).canvasColor,
              );
            },
            childCount: model.data.length,
          ),
        )
      ]),
    );
  }
}
