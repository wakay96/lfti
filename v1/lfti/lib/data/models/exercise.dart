import 'package:flutter/material.dart';
import 'package:lfti/helpers/id_generator.dart';

import 'activity.dart';

class Exercise extends Activity {
  String target;
  int setCount;
  int repCount;

  Exercise({
    String id,
    String name,
    String description,
    this.target,
    @required this.setCount,
    @required this.repCount,
  }) : super(id: id, name: name, description: description);

  Exercise.empty() : super(id: IdGenerator.generateV4());

  Exercise.clone(Exercise exercise)
      : super(
            id: IdGenerator.generateV4(),
            name: exercise.name,
            description: exercise.description) {
    this.target = exercise.target;
    this.setCount = exercise.setCount;
    this.repCount = exercise.repCount;
  }
}
