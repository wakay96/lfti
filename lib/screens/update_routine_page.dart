import 'dart:ffi';

import "package:flutter/material.dart";
import "package:numberpicker/numberpicker.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/Routine.dart";
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/TimedRoutine.dart";

// component imports
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/custom_dropdown_menu.dart";
import "package:lfti_app/components/custom_card.dart";
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
  String _exerciseName, _exerciseFocus;
  int _sets, _reps, _timeToPerformInSeconds;

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

  void _updateMuscleGroupFocus(String val) {
    setState(() {
      _exerciseFocus = val;
    });
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
  }

  void _showTargetOptionDialog() async {
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
  }

  Widget _buildRepsTargetOptionSection() {
    return CustomCard(
      cardChild: Column(
        children: <Widget>[
          Text("Counted Routined"),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SizedBox(),
              ),
              // reps section
              Expanded(
                flex: 10,
                child: GestureDetector(
                  onTap: () => _showRepsOptionDialog(),
                  child: CustomCard(
                    color: kIconColor.withOpacity(0.1),
                    cardChild: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Reps", style: kLabelTextStyle),
                          Text(
                            this._reps.toString(),
                            style: kMediumTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              // sets section
              Expanded(
                flex: 10,
                child: GestureDetector(
                  onTap: () => _showSetsOptionDialog(),
                  child: CustomCard(
                    color: kIconColor.withOpacity(0.1),
                    cardChild: Center(
                      child: Column(
                        children: <Widget>[
                          Text("Sets", style: kLabelTextStyle),
                          Text(
                            this._sets.toString(),
                            style: kMediumTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveChanges() {
    _routine.exercise.name = _nameTextController.text.isEmpty
        ? "Unnamed Routine"
        : _nameTextController.text.toString();
    _routine.exercise.focus = this._exerciseFocus;
    _routine.sets = this._sets;
    _routine.reps = this._reps;

    Workout workout = _currentUser.getWorkoutAt(this._workoutIndex);
    workout.setRoutineAt(this._routineIndex, this._routine);
    this._currentUser.setWorkoutAt(
          this._workoutIndex,
          workout,
        );
    Navigator.pushNamed(
      context,
      "/updateWorkout",
      arguments: {"user": _currentUser, "index": _workoutIndex},
    );
  }

  //======================================CONTENT SECTION======================================//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Routine", style: kSmallTextStyle),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: kSizedBoxHeight),
            CustomTextFormField(
              textController: _nameTextController,
              label: "Name",
            ),

            // muscle group section
            CustomCard(
              cardChild: GestureDetector(
                onTap: () => _showMuscleGroupOptionDialog(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text("Major Muscle Group", style: kLabelTextStyle),
                    Text(
                      this._exerciseFocus,
                      style: kSmallBoldTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: _buildRepsTargetOptionSection(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(
          label: "SAVE CHANGES",
          action: () => _saveChanges(),
          color: kBlueButtonColor),
    );
  }
  //======================================CONTENT SECTION======================================//
}
