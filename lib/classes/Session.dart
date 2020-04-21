import 'package:lfti_app/classes/Exercise.dart';
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/Routine.dart";
import "package:intl/intl.dart";
import "package:lfti_app/classes/Constants.dart";

class Session {
  Workout _workout;
  String id;
  String _elapseTime;
  String date;
  int _currentSet = 0;
  int _currentRoutineIndex = 0;
  int _performedSets = 0;
  bool isPaused = false;
  final _performedRoutines =
      List<Routine>(); // List implemented as a Stack, no Stack class in Dart

  Session(this._workout) {
    this.id = "S" + DateFormat(kFormatDateId).format(DateTime.now());
    this.date = DateFormat(kFormatDateMMddyyyy).format(DateTime.now());
  }

  // getters
  Workout getWorkout() {
    return this._workout;
  }

  List getSkippedRoutines() {
    List skippedRoutines = List();
    getWorkout().routines.forEach((routine) {
      if (!_performedRoutines.contains(routine) && _isNotRestRoutine(routine)) {
        skippedRoutines.add(routine);
      }
    });
    return skippedRoutines;
  }

  List<Routine> getPerformedRoutines() {
    return this._performedRoutines;
  }

  int getSkippedSets() {
    int total = 0;
    for (var item in getWorkout().routines) {
      if (_isNotRestRoutine(item)) total += item.sets;
    }
    return total - this._performedSets;
  }

  int getPerformedSets() {
    return this._performedSets;
  }

  int getCurrentRoutineIndex() {
    return this._currentRoutineIndex;
  }

  dynamic getCurrentRoutine() {
    try {
      return _workout.routines[_currentRoutineIndex];
    } catch (e) {
      print("Accessed invalid Routine index. Returning previus routine" +
          e.toString());
      return _workout.routines[_currentRoutineIndex - 1];
    }
  }

  Routine getNextRoutine() {
    try {
      return _workout.routines[_currentRoutineIndex + 1];
    } catch (e) {
      print("Error: Next routine index invalid " + e.toString());
      return Routine(
          exercise: Exercise(name: "Last Routine"), sets: 0, reps: 0);
    }
  }

  int getCurrentSet() {
    return _currentSet;
  }

  Map<String, String> getElapseTime() {
    RegExp exp = new RegExp(r"\d\d");
    Iterable<RegExpMatch> matches = exp.allMatches(this._elapseTime);
    String hour = matches.elementAt(0).group(0);
    hour = hour[0] == "0" ? hour[1] : hour;
    String min = matches.elementAt(1).group(0);
    min = min[0] == "0" ? min[1] : min;
    String sec = matches.elementAt(2).group(0);
    sec = sec[0] == "0" ? sec[1] : sec;
    return {"hour": hour, "min": min, "sec": sec};
  }

  String getFormattedElapseTime() {
    var time = getElapseTime();
    String hour = time["hour"];
    String min = time["min"];
    String sec = time["sec"];
    return "$hour hrs $min min, $sec sec";
  }

  void togglePause() {
    this.isPaused ? this.isPaused = false : this.isPaused = true;
  }

  void setElapseTime(String t) {
    this._elapseTime = t;
  }

  void next() {
    Routine routine = getCurrentRoutine();
    if (_currentSet < routine.sets) {
      _currentSet++;
    } else {
      nextRoutine();
    }
    if (!this._performedRoutines.contains(routine) &&
        _isNotRestRoutine(routine)) {
      this._performedRoutines.add(routine);
    }
  }

  void previous() {
    if (_currentSet > 0) {
      _currentSet--;
      if (_isNotRestRoutine(getCurrentRoutine()) && _performedSets > 0)
        _performedSets--;
    } else {
      previousRoutine();
    }
  }

  void nextRoutine() {
    if (_isNotRestRoutine(getCurrentRoutine())) {
      this._performedSets += this._currentSet;
    }

    if (!isRoutineListDone()) {
      this._currentRoutineIndex++;
    }

    this._currentSet = 0;
  }

  void previousRoutine() {
    if (_currentRoutineIndex > 0) this._currentRoutineIndex--;
    if (_performedRoutines.isNotEmpty) this._performedRoutines.removeLast();
    this._currentSet = getCurrentRoutine().sets;
  }

  bool isRoutineListDone() {
    return _currentRoutineIndex >= _workout.routines.length - 1;
  }

  bool hasNext() {
    return !isRoutineListDone() || !isRoutineDone();
  }

  bool isRoutineDone() {
    return _currentSet >= getCurrentRoutine().sets;
  }

  bool isFinished() {
    return isRoutineDone() && isRoutineListDone();
  }

  bool isLastRoutine() {
    return _currentRoutineIndex == this._workout.routines.length - 1;
  }

  bool _isNotRestRoutine(Routine r) {
    return r.exercise.name != "Rest";
  }

  void printValues() {
    print("Current set = " + _currentSet.toString());
    print("Performed sets = " + _performedSets.toString());
    print("Skipped sets = " + getSkippedSets().toString() + "\n\n");
  }

  void end(String t) {
    _performedSets += _currentSet;
    setElapseTime(t);
  }
}
