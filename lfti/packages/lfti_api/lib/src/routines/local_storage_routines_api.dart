import 'dart:async';

import 'package:lfti_api/src/routines/interface/base_routines_api.dart';
import 'package:lfti_api/src/routines/models/exeptions.dart';
import 'package:lfti_api/src/type_definitions.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meta/meta.dart';

/// {@template local_storage_routines_api}
/// A [RoutinesBaseApi] that stores routines in local storage using `local_store` package.
/// {@endtemplate}

class LocalStorageRoutinesApi implements RoutinesApi {
  @visibleForTesting
  static const String key = '__routine_collection__';
  @visibleForTesting
  static const String subKey = '__routines__';

  LocalStorageRoutinesApi() : _plugin = LocalStorage(key) {
    _plugin.ready.then((isReady) {
      if (!isReady) {
        throw UninitializedException('LocalStorage is not initialized.');
      }
    });
  }

  final LocalStorage _plugin;

  @override
  Future<dynamic> deleteRoutine(String id) async {
    assert(id.isNotEmpty);

    final List<dynamic>? routines = await _plugin.getItem(subKey);
    if (routines == null) {
      throw UninitializedException('Routines uninitialized.');
    }

    final int index = routines.indexWhere((r) => r['id'] == id);
    if (index >= 0) {
      final json = routines[index] as JsonMap;
      routines.removeAt(index);
      return json;
    }
    throw RoutineNotFoundException('Routine with id $id not found.');
  }

  @override
  Future<JsonMap> getRoutineById(String id) async {
    final JsonMap? data = await _plugin.getItem(id);
    if (data == null) {
      throw RoutineNotFoundException('Routine with id $id not found.');
    }
    return data;
  }

  @override
  Future<List<dynamic>> getRoutines() async {
    final List<dynamic>? data = await _plugin.getItem(subKey) as List<dynamic>?;
    if (data == null) {
      _plugin.setItem(subKey, []);
      return [];
    }
    return data;
  }

  @override
  Future<List<dynamic>> saveRoutine(JsonMap data) async {
    assert(data['id'].isNotEmpty);

    final List<dynamic> allRoutines = await getRoutines();
    final int idx = allRoutines.indexWhere((v) => v['id'] == data['id']);

    if (idx >= 0) {
      allRoutines[idx] = data;
    } else {
      allRoutines.add(data);
    }

    _plugin.setItem(subKey, [data]);
    return allRoutines;
  }

  @override
  Future<void> clear() async => await _plugin.clear();
}
