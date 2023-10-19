import 'package:flutter/material.dart';
import 'package:lfti/data/constants/enums.dart';
import 'package:lfti/shared/header.dart';

class LogPage extends StatelessWidget {
  static final String path = AppPage.log.path;

  const LogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(title: AppPage.log.title),
          const Text('This is the workout log screen.'),
        ],
      ),
    );
  }
}
