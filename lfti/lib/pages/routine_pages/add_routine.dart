import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lfti/constants/enums.dart';
import 'package:lfti/models/exercise.dart';
import 'package:lfti/pages/routine_pages/exercise_list_page.dart';

class AddRoutinePage extends StatefulWidget {
  static final String path = AppSubPage.addRoutine.path;
  const AddRoutinePage({super.key});

  @override
  State<AddRoutinePage> createState() => _AddRoutinePageState();
}

class _AddRoutinePageState extends State<AddRoutinePage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Exercise> exercises = [];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Add Routine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        validator: (value) =>
                            value?.isEmpty == true ? 'Enter a name' : null,
                        controller: _nameController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(12.0),
                          isCollapsed: true,
                          labelText: 'Routine Name',
                          border: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.all(12.0),
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: Column(
                              children: exercises
                                  .map(
                                    (exercise) => Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                      ),
                                      child: Slidable(
                                        key: UniqueKey(),
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              autoClose: true,
                                              onPressed: (context) {
                                                setState(() {
                                                  exercises.remove(exercise);
                                                });
                                              },
                                              icon: Icons.delete,
                                              backgroundColor: Colors.red,
                                            ),
                                            SlidableAction(
                                              autoClose: true,
                                              onPressed: (context) async {
                                                final List<Exercise> copy = [
                                                  ...exercises
                                                ];
                                                final int i =
                                                    copy.indexOf(exercise);

                                                final dynamic res =
                                                    await Navigator.pushNamed(
                                                  context,
                                                  ExerciseListPage.path,
                                                );

                                                if (res != null) {
                                                  copy.insert(
                                                      i, res as Exercise);
                                                  copy.removeAt(i + 1);
                                                }

                                                setState(() {
                                                  exercises = copy;
                                                });
                                              },
                                              icon: Icons.swap_vert_rounded,
                                              backgroundColor: Colors.orange,
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          title: Text(exercise.name),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Sets: ${exercise.sets}'),
                                              Text('Reps: ${exercise.reps}'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          Center(
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
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState?.validate() != false) {
                                _formKey.currentState?.save();
                                final String name = _nameController.text;
                                final String type = _descriptionController.text;
                                EasyLoading.show(status: 'Saving routine...');
                                // TODO: Save the routine to a database
                                Future.delayed(const Duration(seconds: 2), () {
                                  EasyLoading.dismiss();
                                  Navigator.pop(context);
                                });
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 300),
                                  content: Text(
                                    'Please fill in the required fields',
                                  ),
                                ),
                              );
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
