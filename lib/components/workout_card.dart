import 'package:flutter/material.dart';

// class imports
import 'package:lfti_app/classes/Workout.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/User.dart';

// component imports
import 'package:lfti_app/components/custom_card.dart';

class WorkoutCard extends StatelessWidget {
  final int index;
  final User user;
  Workout _workout;
  final Function onTap;
  final bool dottedBorder;
  final Function onOptionsTap;
  final IconData optionsIcon;
  int numberOfExercices;
  final shadowOn;
  WorkoutCard({
    this.user,
    this.index,
    this.onTap,
    this.dottedBorder = false,
    this.onOptionsTap,
    this.optionsIcon,
    this.shadowOn = false,
  }) {
    this._workout = this.user.getWorkoutAt(index);
  }

  bool _isIncompleteWorkout() {
    return _workout.name.isEmpty || _workout.routines.isEmpty;
  }

  int _setNumberOfExercises() {
    int sum = 0;
    _workout.routines.forEach((val) {
      if (val.exercise.name != "Rest") {
        sum++;
      }
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    var cardColor =
        _isIncompleteWorkout() ? kAmberAccentColor : kBlueAccentColor.shade100;
    var _workoutNameTextStyle = kMediumBoldTextStyle;
    var _descriptionTextStyle = kSmallTextStyle;
    var _routineCountTextStyle = kSmallBoldTextStyle;
    var _numberOfExercices = _setNumberOfExercises();

    return CustomCard(
      shadow: this.shadowOn,
      color: cardColor,
      onTap: this.onTap,
      dottedBorder: this.dottedBorder,
      cardChild: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Text(
                  this._workout.name,
                  style: _workoutNameTextStyle,
                ),
              ),
              this.onOptionsTap == null
                  ? SizedBox(height: 0.0)
                  : Expanded(
                      child: GestureDetector(
                        child: Container(
                            alignment: AlignmentDirectional.topEnd,
                            child: Icon(optionsIcon, size: 25.0)),
                        onTap: this.onOptionsTap,
                      ),
                    )
            ],
          ),
          Divider(thickness: 3),
          Text(
            this._workout.description,
            style: _descriptionTextStyle,
          ),
          Text(
            this._workout == null || this._workout.routines.isEmpty
                ? "No Routines Created"
                : _workout.routines.isNotEmpty
                    ? _numberOfExercices.toString() + " Exercise Routines"
                    : _numberOfExercices.toString() + " Exercise Routine",
            style: _routineCountTextStyle,
          )
        ],
      ),
    );
  }
}
