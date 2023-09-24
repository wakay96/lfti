import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lfti/constants/enums.dart';
import 'package:lfti/models/exercise.dart';
import 'package:lfti/models/routine.dart';
import 'package:lfti/shared/header.dart';

class RoutineDetailsPage extends StatefulWidget {
  static final String path = AppSubPage.routineDetails.path;

  const RoutineDetailsPage({required this.routine, Key? key}) : super(key: key);
  final Routine routine;

  @override
  State<RoutineDetailsPage> createState() => _RoutineDetailsPageState();
}

class _RoutineDetailsPageState extends State<RoutineDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              log('more tapped!');
            },
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            title: widget.routine.name,
            subtitle: widget.routine.description,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.routine.exercises.length,
            itemBuilder: (context, index) {
              final Exercise exercise = widget.routine.exercises[index];
              return ListTile(
                title: Text(exercise.name),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppSubPage.exerciseDetails.path,
                    arguments: exercise,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
