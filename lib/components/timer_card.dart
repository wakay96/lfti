import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'dart:async';

class TimerCard extends StatefulWidget {
  @override
  final String cardLabel;
  TimerCard({this.cardLabel});

  final _timerCardState = _TimerCardState();
  _TimerCardState createState() {
    _timerCardState.setCardLabel(this.cardLabel);
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
  var _label = 'Elapse Time';
  var timer;

  void setCardLabel(String l) {
    this._label = l;
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
    int hour = _seconds ~/ 3600;
    int min = ((_seconds % 3600) - (hour * 60)) ~/ 60;
    int sec = (_seconds - (60 * min)) % 60;
    setState(() {
      _timerString = hour.toString().padLeft(2, '0') +
          ":" +
          min.toString().padLeft(2, '0') +
          ':' +
          sec.toString().padLeft(2, '0');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(_label, style: kLabelTextStyle, textAlign: TextAlign.center),
          Text(_timerString,
              style: kMediumBoldTextStyle, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
