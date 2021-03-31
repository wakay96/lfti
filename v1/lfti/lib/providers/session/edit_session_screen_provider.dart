import 'package:flutter/material.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/id_generator.dart';
import 'package:lfti/providers/screen_provider.dart';

class EditSessionScreenProvider extends ScreenProvider {
  late String id;
  List<Activity> activities = [];
  List<bool> scheduleSelection = [];
  String? name;
  String? description;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool editMode = false;

  @override
  void initialize(BuildContext context) {
    super.initialize(context);
    if (args!['id'] != null) {
      _initializeWithId();
    } else {
      _initializeWithData();
    }

    nameController = TextEditingController(text: name);
    descriptionController = TextEditingController(text: description);

    notifyListeners();
  }

  void _initializeWithId() {
    id = args!['id'];
    final session = repo.getSessionById(id)!;
    name = session.name;
    description = session.description;
    scheduleSelection = _generateScheduleSelection();
    activities = session.activities;
  }

  void _initializeWithData() {
    id = IdGenerator.generateV4();
    Workout workout = args!['data'] as Workout;
    scheduleSelection = [false, false, false, false, false, false, false];
    activities = workout.activities;
    name = workout.name;
    description = workout.description;
  }

  void toggleEditMode() {
    editMode = !editMode;
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

  void deleteActivity(Activity activity) {
    int index = activities.indexOf(activity);
    activities.removeAt(index);
    notifyListeners();
  }

  void toggleDay(int index) {
    scheduleSelection[index] = !scheduleSelection[index];
    notifyListeners();
  }

  void save() {
    Session session = _createSession();
    repo.updateSessionById(id, session);
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    final Activity element = activities.removeAt(oldIndex);
    activities.insert(newIndex, element);
    notifyListeners();
  }

  Session _createSession() {
    return Session(
      id: id,
      name: name ?? '',
      description: description,
      schedule: _generateSchedule(),
      activities: activities,
    );
  }

  List<String> _generateSchedule() {
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

  List<bool> _generateScheduleSelection() {
    final days = [
      WeekdayNames.Sunday,
      WeekdayNames.Monday,
      WeekdayNames.Tuesday,
      WeekdayNames.Wednesday,
      WeekdayNames.Thursday,
      WeekdayNames.Friday,
      WeekdayNames.Saturday
    ];

    List<bool> sched = [false, false, false, false, false, false, false];

    final session = repo.getSessionById(id);
    if (session != null) {
      session.schedule.forEach((element) {
        int index = days.indexOf(element);
        sched[index] = !sched[index];
      });
    }

    return sched;
  }
}
