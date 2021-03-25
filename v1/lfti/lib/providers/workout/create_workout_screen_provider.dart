import 'package:flutter/cupertino.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/providers/screen_provider.dart';

class CreateWorkoutScreenProvider extends ScreenProvider {
  List<Activity> activities = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void initialize(BuildContext context) {
    super.initialize(context);
  }

  void onReorderActivities(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    final Activity element = activities.removeAt(oldIndex);
    activities.insert(newIndex, element);
    notifyListeners();
  }

  void save() {
    print('Saving Changes...');
  }
}
