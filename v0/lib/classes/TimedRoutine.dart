import "Routine.dart";
import "Exercise.dart";
import "package:flutter/material.dart";

class TimedRoutine extends Routine {
  int timeToPerformInSeconds;
  Exercise exercise;
  TimedRoutine({this.timeToPerformInSeconds = 90, @required this.exercise})
      : super(exercise: exercise);
}
