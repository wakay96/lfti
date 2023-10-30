import 'dart:async';

import 'package:routines_api/src/interface/base_repository.dart';
import 'package:routines_api/src/models/routine.dart';

class RoutineRepository implements BaseRepository<Routine, Routine?> {
  static final RoutineRepository _instance = RoutineRepository._internal();
  factory RoutineRepository() => _instance;
  RoutineRepository._internal();

  @override
  Future<bool> add(Routine data) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
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
  Future<bool> update(Routine data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
