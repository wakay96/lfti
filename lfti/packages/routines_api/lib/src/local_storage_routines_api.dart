import 'dart:async';

import 'package:localstorage/localstorage.dart';
import 'package:meta/meta.dart';
import 'package:routines_api/src/models/exeptions.dart';
import 'package:routines_api/src/models/routine.dart';
import 'package:routines_api/src/interface/routines_api_base.dart';

/// {@template local_storage_routines_api}
/// A [RoutinesBaseApi] that stores routines in local storage using `local_store` package.
/// {@endtemplate}

class LocalStorageRoutinesApi implements RoutinessBaseApi {
  LocalStorageRoutinesApi({required LocalStorage plugin}) : _plugin = plugin {
    plugin.ready.then((isReady) {
      if (!isReady) {
        throw UninitializedException('LocalStorage is not initialized.');
      }
    });
  }

  final LocalStorage _plugin;

  @visibleForTesting
  static const String key = '__routine_collection__';
  @visibleForTesting
  static const String subKey = '__routines__';

  @override
  Future<bool> deleteRoutine(String id) async {
    assert(id.isNotEmpty);

    final List<JsonMap> routines = await _plugin.getItem(subKey);
    final int index = routines.indexWhere((r) => r['id'] == id);
    if (index >= 0) {
      routines.removeAt(index);
      return true;
    }
    throw RoutineNotFoundException('Routine with id $id not found.');
  }

  @override
  Future<Routine> getRoutineById(String id) async {
    final JsonMap? data = await _plugin.getItem(id);
    if (data == null) {
      throw RoutineNotFoundException('Routine with id $id not found.');
    }
    return Routine.fromJson(data);
  }

  @override
  Future<List<Routine>> getRoutines() async {
    final List<dynamic>? data = await _plugin.getItem(subKey);
    if (data == null) {
      _plugin.setItem(subKey, []);
      return [];
    }
    return data.map((json) => Routine.fromJson(json)).toList();
  }

  @override
  Future<List<Routine>> saveRoutine(Routine routine) async {
    assert(routine.id.isNotEmpty);

    final List<Routine> allRoutines = await getRoutines();
    final int idx = allRoutines.indexWhere((item) => item.id == routine.id);

    if (idx >= 0) {
      allRoutines[idx] = routine;
    } else {
      allRoutines.add(routine);
    }

    _plugin.setItem(subKey, [routine.toJson()]);
    return allRoutines;
  }
}
