import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lfti/data/constants/enums.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/pages/routine_pages/add_exercise_details_page.dart';

class ExerciseListPage extends StatefulWidget {
  static final String path = AppSubPage.exerciseList.path;
  const ExerciseListPage({Key? key}) : super(key: key);
  @override
  State<ExerciseListPage> createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  List<Exercise> exercises = [];

  @override
  void initState() {
    // TODO: Add excercis fetching logic
    exercises = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exercises',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  return ListTile(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context, exercise);
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                    title: Text(exercise.name),
                    subtitle:
                        Text('${exercise.sets} sets of ${exercise.reps} reps'),
                    onTap: () async {
                      try {
                        final dynamic res =
                            await Navigator.of(context).pushNamed(
                          AddExerciseDetailsPage.path,
                          arguments: exercise,
                        );
                        if (res is Exercise) {
                          Navigator.pop(context, res);
                        }
                      } catch (e) {
                        EasyLoading.showToast(e.toString());
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
