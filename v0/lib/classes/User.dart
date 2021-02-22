import "dart:core";

// firebase imports
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

// class imports
import "package:lfti_app/classes/Routine.dart";
import 'package:lfti_app/classes/TimedRoutine.dart';
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/Session.dart";
import "package:lfti_app/classes/Exercise.dart";

class User {
  // user credentials
  AuthResult _authRes;
  String _uid;
  DocumentReference _firestoreReference;
  DocumentSnapshot _document;

  /// user data
  List<Workout> _workouts;
  List _checklist;
  String _firstName;
  String _lastName;
  String _email;
  Session _currentSession;
  Map _lastSession;
  String _gymMembership;

  void initUserData() {
    try {
      this._uid = _authRes.user.uid;
      this._workouts = _buildWorkoutList();
      this._firstName = getDocument().data["firstName"];
      this._lastName = getDocument().data["lastName"];
      this._email = getDocument().data["email"];
      this._lastSession = getDocument().data["lastSession"];
      this._checklist = getDocument().data["checklist"];
      this._gymMembership = getDocument().data["gymMembership"];
      print("Success: User Initialized!");
    } catch (e) {
      print("Error: Failed to initialize user! " + e.toString());
    }
  }

  /// setters
  void setFirstName(String s) => this._firstName = s;

  void setLastName(String s) => this._lastName = s;

  void setEmail(String s) => this._email = s;

  void setAuthResult(var res) => this._authRes = res;

  void setGymMembership(String s) => this._gymMembership = s;

  void setDatabaseReference(DocumentReference ref) =>
      this._firestoreReference = ref;

  void setDocumentSnapshot(DocumentSnapshot ds) async => this._document = ds;

  void setLastSession(Map data) => this._lastSession = data;

  void setSession(Session s) {
    if (s != null)
      this._currentSession = s;
    else
      print("Setting an empty Session!");
  }

  void setChecklist(List<String> l) {
    this._checklist = l;
  }

  void setWorkoutList(List<Workout> l) {
    this._workouts = l;
  }

  void setWorkoutAt(int index, Workout w) {
    this._workouts[index] = w;
  }

  bool isLoggedIn() => getDocument() != null && getAuth() != null;

  void addWorkout(Workout w) => this._workouts.add(w);

  void deleteRoutineAt(int workoutIndex, int routineIndex) =>
      _workouts[workoutIndex].deleteRoutine(routineIndex);

  void deleteWorkoutAt(int index) => this._workouts.removeAt(index);

  void addChecklistItem(String s) => this._checklist.add(s);

  void setChecklistItemAt(int index, String s) => this._checklist[index] = s;

  /// getters
  AuthResult getAuth() => this._authRes;

  String getUID() => this._uid;

  DocumentReference getFirestoreReference() => this._firestoreReference;

  DocumentSnapshot getDocument() => this._document;

  String getFirstName() => this._firstName;

  String getLastName() => this._lastName;

  String getEmail() => this._email;

  String getGymMembership() => this._gymMembership;

  Map getLastSession() => this._lastSession == null
      ? getDocument().data["lastSession"]
      : this._lastSession;

  Map getNextSession() => this._lastSession != null
      ? getDocument().data["nextSession"]
      : this._lastSession;

  List getChecklist() => this._checklist == null
      ? getDocument().data["checklist"]
      : this._checklist;

  List<Workout> getWorkoutList() => this._workouts;

  Workout getWorkoutAt(int index) => this._workouts[index];

  Session getSession() => this._currentSession;

  Workout getLastWorkout() => getWorkoutAt(this._workouts.length - 1);

  /// helper methods
  List<Workout> _buildWorkoutList() {
    try {
      List<Workout> w = List<Workout>();
      List list = getDocument().data["workouts"];
      for (var item in list) {
        w.add(_buildWorkout(item));
      }
      print("Success: Workout List set!");
      return w;
    } catch (e) {
      print("Error: Unable to Build workout list! " + e.toString());
      return e;
    }
  }

  Workout _buildWorkout(Map w) {
    try {
      return Workout(
        id: w["id"],
        name: w["name"],
        description: w["description"],
        routines: _buildRoutineList(w["routines"]),
      );
    } catch (e) {
      print("Error: Failed to build workout " + e.toString());
      return e;
    }
  }

  List<Routine> _buildRoutineList(List list) {
    var routines = List<Routine>();
    for (var r in list) {
      if (r["type"] == "COUNTED") {
        routines.add(Routine(
          exercise: Exercise(
              name: r["exercise"]["name"], focus: r["exercise"]["focus"]),
          reps: r["reps"],
          sets: r["sets"],
          weight: r["weight"],
        ));
      } else {
        routines.add(TimedRoutine(
          timeToPerformInSeconds: r["timeToPerformInSeconds"],
          exercise: Exercise(name: "Rest", focus: "--"),
        ));
      }
    }
    return routines;
  }
}
