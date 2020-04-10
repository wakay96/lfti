import "package:flutter/material.dart";
import 'package:lfti_app/classes/Constants.dart';
import "package:lfti_app/classes/User.dart";
import 'dart:async';

class LoginNavigationScreen extends StatefulWidget {
  User _currentUser;
  LoginNavigationScreen(this._currentUser);

  @override
  _LoginNavigationScreenState createState() =>
      _LoginNavigationScreenState(_currentUser);
}

class _LoginNavigationScreenState extends State<LoginNavigationScreen> {
  User _currentUser;
  Timer _timer;
  String _appName = "lfti";
  _LoginNavigationScreenState(this._currentUser);

  Timer _startTimer(BuildContext context) {
    setState(() {
      this._timer = Timer(
        Duration(seconds: 3),
        _updateState,
      );
    });
    return _timer;
  }

  void _updateState() {
    _timer.cancel();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    _startTimer(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: kBlueButtonColor,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Expanded(
              child: Text(
                _appName,
                style: kLargeBoldTextStyle2x.copyWith(color: Colors.white),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://i.pinimg.com/originals/55/dd/91/55dd91a7fa65a104c9e08cc31e68d840.gif",
                      scale: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
