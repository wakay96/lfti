import 'package:get_it/get_it.dart';
import 'package:lfti/data/repository/mock_repository.dart';
import 'package:lfti/data/repository/i_repository.dart';

class AppManager {
  AppManager._internal();
  static final AppManager _manager = AppManager._internal();
  factory AppManager() => _manager;

  void registerServices() {
    GetIt.I.registerSingleton<IRepository>(MockRepository());
  }
}
