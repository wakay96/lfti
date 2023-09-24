import 'package:flutter/material.dart';
import 'package:lfti/constants/enums.dart';

class LogPage extends StatelessWidget {
  static final String path = AppPage.log.path;

  const LogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Log'),
      ),
      body: const Center(
        child: Text('This is the workout log screen.'),
      ),
    );
  }
}
