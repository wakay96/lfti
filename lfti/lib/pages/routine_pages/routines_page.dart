import 'package:flutter/material.dart';
import 'package:lfti/constants/enums.dart';
import 'package:lfti/models/routine.dart';
import 'package:lfti/pages/routine_pages/add_routine.dart';
import 'package:lfti/pages/routine_pages/routine_details_page.dart';
import 'package:lfti/services/repository.dart';
import 'package:lfti/shared/header.dart';

class RoutinesPage extends StatefulWidget {
  static final String path = AppPage.routines.path;

  const RoutinesPage({super.key});

  @override
  State<RoutinesPage> createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  List<Routine> routines = [];

  @override
  void initState() {
    setState(() {
      routines = Repository().fetchAllRoutines();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(title: AppPage.routines.title),
          SingleChildScrollView(
            child: Column(
              children: routines
                  .map(
                    (routine) => ListTile(
                      title: Text(routine.name),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutineDetailsPage.path,
                          arguments: routine,
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddRoutinePage.path);
        },
        child: const Icon(Icons.add),
      )
    );
  }
}
