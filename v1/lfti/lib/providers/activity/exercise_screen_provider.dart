import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/exercise_list_data.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/helpers/app_strings.dart';

class ExerciseScreenProvider extends ChangeNotifier {
  ExerciseListData chestExercises = ExerciseListData(Target.Chest, []);
  ExerciseListData legExercises = ExerciseListData(Target.Leg, []);
  ExerciseListData shoulderExercises = ExerciseListData(Target.Shoulder, []);
  ExerciseListData backExercises = ExerciseListData(Target.Back, []);
  ExerciseListData armExercises = ExerciseListData(Target.Arm, []);
  ExerciseListData customExercises = ExerciseListData(Target.Custom, []);
  ExerciseListData coreExercises = ExerciseListData(Target.Core, []);
  late final IRepository repo;

  void initialize(BuildContext context) {
    repo = GetIt.instance<IRepository>();
    chestExercises = ExerciseListData(
      Target.Chest,
      repo.getExercisesByTarget(Target.Chest),
    );
    legExercises = ExerciseListData(
      Target.Leg,
      repo.getExercisesByTarget(Target.Leg),
    );
    shoulderExercises = ExerciseListData(
      Target.Shoulder,
      repo.getExercisesByTarget(Target.Shoulder),
    );
    backExercises = ExerciseListData(
      Target.Back,
      repo.getExercisesByTarget(Target.Back),
    );
    armExercises = ExerciseListData(
      Target.Arm,
      repo.getExercisesByTarget(Target.Arm),
    );
    customExercises = ExerciseListData(
      Target.Custom,
      repo.getExercisesByTarget(Target.Custom),
    );
    coreExercises = ExerciseListData(
      Target.Core,
      repo.getExercisesByTarget(Target.Core),
    );
    notifyListeners();
  }
}
