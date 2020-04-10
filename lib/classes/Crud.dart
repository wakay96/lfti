import "package:cloud_firestore/cloud_firestore.dart";
import "User.dart";
import "Routine.dart";
import "TimedRoutine.dart";
import "Workout.dart";
import "Session.dart";
import "Exercise.dart";

class Crud {
  User _user;
  Crud(this._user);

  void updateWorkoutList() {
    String ref = "workouts";
    List data = _generateWorkoutListQueryMap();
    _updateFireStore(ref, data);
  }

  List _generateWorkoutListQueryMap() {
    try {
      return _user
          .getWorkoutList()
          .map((w) => {
                "id": w.id,
                "name": w.name,
                "description": w.description,
                "routines": w.routines
                    .map((r) => (r is TimedRoutine)
                        ? {
                            "type": "TIMED",
                            "exercise": {
                              "name": r.exercise.name,
                              "focus": r.exercise.focus
                            },
                            "timeToPerformInSeconds": r.timeToPerformInSeconds
                          }
                        : {
                            "type": "COUNTED",
                            "exercise": {
                              "name": r.exercise.name,
                              "focus": r.exercise.focus
                            },
                            "reps": r.reps,
                            "sets": r.sets
                          })
                    .toList()
              })
          .toList();
    } catch (e) {
      print("Error: Failed to create Workout List Query! " + e.toString());
    }
  }

  void _updateFireStore(String ref, var data) {
    Firestore.instance.runTransaction((transaction) async {
      transaction
          .update(_user.getFirestoreReference(), {ref: data})
          .then((val) => print("Success: Database uccessfully updated!"))
          .catchError((e) => print(
              "Error: Failed to update new data! ref:$ref\ndata:\n\n$data\n\n : " +
                  e.toString()));
    });
  }
}
