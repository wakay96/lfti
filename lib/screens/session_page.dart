import "package:flutter/material.dart";

// Class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/Session.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/TimedRoutine.dart";

// Component imports
import "package:lfti_app/components/custom_card.dart";
import "package:lfti_app/components/timer_card.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";

class SessionPage extends StatefulWidget {
  final User _currentUser;
  SessionPage(this._currentUser);

  @override
  _SessionPageState createState() => _SessionPageState(_currentUser);
}

class _SessionPageState extends State<SessionPage> {
  User _currentUser;
  Session _session;
  int _currentSet;
  var _currentRoutine;
  final _routineTimerController = TimerCard(cardLabel: "ROUTINE TIME");
  final _sessionTimerController = TimerCard(cardLabel: "SESSION TIME");

  _SessionPageState(this._currentUser) {
    this._session = _currentUser.getSession();
    this._currentSet = 1;
    this._currentRoutine = _session.getCurrentRoutine();
  }
  void _showSessionConfirmationDialogBox() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("End Session"),
          content: Text("You are about to end this session!"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: kCardBackground.withOpacity(0.9),
          actions: <Widget>[
            FlatButton(
                child: Text("Cancel", style: kSmallTextStyle),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            FlatButton(
                child: Text(
                  "Confirm",
                  style: kSmallTextStyle,
                ),
                onPressed: () {
                  _routineTimerController.terminate();
                  _sessionTimerController.terminate();
                  setState(() {
                    _session.end(_sessionTimerController.getCurrentTime());
                  });
                  Navigator.pushNamed(context, "/endSession",
                      arguments: {"user": _currentUser, "session": _session});
                }),
          ],
        );
      },
    );
  }

  bool _isFirstRoutineAndSet() {
    return _session.getCurrentRoutineIndex() == 0 &&
        _session.getCurrentSet() == 0;
  }

  void _next() {
    if (!_session.isFinished()) {
      try {
        _routineTimerController.restart();
        _session.next();
        _updateState();
      } catch (e) {
        print("Error: something went wrong calling next() in Session Page!");
      }
    } else {
      _routineTimerController.terminate();
      _sessionTimerController.terminate();
    }
  }

  void _back() {
    _routineTimerController.restart();
    _session.previous();
    _updateState();
  }

  void _skip() {
    _routineTimerController.restart();
    _session.skip();
    _updateState();
  }

  void _updateState() {
    setState(() {
      _currentSet = _session.getCurrentSet();
      _currentRoutine = _session.getCurrentRoutine();
    });
  }

  void _init() {
    // Run Timer at navigate
    _routineTimerController.start();
    _sessionTimerController.start();
    _session.isPaused
        ? _routineTimerController.pause()
        : _routineTimerController.start();
    _currentSet = _session.getCurrentSet();
    _currentRoutine = _session.getCurrentRoutine();
  }

  void _togglePause() {
    setState(() {
      _session.togglePause();
    });
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Excercise Section
              Expanded(
                flex: 2,
                child: CustomCard(
                  cardChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // Exercise Name Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "EXERCISE",
                            style: kLabelTextStyle,
                          ),
                          SizedBox(height: kSmallSizedBoxHeight),
                          Text(
                            _session.getCurrentRoutine().exercise.name,
                            style: kMediumBoldTextStyle,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          // Target Section
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "TARGET",
                                  style: kLabelTextStyle,
                                ),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: <Widget>[
                                    Text(
                                        _currentRoutine is TimedRoutine
                                            ? _currentRoutine
                                                .timeToPerformInSeconds
                                                .toString()
                                            : _currentRoutine.reps.toString(),
                                        style: kLargeBoldTextStyle1x),
                                    Text(
                                      _currentRoutine is TimedRoutine
                                          ? " seconds"
                                          : " reps",
                                      style: kUnitLabelTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Sets Section
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "SETS",
                                  style: kLabelTextStyle,
                                ),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: <Widget>[
                                    Text(
                                      _currentSet.toString(),
                                      style: kLargeBoldTextStyle1x,
                                    ),
                                    Text(
                                      " / " + _currentRoutine.sets.toString(),
                                      style: kLargeBoldTextStyle1x,
                                    ),
                                    Text(
                                      " sets",
                                      style: kUnitLabelTextStyle,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Routine Navigation Buttons Section
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Next Button
                      RaisedButton(
                        onPressed: _session.isPaused || _session.isFinished()
                            ? null
                            : () => _next(),
                        child: Text("NEXT", style: kButtonTextFontStyle),
                      ),
                      SizedBox(height: kSizedBoxHeight),
                      Row(
                        children: <Widget>[
                          // Back Button
                          Expanded(
                            child: RaisedButton(
                              onPressed:
                                  _session.isPaused || _isFirstRoutineAndSet()
                                      ? null
                                      : () => _back(),
                              child: Text("BACK", style: kButtonTextFontStyle),
                              color: kRedButtonColor,
                            ),
                          ),
                          SizedBox(width: kSizedBoxHeight),
                          // Skip Button
                          Expanded(
                            child: RaisedButton(
                              onPressed:
                                  _session.isPaused || _session.isLastRoutine()
                                      ? null
                                      : () => _skip(),
                              child: Text("SKIP",
                                  style: kButtonTextFontStyle.copyWith()),
                              color: kAmberButtonColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Next Routine View Section
              CustomCard(
                cardChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "NEXT ROUTINE",
                      style: kLabelTextStyle,
                    ),
                    SizedBox(height: kSmallSizedBoxHeight),
                    Container(
                        child: Text(
                      _session.getNextRoutine().exercise.name,
                      style: kMediumBoldTextStyle,
                    )),
                  ],
                ),
              ),

              // Timer Section
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: CustomCard(
                        cardChild: _routineTimerController,
                      ),
                    ),
                    Expanded(
                      child: CustomCard(
                        cardChild: _sessionTimerController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kSizedBoxHeight)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: GestureDetector(
          onLongPress: () => _showSessionConfirmationDialogBox(),
          child: _session.isFinished()
              ? BottomNavigationButton(
                  label: "END",
                  action: () {
                    _showSessionConfirmationDialogBox();
                  },
                  color: kRedButtonColor,
                )
              : BottomNavigationButton(
                  label: _session.isPaused ? "CONTINUE" : "PAUSE",
                  action: () => _togglePause(),
                  color:
                      _session.isPaused ? kGreenButtonColor : kBlueButtonColor,
                ),
        ),
      ),
    );
  }
}
