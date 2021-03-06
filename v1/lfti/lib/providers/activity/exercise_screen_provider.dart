import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/activity_list_data.dart';
import 'package:lfti/data/models/rest.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/id_generator.dart';

class ExerciseScreenProvider extends ChangeNotifier {
  late final IRepository repo;
  List<ActivityListData> data = [];
  Set<String> selectedExercises = Set();
  bool editMode = false;

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

  // TODO: Implement
  void editActivity() {
    print('Need to implement');
  }

  // TODO Implement
  void deleteActivity() {
    print('Need to implement');
  }

  //TODO: implement
  void addActivity(Map<String, dynamic> data) {}

  // {  name: String,
  //    description: String,
  //    target: String,
  //    duration: int,
  //    type: String  }
  Activity? _createActivity(Map<String, dynamic> data) {
    String id = IdGenerator.generateV4();
    String type = data['type'] as String;

    if (type == 'Exercise') {
      String name = data['name'] as String;
      String description = data['description'] as String;
      String target = data['target'] as String;
      return Exercise(
          id: id, name: name, description: description, target: target);
    }
    if (type == 'Rest') {
      Duration duration = Duration(seconds: data['duration']);
      return Rest(id, duration);
    }
    return null;
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
