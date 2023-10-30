import 'package:flutter/material.dart';

import 'package:lfti/shared/header.dart';

class LogPage extends StatelessWidget {
  static const String path = 'LogPage';

  const LogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Header(title: 'Log'),
          Text('This is the workout log screen.'),
        ],
      ),
    );
  }
}
