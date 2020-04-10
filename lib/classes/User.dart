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
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthResult _authRes;
  DocumentReference _firestoreReference;
  DocumentSnapshot _document;

  /// user data
  List<Workout> _workouts;
  List _checklist;
  String _firstName;
  String _lastName;
  String _email;
  int _age = 29;
  // TODO: set up date formatter or create own class
  Map<String, int> _dob = {"month": 9, "day": 6, "year": 1990};
  Session _currentSession;
  Map _lastSession;
  Map _nextSession;

  void login(String email, String password) async {
    try {
      AuthResult res = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      _setAuthResult(res);
      print("Success: Loggin in as " + _authRes.user.uid);
    } catch (e) {
      print("Error: Unable to Log in! " + e.toString());
    }
  }

  void initUserData() {
    try {
      this._workouts = _buildWorkoutList();
      this._firstName = getDocument().data["firstName"];
      this._lastName = getDocument().data["lastName"];
      this._email = getDocument().data["email"];
      this._age = 29; // TODO: write algo to compute age
      this._dob = {
        "month": getDocument().data["dob"]["month"],
        "day": getDocument().data["dob"]["day"],
        "year": getDocument().data["dob"]["year"]
      };
      this._lastSession = getDocument().data["lastSession"];
      this._nextSession = getDocument().data["nextSession"];
      this._checklist = getDocument().data["checklist"];
      print("Success: User Initialized!");
    } catch (e) {
      print("Error: Failed to initialize user! " + e.toString());
    }
  }

  /// setters
  void _setAuthResult(var res) {
    this._authRes = res;
  }

  void setDatabaseReference() {
    try {
      this._firestoreReference =
          Firestore.instance.collection("users").document(_authRes.user.uid);
      print("Success: Document References set!");
    } catch (e) {
      print("Error: Document Reference not set! " + e.toString());
    }
  }

  void setDocumentSnapshot() async {
    try {
      this._document = await _firestoreReference.get();
      print("Success: Document Snapshot set!");
    } catch (e) {
      print("Error: Document Snapshot not set! " + e.toString());
    }
  }

  void _setDOB() {
    this._dob = {
      "month": getDocument().data["dob"]["month"],
      "day": getDocument().data["dob"]["day"],
      "year": getDocument().data["dob"]["year"]
    };
  }

  void setLastSession(Map data) {
    this._lastSession = data;
  }

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

  bool isLoggedIn() {
    return getDocument() != null && getAuth() != null;
  }

  void addWorkout(Workout w) {
    this._workouts.add(w);
  }

  void deleteRoutineAt(int workoutIndex, int routineIndex) {
    _workouts[workoutIndex].deleteRoutine(routineIndex);
  }

  void deleteWorkoutAt(int index) {
    this._workouts.removeAt(index);
  }

  void addChecklistItem(String s) {
    this._checklist.add(s);
  }

  void setChecklistItemAt(int index, String s) {
    this._checklist[index] = s;
  }

  /// getters
  AuthResult getAuth() {
    return _authRes;
  }

  DocumentReference getFirestoreReference() {
    return _firestoreReference;
  }

  DocumentSnapshot getDocument() {
    return _document;
  }

  String getFirstName() {
    return _firstName;
  }

  String getLastName() {
    return _lastName;
  }

  String getEmail() {
    return _email;
  }

  Map getDOB() {
    return _dob;
  }

  Map getLastSession() {
    return _lastSession == null
        ? getDocument().data["lastSession"]
        : _lastSession;
  }

  Map getNextSession() {
    return _lastSession != null
        ? getDocument().data["nextSession"]
        : _lastSession;
  }

  List getChecklist() {
    return _checklist == null ? getDocument().data["checklist"] : _checklist;
  }

  List<Workout> getWorkoutList() {
    return this._workouts;
  }

  int getAge() {
    return _age;
  }

  Workout getWorkoutAt(int index) {
    return this._workouts[index];
  }

  Session getSession() {
    return this._currentSession;
  }

  Workout getLastWorkout() {
    return getWorkoutAt(this._workouts.length - 1);
  }

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
    }
  }

  List<Routine> _buildRoutineList(List list) {
    var routines = List<Routine>();
    for (var r in list) {
      if (r["type"] == "COUNTED") {
        routines.add(
          Routine(
            exercise: Exercise(
                name: r["exercise"]["name"], focus: r["exercise"]["focus"]),
            reps: r["reps"],
            sets: r["sets"],
          ),
        );
      } else {
        routines.add(
          TimedRoutine(
              timeToPerformInSeconds: r["timeToPerformInSeconds"],
              exercise: Exercise(name: "Rest", focus: "--")),
        );
      }
    }
    return routines;
  }
}
