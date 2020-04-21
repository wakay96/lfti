import "package:cloud_firestore/cloud_firestore.dart";
import "User.dart";
import "TimedRoutine.dart";
import "package:intl/intl.dart";
import "package:lfti_app/classes/Constants.dart";

class Crud {
  User _user;
  Crud(this._user);

  void signUp() {
    var sampleWorkoutList = [
      {
        "id": "W" + DateFormat(kFormatDateId).format(DateTime.now()),
        "name": "Chestday",
        "description": "Monday Workout",
        "gymMembership": "",
        "routines": [
          {
            "type": "COUNTED",
            "exercise": {"name": "Barbell Bench Press", "focus": "Chest"},
            "reps": 10,
            "sets": 3,
            "weight": 25.0
          },
          {
            "type": "TIMED",
            "exercise": {"name": "Rest", "focus": null},
            "timeToPerformInSeconds": 60
          },
          {
            "type": "COUNTED",
            "exercise": {"name": "Dumbell Press", "focus": "Chest"},
            "reps": 10,
            "sets": 3,
            "weight": 25.0
          },
          {
            "type": "TIMED",
            "exercise": {"name": "Rest", "focus": null},
            "timeToPerformInSeconds": 60
          },
          {
            "type": "COUNTED",
            "exercise": {"name": "Dumbell Fly", "focus": "Chest"},
            "reps": 10,
            "sets": 3,
            "weight": 25.0
          },
          {
            "type": "TIMED",
            "exercise": {"name": "Rest", "focus": null},
            "timeToPerformInSeconds": 60
          },
          {
            "type": "COUNTED",
            "exercise": {"name": "Push Up", "focus": "Chest"},
            "reps": 10,
            "sets": 3,
            "weight": 25.0
          },
          {
            "type": "TIMED",
            "exercise": {"name": "Rest", "focus": null},
            "timeToPerformInSeconds": 60
          },
          {
            "type": "COUNTED",
            "exercise": {"name": "Fly", "focus": "Chest"},
            "reps": 10,
            "sets": 3,
            "weight": 25.0
          },
          {
            "type": "TIMED",
            "exercise": {"name": "Rest", "focus": null},
            "timeToPerformInSeconds": 60
          },
          {
            "type": "COUNTED",
            "exercise": {
              "name": "Decline dumbbell bench press",
              "focus": "Chest"
            },
            "reps": 10,
            "sets": 3,
            "weight": 25.0
          },
          {
            "type": "TIMED",
            "exercise": {"name": "Rest", "focus": null},
            "timeToPerformInSeconds": 60
          },
          {
            "type": "COUNTED",
            "exercise": {"name": "Dumbell pullover", "focus": "Chest"},
            "reps": 10,
            "sets": 3,
            "weight": 25.0
          },
          {
            "type": "TIMED",
            "exercise": {"name": "Rest", "focus": null},
            "timeToPerformInSeconds": 60
          },
          {
            "type": "COUNTED",
            "exercise": {"name": "Cable Iron Cross", "focus": "Chest"},
            "reps": 10,
            "sets": 3,
            "weight": 25.0
          }
        ]
      }
    ];
    var data = {
      "firstName": _user.getFirstName().toString(),
      "lastName": _user.getLastName().toString(),
      "email": _user.getEmail().toString(),
      "workouts": sampleWorkoutList.toList()
    };

    print(data.runtimeType);
    _user
        .getFirestoreReference()
        .setData(data)
        .then((val) => print("Sucess: Initial Data has been set!"))
        .catchError((e) => print("Error: Failed to write data! $e"));
  }

  void updateWorkoutList() {
    String ref = "workouts";
    List data = _generateWorkoutListQueryMap();
    updateDatabase(ref, data);
  }

  List _generateWorkoutListQueryMap() {
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
                          "sets": r.sets,
                          "weight": r.weight
                        })
                  .toList()
            })
        .toList();
  }

  void updateDatabase(String ref, var data) {
    Firestore.instance.runTransaction((transaction) async {
      transaction
          .update(_user.getFirestoreReference(), {ref: data})
          .then((val) => print("Success: Database uccessfully updated!"))
          .catchError(
            (e) => print(
              "Error: Failed to update new data! ref:$ref\ndata:\n\n$data\n\n : " +
                  e.toString(),
            ),
          );
    });
  }
}
