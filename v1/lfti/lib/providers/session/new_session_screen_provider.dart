import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/data/models/rest.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/helpers/app_strings.dart';

class NewSessionScreenProvider extends ChangeNotifier {
  late Map<String, dynamic> args;
  late String id;
  late IRepository repo;
  List<Activity> activities = [];
  List<bool> scheduleSelection = [];
  Activity? selectedActivity;
  String? name;
  String? description;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool editMode = false;

  /// TODO: Create class to hold error detail
  bool error = false;

  void initialize(BuildContext context) {
    repo = GetIt.instance<IRepository>();
    args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  }

  void addActivity(int index, Activity newActivity) {
    print(newActivity.name);
    if (index < 0) {
      activities.insert(0, newActivity);
    }

    if (index >= activities.length) {
      activities.add(newActivity);
    }

    if (index < activities.length) {
      activities.insert(index, newActivity);
    }

    notifyListeners();
  }

  void updateName(String val) {
    name = val;
    notifyListeners();
  }

  void updateDescription(String val) {
    description = val;
    notifyListeners();
  }

  void updateExercise(int index, Map<String, String> data) {
    try {
      final Exercise act = activities[index] as Exercise;
      act.setCount = int.parse(data['setCount']!);
      act.repCount = int.parse(data['repCount']!);
      act.target = act.target;
    } catch (e) {
      error = true;
    }
    notifyListeners();
  }

  void updateRest(int index, String seconds) {
    try {
      final Rest act = activities[index] as Rest;
      act.duration = Duration(seconds: int.parse(seconds));
      activities[index] = act;
    } catch (e) {
      error = true;
    }
    notifyListeners();
  }

  void deleteActivity(Activity activity) {
    try {
      int index = activities.indexOf(activity);
      activities.removeAt(index);
    } catch (e) {
      error = true;
    }
    notifyListeners();
  }

  void toggleDay(int index) {
    scheduleSelection[index] = !scheduleSelection[index];
    notifyListeners();
  }

  void toggleEditMode() {
    editMode = !editMode;
    notifyListeners();
  }

  void setSelectedActivity(String id) {
    try {
      selectedActivity = activities.firstWhere((element) => element.id == id);
      notifyListeners();
    } catch (e) {
      print(e);
      error = true;
    }
  }

  void resetSelectedActivity() {
    selectedActivity = null;
    notifyListeners();
  }

  bool isActivitySelected(String id) {
    if (selectedActivity == null) return false;
    return selectedActivity!.id == id;
  }

  void save() {
    Session session = createSession();
    repo.addSession(session);
  }

  void onReorderActivities(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    final Activity element = activities.removeAt(oldIndex);
    activities.insert(newIndex, element);
    notifyListeners();
  }

  Session createSession() {
    return Session(
      name: name ?? '',
      description: description,
      schedule: generateSchedule(),
      activities: activities,
    );
  }

  List<String> generateSchedule() {
    int currentIndex = 0;
    final days = [
      WeekdayNames.Sunday,
      WeekdayNames.Monday,
      WeekdayNames.Tuesday,
      WeekdayNames.Wednesday,
      WeekdayNames.Thursday,
      WeekdayNames.Friday,
      WeekdayNames.Saturday
    ];
    List<String> sched = [];
    scheduleSelection.forEach((selected) {
      if (selected) {
        sched.add(days[currentIndex]);
      }
      currentIndex++;
    });
    return sched;
  }

  List<bool> generateScheduleSelection() {
    final days = [
      WeekdayNames.Sunday,
      WeekdayNames.Monday,
      WeekdayNames.Tuesday,
      WeekdayNames.Wednesday,
      WeekdayNames.Thursday,
      WeekdayNames.Friday,
      WeekdayNames.Saturday
    ];

    final List<bool> sched = [false, false, false, false, false, false, false];
    try {
      final session = repo.getSessionById(id);
      session.schedule.forEach((element) {
        int index = days.indexOf(element);
        sched[index] = !sched[index];
      });
    } catch (e) {
      print(e);
      error = true;
    }
    return sched;
  }
}
