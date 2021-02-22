import 'package:flutter/material.dart';
import 'RouteGenerator.dart';
import 'package:lfti_app/classes/Constants.dart';

void main() => runApp(App());

String _appName = "lfti";

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appName,
      theme: kThemeData,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
