import 'package:flutter/material.dart';
import 'package:lfti/constants/enums.dart';
import 'package:lfti/models/exercise.dart';

class AddExerciseDetailsPage extends StatefulWidget {
  static String path = AppSubPage.updateExercise.path;
  const AddExerciseDetailsPage({super.key, required this.exercise});
  final Exercise exercise;
  @override
  State<AddExerciseDetailsPage> createState() => _AddExerciseDetailsPageState();
}

class _AddExerciseDetailsPageState extends State<AddExerciseDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _exerciseNameController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  @override
  void initState() {
    _exerciseNameController.text = widget.exercise.name;
    _repsController.text = widget.exercise.reps?.toString() ?? '1';
    _setsController.text = widget.exercise.sets?.toString() ?? '1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _exerciseNameController,
                      decoration:
                          const InputDecoration(labelText: 'Exercise Name'),
                      validator: (String? value) {
                        if (value?.isEmpty != false) {
                          return 'Please enter an exercise name';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        _exerciseNameController.text = value ?? '';
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _setsController,
                            decoration: const InputDecoration(
                              labelText: 'Sets',
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value?.isEmpty != false) {
                                return 'Please enter the number of sets';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              _setsController.text = value ?? '1';
                            },
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: TextFormField(
                            controller: _repsController,
                            decoration: const InputDecoration(
                              labelText: 'Reps',
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value?.isEmpty != false) {
                                return 'Please enter the number of reps';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              _repsController.text = value ?? '1';
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.pop(
                          context,
                          Exercise(
                            name: _exerciseNameController.text,
                            muscleGroup: widget.exercise.muscleGroup,
                            description: widget.exercise.description,
                            instructions: widget.exercise.instructions,
                            tips: widget.exercise.tips,
                            minutes: widget.exercise.minutes,
                            seconds: widget.exercise.seconds,
                            sets: int.parse(_setsController.text),
                            reps: int.parse(_repsController.text),
                          ),
                        );
                      }
                    },
                    child: const Text('Add'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
