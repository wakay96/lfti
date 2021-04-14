import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/repository/i_repository.dart';

class SessionScreenProvider extends ChangeNotifier {
  bool editMode = false;
  Session? selectedSession;
  late List<Session> sessions = [];
  late IRepository repo;

  void initialize(BuildContext context) {
    repo = GetIt.instance<IRepository>();
    this.sessions = repo.getAllSessions();
    notifyListeners();
  }

  void toggleSelectedSession(String id) {
    Session session;
    try {
      session = sessions.firstWhere((item) => item.id == id);
      selectedSession = session;
    } catch (e) {
      selectedSession = null;
    }
    notifyListeners();
  }

  void resetSelectedSession() {
    selectedSession = null;
    notifyListeners();
  }

  bool isSelectedSession(String? id) {
    if (selectedSession != null) {
      return id == selectedSession?.id;
    }
    return false;
  }

  void startSession(BuildContext context) {
    print('start session');
  }
}
