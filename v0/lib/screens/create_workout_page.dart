import "package:flutter/material.dart";

// package imports
import "package:intl/intl.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/Routine.dart";

// component imports
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/routine_card.dart";
import "package:lfti_app/components/custom_button_card.dart";
import "package:lfti_app/components/custom_card.dart";

// firestore import
import "package:cloud_firestore/cloud_firestore.dart";

class CreateWorkoutPage extends StatefulWidget {
  final User _args;
  CreateWorkoutPage(this._args);

  @override
  _CreateWorkoutPageState createState() => _CreateWorkoutPageState(this._args);
}

class _CreateWorkoutPageState extends State<CreateWorkoutPage> {
  User _currentUser;
  Workout _workout;
  String _name, _description;
  List<Routine> _routines;
  TextEditingController _nameTextController, _descriptionTextController;

  _CreateWorkoutPageState(this._currentUser) {
    try {
      this._workout = this._currentUser.getLastWorkout();
      this._name = this._workout.name;
      this._routines = this._workout.routines;
      this._nameTextController = TextEditingController(text: _name);
      this._descriptionTextController =
          TextEditingController(text: _description);
    } catch (e) {
      print("Error: Init new workout failed! " + e.toString());
    }
  }

  void _addRoutine() {
    print("TODO: addRoutine implementation");
  }

  void _saveChanges() {
    List newWorkoutList = _currentUser
        .getWorkoutList()
        .map((w) => {
              "id": "W" + DateFormat(kFormatDateId).format(DateTime.now()),
              "name": w.name.toString(),
              "description": w.description.toString(),
              "routines": w.routines
                  .map((r) => {
                        "exercise": {
                          "name": r.exercise.name.toString(),
                          "focus": r.exercise.focus.toString(),
                        },
                        "reps": r.reps,
                        "sets": r.sets
                      })
                  .toList()
            })
        .toList();
    print(newWorkoutList);
    Firestore.instance.runTransaction((transaction) async {
      transaction
          .update(_currentUser.getFirestoreReference(),
              {"workouts": newWorkoutList})
          .then((val) => print("Success: Workouts successfully updated!"))
          .catchError((e) =>
              print("Error: Failed to update user Workouts! " + e.toString()));
    });
  }

  List<RoutineCard> _getRoutineCards() {
    return this._routines.isNotEmpty
        ? this
            ._routines
            .map((r) => RoutineCard(
                  routine: r,
                  onTap: () => print("TODO: Edit Routine"),
                  dottedBorder: true,
                ))
            .toList()
        : List<RoutineCard>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          "Create New Workout",
          style: kSmallTextStyle,
        ),
      ),
      drawer: Menu(_currentUser),
      body: ListView(
        children: <Widget>[
          CustomCard(
            cardChild: TextFormField(
                controller: _nameTextController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Name")),
          ),
          CustomCard(
            cardChild: TextFormField(
                controller: _descriptionTextController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Description")),
          ),
          CustomCard(
            color: Colors.transparent,
            cardChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _routines.isNotEmpty ? "Routines" : "Add Routines",
                  style: kMediumLabelTextStyle,
                ),
                ..._getRoutineCards(),
                CustomButtonCard(onTap: () => _addRoutine())
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationButton(
        label: "SAVE CHANGES",
        action: () {
          _saveChanges();
          Navigator.pushNamed(context, "/workouts", arguments: _currentUser);
        },
        color: kBlueButtonColor,
      ),
    );
  }
}
