import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:lfti/packages/models/exercise.dart';
import 'package:lfti/packages/models/routine.dart';
import 'package:lfti/pages/routine_pages/exercise_details_page.dart';
import 'package:lfti/pages/routine_pages/exercise_list_page.dart';
import 'package:lfti/pages/session_page.dart';
import 'package:lfti/shared/header.dart';

class RoutineDetailsPage extends StatefulWidget {
  static const String path = 'RoutineDetailsPage';

  const RoutineDetailsPage({required this.routine, Key? key}) : super(key: key);
  final Routine routine;

  @override
  State<RoutineDetailsPage> createState() => _RoutineDetailsPageState();
}

class _RoutineDetailsPageState extends State<RoutineDetailsPage> {
  void _onTapExercise(Exercise exercise) {
    Navigator.of(context).pushNamed(
      ExerciseDetailsPage.path,
      arguments: exercise,
    );
  }

  void _onStartRoutine() {
    Navigator.of(context).pushNamed(
      SessionPage.path,
      arguments: widget.routine,
    );
  }

  void _saveChanges() {
    EasyLoading.showToast('Changes saved...');
  }

  bool _isEditing = false;
  List<Exercise> exercises = [];

  @override
  void initState() {
    exercises = [...widget.routine.exercises];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                if (_isEditing) _saveChanges();
                _isEditing = !_isEditing;
              });
            },
            icon: _isEditing
                ? const Icon(
                    Icons.save,
                    color: Colors.green,
                  )
                : const Icon(Icons.edit),
          ),
        ],
      ),
      floatingActionButton: _isEditing
          ? null
          : FloatingActionButton(
              onPressed: _onStartRoutine,
              child: const Icon(Icons.directions_run_rounded),
            ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              <Widget>[
                Header(
                  title: widget.routine.name,
                  subtitle: widget.routine.description,
                ),
                Visibility(
                  visible: _isEditing,
                  child: Center(
                    child: TextButton.icon(
                      onPressed: () async {
                        final dynamic res = await Navigator.pushNamed(
                          context,
                          ExerciseListPage.path,
                        );
                        if (res != null) {
                          setState(() {
                            exercises.insert(0, res as Exercise);
                          });
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Exercise'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverList.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final Exercise exercise = exercises[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  title: Text(exercise.name),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () => _onTapExercise(exercise),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
