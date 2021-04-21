import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lfti/data/models/activity_list_data.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/providers/activity/add_activity_screen_provider.dart';
import 'package:lfti/shared/activity_tile.dart';
import 'package:provider/provider.dart';

class AddActivityScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddActivityScreenProvider(),
      child: AddActivityScreen(),
    );
  }
}

class AddActivityScreen extends StatefulWidget {
  static const String id = 'AddActivityScreen';
  static const String title = 'Select Exercises';
  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      final AddActivityScreenProvider model =
          Provider.of<AddActivityScreenProvider>(context, listen: false);
      model.initialize(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AddActivityScreenProvider model =
        Provider.of<AddActivityScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AddActivityScreen.title,
        ),
        actions: [
          IconButton(
              icon: AppIcon.send,
              onPressed: () {
                final selectedActivities = model.generateSelectedActivities();
                print(selectedActivities);
                Navigator.pop(context, selectedActivities);
              }),
        ],
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
                          index: index,
                          active: true,
                          isSelected: model.isSelected(act.id),
                          leading: Checkbox(
                            onChanged: (bool? value) {},
                            value: model.isSelected(act.id),
                          ),
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
