import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/helpers/app_strings.dart';

class NewSessionScreenProvider extends ChangeNotifier {
  late Map<String, dynamic> args;
  late String id;
  late IRepository repo;
  List<Activity> activities = [];
  List<bool> scheduleSelection = [];
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

  void updateName(String val) {
    name = val;
    notifyListeners();
  }

  void updateDescription(String val) {
    description = val;
    notifyListeners();
  }

  void deleteActivity(Activity activity) {
    int index = activities.indexOf(activity);
    activities.removeAt(index);
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
    }
    return sched;
  }
}
