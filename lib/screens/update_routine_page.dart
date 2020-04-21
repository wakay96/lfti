import "package:flutter/material.dart";
import "package:numberpicker/numberpicker.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/Routine.dart";
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/User.dart";

// component imports
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/custom_dropdown_menu.dart";
import "package:lfti_app/components/routine_data_card.dart";
import "package:lfti_app/components/custom_text_form_field.dart";

class UpdateRoutinePage extends StatefulWidget {
  final Map _args;
  UpdateRoutinePage(this._args);

  @override
  _UpdateRoutinePageState createState() => _UpdateRoutinePageState(this._args);
}

class _UpdateRoutinePageState extends State<UpdateRoutinePage> {
  User _currentUser;
  Routine _routine;
  int _workoutIndex;
  int _routineIndex;
  TextEditingController _nameTextController;
  String _exerciseFocus;
  int _sets, _reps;
  double _weight;

  _UpdateRoutinePageState(Map args) {
    this._currentUser = args["user"];
    this._workoutIndex = args["workoutIndex"];
    this._routineIndex = args["routineIndex"];
    this._routine = this
        ._currentUser
        .getWorkoutAt(this._workoutIndex)
        .routines[this._routineIndex];
    this._nameTextController =
        TextEditingController(text: this._routine.exercise.name);
    this._sets = this._routine.sets;
    this._reps = this._routine.reps;
    this._weight = this._routine.weight;
    this._exerciseFocus = this._routine.exercise.focus.toString();
  }

  void _showRepsOptionDialog() async {
    return await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 100,
            title: Text("Rep Count"),
            initialIntegerValue: this._reps,
          );
        }).then((int val) {
      if (val != null) {
        _updateReps(val);
      }
    });
  }

  void _showSetsOptionDialog() async {
    return await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 12,
            title: Text("Set Count"),
            initialIntegerValue: this._sets,
          );
        }).then((int val) {
      if (val != null) {
        _updateSets(val);
      }
    });
  }

  void _showWeightInputDialog() async {
    var currentWeight =
        _routine.weight != null ? _routine.weight.toString() : "0.0";
    final inputTextController = TextEditingController(text: currentWeight);
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Muscle Group"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          content: TextFormField(
            controller: inputTextController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            onTap: () => inputTextController.clear(),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Cancel",
                style: kSmallTextStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Confirm",
                style: kSmallTextStyle,
              ),
              onPressed: () {
                _updateWeight(inputTextController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showMuscleGroupOptionDialog() async {
    var _dropdown = CustomDropdownMenu(
      initialValue: this._routine.exercise.focus,
      items: ["Chest", "Back", "Bicep", "Tricep", "Legs", "Shoulder", "--"],
    );
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Muscle Group"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          content: _dropdown,
          actions: <Widget>[
            FlatButton(
                child: Text(
                  "Cancel",
                  style: kSmallTextStyle,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            FlatButton(
                child: Text(
                  "Confirm",
                  style: kSmallTextStyle,
                ),
                onPressed: () {
                  _updateMuscleGroupFocus(_dropdown.getValue());
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  void _updateReps(int val) {
    if (this._reps != val) {
      setState(() {
        this._reps = val;
      });
    }
  }

  void _updateSets(int val) {
    if (this._sets != val) {
      setState(() {
        this._sets = val;
      });
    }
  }

  void _updateWeight(String val) {
    try {
      double w = double.parse(val.trim());
      setState(() {
        this._routine.weight = w;
        this._weight = w;
      });
    } catch (e) {
      print("Error:" + val + "is not a number! $e");
    }
  }

  void _updateMuscleGroupFocus(String val) {
    setState(() {
      _exerciseFocus = val;
    });
  }

  void _saveChanges() {
    _routine.exercise.name = _nameTextController.text.isEmpty
        ? "Unnamed Routine"
        : _nameTextController.text.toString();
    _routine.exercise.focus = this._exerciseFocus;
    _routine.sets = this._sets;
    _routine.reps = this._reps;
    _routine.weight = this._weight;

    Workout workout = _currentUser.getWorkoutAt(this._workoutIndex);
    workout.setRoutineAt(this._routineIndex, this._routine);
    this._currentUser.setWorkoutAt(this._workoutIndex, workout);
    Navigator.pushNamed(
      context,
      "/updateWorkout",
      arguments: {"user": _currentUser, "index": _workoutIndex},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Routine"),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: kContentPadding,
          child: ListView(
            children: <Widget>[
              CustomTextFormField(
                textController: _nameTextController,
                label: "Name",
              ),
              Container(
                child: Row(
                  // muscle group section
                  children: <Widget>[
                    RoutineDataCard(
                      label: "FOCUS",
                      data: this._exerciseFocus,
                      onTap: () => _showMuscleGroupOptionDialog(),
                    ),
                    RoutineDataCard(
                      label: "WEIGHT",
                      data: this._weight != null
                          ? this._weight.toString()
                          : "Add weight",
                      onTap: () => _showWeightInputDialog(),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  // muscle group section
                  children: <Widget>[
                    RoutineDataCard(
                      label: "REPS",
                      data: this._reps.toString(),
                      onTap: () => _showRepsOptionDialog(),
                    ),
                    RoutineDataCard(
                      label: "SETS",
                      data: this._sets.toString(),
                      onTap: () => _showSetsOptionDialog(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(
          label: "SAVE CHANGES",
          action: () => _saveChanges(),
          color: kBlueButtonColor),
    );
  }
}

// TODO: Implement change workout type
/* void _showTargetOptionDialog() async {
    var _dropdown = CustomDropdownMenu(
      initialValue: "Rep Count",
      items: ["Rep Count", "Time"],
    );
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Completion Target"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          content: _dropdown,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Cancel",
                style: kSmallTextStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Confirm",
                style: kSmallTextStyle,
              ),
              onPressed: () {
                _updateMuscleGroupFocus(_dropdown.getValue());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } */
