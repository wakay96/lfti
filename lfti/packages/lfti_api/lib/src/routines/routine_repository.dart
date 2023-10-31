import 'dart:async';

import 'package:get/instance_manager.dart';
import 'package:lfti_api/src/routines/interface/base_repository.dart';
import 'package:lfti_api/src/routines/interface/base_routines_api.dart';
import 'package:lfti_api/src/routines/models/routine.dart';

class RoutineRepository implements BaseRepository<Routine, Routine?> {
  static final RoutineRepository _instance = RoutineRepository._internal();
  factory RoutineRepository() => _instance;
  RoutineRepository._internal();

  final RoutinesApi _api = Get.find<RoutinesApi>();
  final List<Routine> _routines = [];

  /// Appends new routine at the end of the list
  /// Will not add if rouitine id is empty.
  /// Returns updated routines.
  @override
  Future<List<Routine>> add(Routine data) async {
    assert(data.id.isNotEmpty);
    await _api.saveRoutine(data.toJson());
    _routines.add(data);
    return _routines;
  }

  /// Returns updated routines.
  @override
  Future<List<Routine>> delete(String id) async {
    assert(id.isNotEmpty);
    await _api.deleteRoutine(id);
    _routines.removeWhere((r) => r.id == id);
    return _routines;
  }

  @override
  Future<List<Routine>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Routine?> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<Routine>> update(Routine data) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<void> clear() async {
    await _api.clear();
    _routines.clear();
  }
}
