import 'package:flutter/material.dart';
import 'RouteGenerator.dart';
import 'package:lfti_app/classes/Constants.dart';
import "package:flutter/services.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lfti',
      theme: ThemeData(
        brightness: Brightness.light,
        buttonTheme: ButtonThemeData(
          minWidth: double.infinity,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          padding: kButtonPadding,
          buttonColor: kBlueButtonColor,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
