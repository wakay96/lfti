import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'dart:async';

class TimerCard extends StatefulWidget {
  @override
  final String cardLabel;
  TimerCard({this.cardLabel});

  final _timerCardState = _TimerCardState();
  _TimerCardState createState() {
    _timerCardState.setCardLabel(cardLabel);
    return _timerCardState;
  }

  void restart() {
    _timerCardState.resetStopwatch();
    _timerCardState.startStopWatch();
  }

  void pause() {
    _timerCardState.pauseStopwatch();
  }

  void start() {
    _timerCardState.startStopWatch();
  }

  void terminate() {
    _timerCardState.terminate();
  }

  String getCurrentTime() {
    return _timerCardState.getTime();
  }
}

class _TimerCardState extends State<TimerCard> {
  Stopwatch _stopwatch = Stopwatch();
  String _timerString = '00:00';
  final _duration = const Duration(seconds: 1);
  var label = 'Elapse Time';
  var timer;

  void setCardLabel(String l) {
    this.label = l;
  }

  void _startTimer() {
    timer = Timer(_duration, _keepRunning);
  }

  void _keepRunning() {
    if (_stopwatch.isRunning) {
      _startTimer();
    }
    _updatedTimeString();
  }

  void startStopWatch() {
    _stopwatch.start();
    _startTimer();
  }

  void pauseStopwatch() {
    setState(() {
      _stopwatch.stop();
    });
  }

  void resetStopwatch() {
    setState(() {
      _stopwatch = Stopwatch();
    });
  }

  void terminate() {
    setState(() {
      this.timer.cancel();
    });
  }

  String getTime() {
    return _timerString;
  }

  void _updatedTimeString() {
    int _seconds = (_stopwatch.elapsedMilliseconds ~/ 1000);
    setState(() {
      _timerString = ((_seconds ~/ 60).toString().padLeft(2, '0') +
          ':' +
          (_seconds % 60).toString().padLeft(2, '0'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(label, style: kLabelTextStyle, textAlign: TextAlign.center),
        SizedBox(height: kSmallSizedBoxHeight),
        Text(_timerString,
            style: kMediumBoldTextStyle, textAlign: TextAlign.center),
      ],
    );
  }
}
