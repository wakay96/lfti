import 'package:flutter/material.dart';
import 'package:lfti/constants/enums.dart';
import 'package:lfti/models/routine.dart';
import 'package:lfti/pages/routine_pages/routine_details_page.dart';
import 'package:lfti/services/repository.dart';

class RoutinesPage extends StatefulWidget {
  static final String path = AppPage.routines.path;

  const RoutinesPage(List<Routine> routines, {super.key});

  @override
  State<RoutinesPage> createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  List<Routine> routines = Repository().fetchAllRoutines();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(routines[index].name),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutineDetailsPage.path,
              arguments: routines[index],
            );
          },
        );
      },
      itemCount: routines.length,
    );
  }
}
