import 'dart:async';

import 'package:lfti_api/src/routines/interface/base_repository.dart';
import 'package:lfti_api/src/routines/models/routine.dart';

class RoutineRepository implements BaseRepository<Routine, Routine?> {
  static final RoutineRepository _instance = RoutineRepository._internal();
  factory RoutineRepository() => _instance;
  RoutineRepository._internal();

  @override
  Future<bool> add(Routine data) async {
    assert(data.id.isNotEmpty);

    return true;
  }

  @override
  Future<bool> delete(String id) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Routine>> getAll() async {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Routine?> getById(String id) async {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Routine data) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
