import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/activity_list_data.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/id_generator.dart';

class AddActivityScreenProvider extends ChangeNotifier {
  late final IRepository repo;
  List<ActivityListData> data = [];
  Set<String> selectedExercises = Set();
  bool error = false;

  void initialize(BuildContext context) {
    repo = GetIt.instance<IRepository>();
    final targets = [
      Target.Chest,
      Target.Leg,
      Target.Shoulder,
      Target.Back,
      Target.Arm,
      Target.Core,
      Target.Custom
    ];
    targets.forEach((target) {
      final list = repo.getExercisesByTarget(target);
      data.add(ActivityListData(target, list));
    });
    notifyListeners();
  }

  List<Activity> generateSelectedActivities() {
    List<Activity> all = [
      ...data[0].activities,
      ...data[1].activities,
      ...data[2].activities,
      ...data[3].activities,
      ...data[4].activities,
      ...data[5].activities,
      ...data[6].activities,
    ];
    List<Activity> activities = [];
    selectedExercises.forEach((id) {
      final Activity? act = all.firstWhere((element) => element.id == id);
      if (act == null) {
        error = true;
        notifyListeners();
        return;
      }
      activities.add(
        Activity(
            id: IdGenerator.generateV4(),
            name: act.name,
            description: act.description),
      );
    });
    return activities;
  }

  void toggleActivity(String id) {
    if (isSelected(id)) {
      selectedExercises.remove(id);
    } else {
      selectedExercises.add(id);
    }
    notifyListeners();
  }

  bool isSelected(String id) {
    return selectedExercises.contains(id);
  }
}
