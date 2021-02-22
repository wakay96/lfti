import 'package:get_it/get_it.dart';
import 'package:lfti/data/repository/mock_repository.dart';
import 'package:lfti/data/repository/i_repository.dart';

import 'data/models/date_time_info_test.dart';
import 'data/models/workout_test.dart';
import 'data/repository/repository_test.dart';

void main() {
  registerDependencies();
  dateTimeInfoTest();
  workoutTest();
  repositoryTest();
}

void registerDependencies() {
  GetIt.I.registerFactory<IRepository>(() => MockRepository());
}
