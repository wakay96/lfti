import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lfti/data/constants/enums.dart';
import 'package:lfti/data/models/routine.dart';
import 'package:lfti/pages/routine_pages/add_routine.dart';
import 'package:lfti/pages/routine_pages/routine_details_page.dart';
import 'package:lfti/shared/header.dart';

class RoutinesPage extends StatelessWidget {
  static final String path = AppPage.routines.path;

  const RoutinesPage({this.routines, super.key});

  final List<Routine>? routines;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: AppPage.routines.title),
            Visibility(
              visible: routines != null,
              child: SingleChildScrollView(
                child: Column(
                  children: routines!
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
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddRoutinePage.path);
          },
          child: const Icon(Icons.add),
        ));
  }
}
